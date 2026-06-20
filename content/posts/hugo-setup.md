---
title: "用 Hugo 搭建个人博客的完整指南"
date: 2026-06-14T12:00:00+08:00
tags: ["Hugo", "博客", "教程"]
categories: ["技术"]
summary: "从零开始用 Hugo 搭建一个静态博客"
draft: false
---

## 为什么要用 Hugo？

Hugo 是目前最快的静态网站生成器之一，特点：

- ⚡ 构建速度极快（1000篇文章只需1秒）
- 🎨 丰富的主题生态
- 🆓 完全免费开源
- 🚀 部署简单

## 安装 Hugo

### Windows

```bash
choco install hugo-extended
```

### macOS

```bash
brew install hugo
```

### 验证安装

```bash
hugo version
```

## 创建博客

```bash
# 创建新站点
hugo new site my-blog
cd my-blog

# 下载主题（以 PaperMod 为例）
git submodule add https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
```

## 配置文件

编辑 `hugo.toml`：

```toml
baseURL = 'https://你的域名/'
languageCode = 'zh-cn'
title = '我的博客'
theme = 'PaperMod'

[params]
  author = '你的名字'
  defaultTheme = 'auto'
```

## 写文章

```bash
# 创建新文章
hugo new content posts/my-first-post.md
```

然后编辑 `content/posts/my-first-post.md`：

```markdown
---
title: "我的第一篇文章"
date: 2026-06-16
tags: ["入门"]
draft: false
---

正文内容...
```

## 本地预览

```bash
hugo server -D
```

浏览器访问 `http://localhost:1313` 即可预览。

## 构建与部署

```bash
# 构建静态文件
hugo --minify

# public/ 目录就是生成的静态文件
```

## 部署到 GitHub Pages

1. 创建 GitHub 仓库（`用户名.github.io`）
2. 将 `public/` 目录推送到仓库
3. 在仓库 Settings → Pages 中开启
4. 等待 GitHub 签发 HTTPS 证书

---

这就是搭建一个 Hugo 博客的完整流程，整个过程不到10分钟！