# Button 组件使用规则

## 组件说明

通用登录按钮组件，基于设计稿样式实现，使用 ArkTS + ArkUI 构建。

## 设计稿样式规范

- **背景色**: `#007AFF`（蓝色）
- **文字颜色**: `#FFFFFF`（白色）
- **圆角**: `4.vp`
- **宽度**: `300.vp`（可根据容器调整）
- **高度**: `44.vp`（固定）
- **文字大小**: `16.fp`
- **文字粗细**: `FontWeight.Medium (500)`

## API 文档

### 函数签名

```typescript
@Component
export struct Button {
  @Prop title: string = ''
  @Prop variant: ButtonVariant = ButtonVariant.Primary
  @Prop enabled: boolean = true
  @Prop width?: number
  @Prop height: number = 44
  onClick: () => void = () => {}
}
```

### 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|-----|------|--------|------|
| `title` | `string` | `''` | 按钮文字（必填） |
| `variant` | `ButtonVariant` | `ButtonVariant.Primary` | 按钮样式变体 |
| `enabled` | `boolean` | `true` | 是否可用 |
| `width` | `number \| undefined` | `undefined` | 按钮宽度，undefined 表示宽度自适应 |
| `height` | `number` | `44` | 按钮高度（建议保持默认） |
| `onClick` | `() => void` | `() => {}` | 点击事件回调 |

### ButtonVariant 枚举

| 值 | 说明 | 背景色 | 文字颜色 | 边框 |
|---|---|---|---|---|
| `ButtonVariant.Primary` | 主要按钮（默认） | `#007AFF` | `#FFFFFF` | 无 |
| `ButtonVariant.Secondary` | 次要按钮 | `#FFFFFF` | `#007AFF` | `#007AFF` (1.vp) |
| `ButtonVariant.Danger` | 危险按钮 | `#FF3B30` | `#FFFFFF` | 无 |

## 使用规则

### 1. 主要操作按钮

用于主要操作，如登录、提交、确认等。

```typescript
import { Button, ButtonVariant } from '../components/Button'

Button({
  title: '登录',
  width: 300,
  onClick: () => {
    // 处理登录逻辑
  }
})
```

### 2. 次要操作按钮

用于次要操作，如取消、返回等。

```typescript
Button({
  title: '取消',
  variant: ButtonVariant.Secondary,
  width: 300,
  onClick: () => {
    // 处理取消逻辑
  }
})
```

### 3. 危险操作按钮

用于危险操作，如退出登录、删除等。

```typescript
Button({
  title: '退出登录',
  variant: ButtonVariant.Danger,
  width: 300,
  onClick: () => {
    // 处理退出逻辑
  }
})
```

### 4. 禁用状态

当按钮处于禁用状态时，自动应用禁用样式。

```typescript
Button({
  title: '登录',
  enabled: false,
  width: 300,
  onClick: () => {
    // 不会触发
  }
})
```

### 5. 宽度设置

- **固定宽度**: 使用 `width: 300` 设置固定宽度
- **自适应宽度**: 不设置 `width` 参数，按钮宽度自适应（100%）
- **建议**: 登录页面的操作按钮建议使用固定宽度 `300.vp`

### 6. 高度设置

- 按钮高度固定为 `44.vp`，符合鸿蒙设计规范
- 除非有特殊需求，否则不建议修改高度

### 7. 使用导入

```typescript
import { Button, ButtonVariant } from '../components/Button'
```

## 禁止事项

1. ❌ 不要使用非设计稿规范的颜色
2. ❌ 不要修改按钮高度（除非有特殊需求）
3. ❌ 不要在按钮文字中使用特殊符号（如图标）
4. ❌ 不要嵌套按钮
5. ❌ 不要同时使用 `ButtonVariant.Secondary` 和 `ButtonVariant.Danger`
6. ❌ 不要使用 `@State` 或 `@Prop` 修饰 `onClick` 回调

## 布局建议

### 垂直布局（Column）

```typescript
Column({ space: 16 }) {
  Button({
    title: '登录',
    width: 300,
    onClick: () => {}
  })
  
  Button({
    title: '注册',
    variant: ButtonVariant.Secondary,
    width: 300,
    onClick: () => {}
  })
}
.padding(16)
```

### 水平布局（Row）

```typescript
Row({ space: 16 }) {
  Button({
    title: '取消',
    variant: ButtonVariant.Secondary,
    layoutWeight: 1,
    onClick: () => {}
  })
  
  Button({
    title: '确认',
    layoutWeight: 1,
    onClick: () => {}
  })
}
.width('100%')
.padding(16)
```

## 可访问性

- 按钮文字应简洁明了，不超过 6 个汉字
- 避免使用纯符号或表情符号作为按钮文字
- 禁用状态应有明确的视觉反馈（半透明 + 灰色）

## 鸿蒙设计规范兼容性

- 符合鸿蒙人机交互指南（HIG）
- 使用 `vp`（虚拟像素）单位，确保不同设备上的一致性
- 支持深色模式（需要额外适配）

## 版本历史

- v1.0.0 (2026-02-27): 初始版本，基于设计稿创建
