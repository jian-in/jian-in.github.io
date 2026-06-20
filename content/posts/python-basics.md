---
title: "Python学习笔记：从零开始"
date: 2026-06-15T12:00:00+08:00
tags: ["Python", "教程", "入门"]
categories: ["编程"]
summary: "Python入门基础，变量、条件判断、循环"
draft: false
---

## Python 是什么？

Python 是一门简洁优雅的编程语言，适合初学者入门。它被广泛应用于：

- 🌐 Web 开发（Django、Flask）
- 📊 数据分析（Pandas、NumPy）
- 🤖 机器学习（TensorFlow、PyTorch）
- 🔧 自动化脚本

## 第一个程序

```python
print("Hello, World!")
```

运行结果：

```
Hello, World!
```

## 变量与数据类型

```python
name = "小明"        # 字符串 str
age = 20             # 整数 int
height = 175.5       # 浮点数 float
is_student = True    # 布尔值 bool

# 打印变量
print(f"我叫{name}，今年{age}岁")
```

## 条件判断

```python
score = 85

if score >= 90:
    print("优秀")
elif score >= 60:
    print("及格")
else:
    print("继续加油")
```

## 循环

```python
# for 循环
for i in range(5):
    print(f"第 {i+1} 次循环")

# while 循环
count = 0
while count < 3:
    print(f"count = {count}")
    count += 1

# 列表推导式
squares = [x**2 for x in range(10)]
print(squares)  # [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
```

## 函数

```python
def greet(name):
    """打个招呼"""
    return f"你好，{name}！"

message = greet("Python学习者")
print(message)  # 你好，Python学习者！
```

## 字典

```python
student = {
    "name": "小明",
    "age": 20,
    "major": "计算机科学"
}

# 遍历字典
for key, value in student.items():
    print(f"{key}: {value}")
```

## 📚 学习资源

| 资源 | 链接 | 说明 |
|------|------|------|
| Python 官方文档 | python.org | 最权威 |
| 菜鸟教程 | runoob.com | 中文友好 |
| LeetCode | leetcode.cn | 刷题练手 |

---

**下一篇预告**: Python 面向对象编程 🔜