#!/bin/bash

# JRun 全栈应用启动脚本
# 同时启动前端(JRun-Web)和后端(JRun-Server)服务

echo "🚀 开始启动 JRun 全栈应用..."

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查是否已安装 Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}错误: 未找到 Node.js，请先安装 Node.js${NC}"
    exit 1
fi

# 检查是否已安装 npm
if ! command -v npm &> /dev/null; then
    echo -e "${RED}错误: 未找到 npm，请先安装 Node.js${NC}"
    exit 1
fi

# 检查是否已安装 Maven
if ! command -v mvn &> /dev/null; then
    echo -e "${RED}错误: 未找到 Maven，请先安装 Maven${NC}"
    exit 1
fi

# 检查是否已安装 Java
if ! command -v java &> /dev/null; then
    echo -e "${RED}错误: 未找到 Java，请先安装 Java${NC}"
    exit 1
fi

# 设置工作目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "📁 项目根目录: $PROJECT_ROOT"

# 启动后端服务函数
start_backend() {
    cd "$PROJECT_ROOT/JRun-Server"
    echo -e "${YELLOW}正在启动后端服务...${NC}"
    
    # 编译并启动后端应用
    echo "🔨 编译后端项目..."
    if mvn clean package -DskipTests; then
        echo -e "${GREEN}后端编译成功，启动应用...${NC}"
        java -jar target/jrun-server-1.0.0.jar
    else
        echo -e "${RED}后端编译失败，请检查错误信息${NC}"
        exit 1
    fi
}

# 启动前端服务函数
start_frontend() {
    cd "$PROJECT_ROOT/JRun-Web"
    echo -e "${YELLOW}正在启动前端服务...${NC}"
    
    # 安装依赖并启动前端开发服务器
    echo "📦 安装前端依赖..."
    if npm install; then
        echo -e "${GREEN}前端依赖安装成功，启动开发服务器...${NC}"
        npm run dev
    else
        echo -e "${RED}前端依赖安装失败，请检查错误信息${NC}"
        exit 1
    fi
}

# 启动后端服务（在后台运行）
echo -e "${GREEN}启动后端服务进程...${NC}"
cd "$PROJECT_ROOT/JRun-Server"
if mvn clean package -DskipTests; then
    echo -e "${GREEN}后端编译成功，启动应用...${NC}"
    java -jar target/jrun-server-1.0.0.jar > backend.log 2>&1 &
    BACKEND_PID=$!
    echo -e "${GREEN}后端服务已启动，PID: $BACKEND_PID${NC}"
else
    echo -e "${RED}后端编译失败，请检查错误信息${NC}"
    exit 1
fi

# 等待一段时间让后端服务启动
echo "⏳ 等待后端服务启动..."
sleep 5

# 启动前端服务
echo -e "${GREEN}启动前端服务进程...${NC}"
cd "$PROJECT_ROOT/JRun-Web"

if npm install; then
    echo -e "${GREEN}前端依赖安装成功，启动开发服务器...${NC}"
    npm run dev > frontend.log 2>&1 &
    FRONTEND_PID=$!
    echo -e "${GREEN}前端服务已启动，PID: $FRONTEND_PID${NC}"
else
    echo -e "${RED}前端依赖安装失败，请检查错误信息${NC}"
    # 如果前端启动失败，尝试终止后端进程
    kill $BACKEND_PID 2>/dev/null
    exit 1
fi

# 显示服务状态
echo -e "${GREEN}🎉 JRun 全栈应用启动成功!${NC}"
echo -e "${GREEN}🌐 前端服务: http://localhost:3000${NC}"
echo -e "${GREEN}⚙️  后端服务: http://localhost:8080${NC}"

# 显示进程ID
echo -e "${YELLOW}📋 进程信息:${NC}"
echo -e "${YELLOW}   后端 PID: $BACKEND_PID${NC}"
echo -e "${YELLOW}   前端 PID: $FRONTEND_PID${NC}"

# 提供停止服务的说明
echo -e "${YELLOW}📝 要停止服务，请执行: kill $BACKEND_PID $FRONTEND_PID${NC}"

# 等待所有后台进程完成
wait $BACKEND_PID $FRONTEND_PID