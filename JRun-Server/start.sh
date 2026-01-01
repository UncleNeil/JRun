#!/bin/bash

# JRun Server 启动脚本

echo "正在启动 JRun 后端服务..."

# 检查是否已安装 Maven
if ! command -v mvn &> /dev/null; then
    echo "错误: 未找到 Maven，请先安装 Maven"
    exit 1
fi

# 检查是否已安装 Java
if ! command -v java &> /dev/null; then
    echo "错误: 未找到 Java，请先安装 Java"
    exit 1
fi

# 编译并启动应用
echo "编译项目..."
mvn clean package -DskipTests

if [ $? -eq 0 ]; then
    echo "编译成功，启动应用..."
    java -jar target/jrun-server-1.0.0.jar
else
    echo "编译失败，请检查错误信息"
    exit 1
fi