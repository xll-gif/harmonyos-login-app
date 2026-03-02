# 鸿蒙登录应用

## 项目概述
基于 ArkTS + ArkUI 实现的企业级登录应用，支持多端联调。

## 技术栈
- **语言**: ArkTS (TypeScript 超集)
- **UI 框架**: ArkUI (声明式 UI)
- **最低支持版本**: API 9 (HarmonyOS 3.0)
- **目标版本**: API 12 (HarmonyOS 4.0)
- **架构模式**: MVVM
- **开发工具**: DevEco Studio

## 功能特性
- 用户登录（用户名/密码）
- 表单验证
- 加载状态提示
- 错误处理
- Mock 数据联调支持

## 项目结构
```
harmonyos-login-app/
├── entry/
│   ├── src/
│   │   ├── main/
│   │   │   ├── ets/
│   │   │   │   ├── entryability/
│   │   │   │   │   └── EntryAbility.ets        # 应用入口
│   │   │   │   ├── pages/
│   │   │   │   │   ├── IndexPage.ets           # 首页
│   │   │   │   │   └── LoginPage.ets           # 登录页面
│   │   │   │   ├── viewmodel/
│   │   │   │   │   └── LoginViewModel.ets      # 登录视图模型
│   │   │   │   ├── components/
│   │   │   │   │   ├── LoginButton.ets         # 登录按钮组件
│   │   │   │   │   ├── LoginInput.ets          # 输入框组件
│   │   │   │   │   └── LoadingView.ets         # 加载提示
│   │   │   │   ├── model/
│   │   │   │   │   ├── LoginRequest.ets        # 登录请求模型
│   │   │   │   │   └── LoginResponse.ets       # 登录响应模型
│   │   │   │   └── service/
│   │   │   │       └── ApiService.ets          # API 服务（支持 Mock）
│   │   │   ├── resources/
│   │   │   │   ├── base/
│   │   │   │   └── rawfile/                    # 静态资源
│   │   │   └── module.json5
│   │   └── ohosTest/
│   ├── build-profile.json5
│   └── hvigorfile.ts
├── AppScope/
│   ├── app.json5
│   └── hvigorfile.ts
├── build-profile.json5
├── hvigorfile.ts
└── oh-package.json5
```

## 开发说明
- 使用 DevEco Studio 4.0+ 打开项目
- 命令行构建：`hvigorw assembleHap`
- 运行测试：`hvigorw test`

## 组件映射
- 通用按钮 -> ArkUI `Button`
- 通用输入框 -> ArkUI `TextInput`
- 通用图片 -> ArkUI `Image`

## 生成说明
本项目由自动化工作流生成，基于以下输入：
- 需求文档：GitHub Issue
- 设计稿：MasterGo（通过 Magic MCP 集成）
- API 定义：Postman Collection
