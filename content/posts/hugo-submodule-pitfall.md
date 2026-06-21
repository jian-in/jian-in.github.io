---
title: "Hugo 博客踩坑：submodule 导致 GitHub Actions 构建失败"
date: 2026-06-21
draft: false
tags: ["Hugo", "踩坑", "GitHub Actions"]
categories: ["技术"]
summary: "PaperMod 主题作为 submodule 残留导致 CI 构建时主题目录为空，所有 HTML 页面无法生成"
---

## 问题现象

博客部署到 GitHub Pages 后，打开网站发现首页显示的不是正常的 HTML 页面，而是一堆 RSS 的 XML 源码。用浏览器开发者工具一看，`Content-Type` 居然是 `application/xml`，所有的 HTML 页面都返回 404。

奇怪的是 `index.xml`（RSS）和 `sitemap.xml` 都正常，CSS 文件也能访问，唯独所有 `.html` 文件全部缺失。

## 排查过程

一开始以为是 GitHub Pages 的配置问题，检查了 Pages 的部署源确认是 GitHub Actions，DNS 也没问题。

后来在 workflow 里加了一个验证步骤，列出 `public/` 目录的内容，这才发现 CI 上 Hugo 构建出来的文件里根本没有 HTML：

```
❌ index.html 缺失!
✅ index.xml 存在 (2940 bytes)
❌ index.json 缺失!
✅ sitemap.xml 存在 (1775 bytes)
❌ 404.html 缺失!
```

再看 Hugo 构建的日志，有一堆警告：

```
WARN  found no layout file for "html" for kind "page"
WARN  found no layout file for "html" for kind "term"
WARN  found no layout file for "html" for kind "section"
```

Hugo 找不到任何主题模板文件！

## 根本原因

用 `git ls-tree HEAD themes/PaperMod` 查看，发现 PaperMod 主题在 git 中的记录是：

```
160000 commit 154d006e0182dfc7da38008323976b02e6bfab4a	themes/PaperMod
```

`160000` 是 gitlink（submodule）的模式。也就是说 PaperMod 主题在 git 里一直被当成 submodule 来管理。

但是项目里的 `.gitmodules` 文件早就被删掉了，所以 GitHub Actions 在 checkout 代码的时候，无法解析这个 submodule，`themes/PaperMod/` 目录就是空的。Hugo 找不到模板，自然也就生成不了任何 HTML 页面。

RSS 和 sitemap 之所以能生成，是因为 Hugo 内置了这些输出格式的默认模板，不依赖主题。

## 解决方法

把 PaperMod 从 submodule 转为普通目录：

```bash
# 1. 从 git 索引中移除 submodule 条目（不删除本地文件）
git rm --cached themes/PaperMod

# 2. 删除主题目录内的 .git（如果有的话）
# Windows 下可以手动删除或移动走
rm -rf themes/PaperMod/.git

# 3. 将主题文件作为普通文件添加
git add themes/PaperMod/

# 4. 提交并推送
git commit -m "将 PaperMod 主题从 submodule 转为普通目录"
git push origin master
```

推送后 GitHub Actions 重新构建，HTML 页面全部正常生成，网站恢复正常。

## 经验教训

- 如果用 `git submodule add` 添加过主题，后来想改成普通目录，不能只删 `.gitmodules`，还要用 `git rm --cached` 清除索引中的 gitlink 记录
- 在 CI 流程中加一个构建产物验证步骤很有用，能快速定位问题
- 如果不想折腾 submodule，建议一开始就把主题文件直接放进仓库
