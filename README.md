# JRun 自动化测试平台

JRun 是一款支持 Android/iOS 移动端、Web 端自动化测试与接口自动化测试的一体化平台，实现"项目管理→用例编写→设备选择→测试执行→报告查看→告警通知"的全流程闭环，提升测试效率与结果可视化程度。

## 项目结构

```
JRun/
├── JRun-Server/     # 后端项目 (Spring Boot)
├── JRun-Web/        # 前端项目 (Vue 3 + Vite)
├── JRun平台 MVP 版本需求规格说明书（SRS）.md  # 需求文档
├── PLAN.md          # 技术实现计划
└── 整体落地架构.md   # 架构文档
```

## 技术栈

### 后端 (JRun-Server)
- Spring Boot 2.7+
- Spring Security + JWT 认证
- Spring Data JPA
- MySQL
- Maven

### 前端 (JRun-Web)
- Vue 3 + Composition API
- Vue Router 4
- Pinia 状态管理
- Vite 构建工具
- Tailwind CSS + ShadcnUI
- Axios HTTP 客户端

## 快速开始

### 环境准备

1. 安装 Java 17+ 和 Maven 3.6+
2. 安装 Node.js 16+ 和 npm
3. 安装 MySQL 8.0+

### 启动步骤

1. **启动数据库**
```sql
-- 创建数据库
CREATE DATABASE jrun CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. **启动后端服务**
```bash
cd JRun-Server
./start.sh
# 或者使用 Maven
mvn spring-boot:run
```

3. **启动前端服务**
```bash
cd JRun-Web
./start.sh
# 或者使用 npm
npm install
npm run dev
```

### 访问应用

- 前端: http://localhost:3000
- 后端 API: http://localhost:8080
- 后端 API 文档: http://localhost:8080/swagger-ui.html (如果添加了 Swagger)

## 功能模块

根据 PLAN.md 和 SRS.md 文档，当前实现的用户管理模块包括：

- 用户注册/登录
- JWT 认证
- 用户角色管理 (管理员、项目负责人、测试工程师)
- 个人信息维护

## 项目特点

- 前后端分离架构
- JWT + OAuth2.0 双重认证
- 响应式用户界面
- RESTful API 设计
- 数据验证和安全控制

## 开发计划

根据 PLAN.md，后续将实现：
- 项目管理模块
- 设备管理模块
- 自动化用例模块
- 测试执行模块
- 测试报告模块
- 数据分析大屏模块
- 告警通知模块