# AutoChat 项目结构说明

## 目录结构

```
AutoChat/
├── Models/          # 数据模型
│   ├── Chat/       # 对话相关模型
│   └── User/       # 用户相关模型
├── Views/          # 视图层
│   ├── Chat/       # 对话界面
│   ├── Settings/   # 设置界面
│   └── Common/     # 通用组件
├── ViewModels/     # 视图模型
│   ├── Chat/       # 对话相关ViewModel
│   └── Settings/   # 设置相关ViewModel
├── Services/       # 服务层
│   ├── Network/    # 网络服务
│   ├── Storage/    # 数据存储
│   └── AI/         # AI服务
├── Utils/          # 工具类
│   ├── Extensions/ # 扩展
│   └── Helpers/    # 辅助工具
└── Resources/      # 资源文件
    └── Assets/     # 素材资源
```

## 架构说明

本项目采用MVVM架构模式，主要分为以下几层：

1. Models层：负责数据模型定义
2. Views层：负责UI展示
3. ViewModels层：负责业务逻辑
4. Services层：负责底层服务

### 依赖方向

Views -> ViewModels -> Models
ViewModels -> Services

### 文件命名规范

- 模型类：名词 + Model（ChatModel）
- 视图类：名词 + View（ChatView）
- 视图模型：名词 + ViewModel（ChatViewModel）
- 服务类：名词 + Service（NetworkService）

### 代码规范

- 使用SwiftUI构建界面
- 使用Combine进行响应式编程
- 使用Swift并发特性处理异步操作


日志：
已完成MVVM架构代码的Git提交和推送工作：

- 使用git add .命令将所有更改添加到暂存区
- 使用git commit提交更改，提交信息为"feat:建立MVVM架构"
- 使用git push将本地提交推送到远程仓库
项目现已建立了完整的MVVM架构，包含以下核心目录：

- Models：数据模型层
- Views：视图层
- ViewModels：视图模型层
- Services：服务层

已完成开发环境的基础配置工作，主要包括：

- 环境配置（Environment.swift）：
  
  - 实现了开发（development）、预发（staging）和生产（production）三个环境
  - 根据编译条件（DEBUG）自动切换环境
  - 为每个环境配置了对应的API基础URL和AI模型接口
  - 设置了不同环境的日志级别
- 网络服务配置（NetworkService.swift）：
  
  - 实现了基础的网络请求服务
  - 配置了请求超时时间
  - 支持常规数据请求和流式数据请求
  - 实现了错误处理机制

  已完成网络层封装的主要任务：

1. 检查并确认了现有的NetworkService实现，它已经提供了基础的HTTP请求功能和流式数据处理能力，使用了Combine框架实现响应式编程。
2. 实现了WebSocketService类，提供了以下功能：
- WebSocket连接的建立和断开
- 消息的发送和接收
- 错误处理机制
- 消息处理回调
3. 实现了NetworkMonitor类，提供了以下功能：
- 实时监控网络连接状态
- 识别网络连接类型（WiFi、蜂窝网络、以太网）
- 网络状态变化通知机制
- 异步状态更新处理

已完成AI API接口定义和集成的任务：

- 创建了AIService类，实现了与OpenAI API的集成
- 定义了核心数据模型：ChatMessage、ChatRequest和ChatResponse
- 实现了两种消息发送方式：
  - 普通消息发送（sendMessage）支持基本的请求-响应模式
  - 流式消息发送（sendMessageStream）支持实时数据流
- 集成了现有的NetworkService进行底层网络请求
- 支持可配置的模型参数（如temperature）和自定义模型选择
- 预留了API密钥的安全配置接口


已完成数据持久化的基础开发工作：

- 设计并创建了CoreData数据模型，包含ChatSession和Message两个实体
- 实现了CoreDataManager单例类，封装了所有的数据持久化操作
- 完成了会话和消息的CRUD操作封装
- 建立了会话和消息之间的一对多关系
- 实现了数据的自动保存和错误处理机制
数据模型的主要特点：

- ChatSession实体包含id、title、createdAt、updatedAt属性
- Message实体包含id、content、createdAt、isUserMessage属性
- 建立了双向关系，确保数据完整性
- 实现了级联删除，当会话被删除时自动删除相关消息

已完成数据迁移方案的开发，主要实现了以下功能：

- 创建了 CoreDataMigrationManager 单例类，负责处理所有数据迁移相关操作
- 实现了轻量级迁移配置，支持自动迁移和自动推断映射模型
- 开发了完整的数据迁移流程，包括：
  - 创建迁移管理器和映射模型
  - 使用临时存储进行安全迁移
  - 自动备份原始数据
  - 迁移完成后的清理工作
- 添加了数据备份和恢复功能，确保数据安全
  - 支持创建时间戳备份
  - 提供从备份恢复的能力