# JRun 后端项目

JRun 自动化测试平台后端项目，使用 Spring Boot + Spring Security + JWT + JPA 构建。

## 项目结构

```
src/main/java/com/jrun/
├── config/           # 配置类
├── controller/       # 控制器层
├── dto/              # 数据传输对象
├── entity/           # 实体类
├── repository/       # 数据访问层
├── service/          # 业务逻辑层
├── util/             # 工具类
└── JRunApplication.java  # 启动类
```

## 技术栈

- Spring Boot 2.7+
- Spring Security
- JWT (JSON Web Token)
- Spring Data JPA
- MySQL
- Maven

## 安装与启动

### 环境要求

- Java 17+
- Maven 3.6+
- MySQL 8.0+

### 启动步骤

1. 创建数据库
```sql
CREATE DATABASE jrun CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. 修改 `src/main/resources/application.properties` 中的数据库连接信息

3. 启动应用
```bash
# 方法1: 使用启动脚本
./start.sh

# 方法2: 使用 Maven
mvn spring-boot:run
```

## API 接口

### 认证接口

- `POST /api/auth/register` - 用户注册
- `POST /api/auth/login` - 用户登录
- `GET /api/test` - 测试接口

### 请求示例

注册请求:
```json
{
  "username": "testuser",
  "email": "test@example.com",
  "password": "password123",
  "nickname": "Test User"
}
```

登录请求:
```json
{
  "username": "testuser",
  "password": "password123"
}
```

## 项目特性

- JWT 认证
- 用户角色管理
- 输入验证
- 数据库持久化
- RESTful API
- CORS 支持