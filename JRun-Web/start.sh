#!/bin/bash

# JRun Web 前端启动脚本

echo "正在启动 JRun 前端服务..."

# 检查是否已安装 Node.js
if ! command -v node &> /dev/null; then
    echo "错误: 未找到 Node.js，请先安装 Node.js"
    exit 1
fi

# 检查是否已安装 npm
if ! command -v npm &> /dev/null; then
    echo "错误: 未找到 npm，请先安装 Node.js"
    exit 1
fi

# 安装依赖
echo "安装前端依赖..."
npm install

if [ $? -eq 0 ]; then
    echo "依赖安装成功，启动前端开发服务器..."
    npm run dev
else
    echo "依赖安装失败，请检查错误信息"
    exit 1
fi