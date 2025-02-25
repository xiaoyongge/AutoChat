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