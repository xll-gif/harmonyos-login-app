# InputField 组件使用规则

## 组件说明

通用输入框组件，基于设计稿样式实现，使用 ArkTS + ArkUI 构建。

## 设计稿样式规范

- **边框颜色**: `#DDDDDD`（浅灰色）
- **边框宽度**: `1.vp`
- **圆角**: `4.vp`
- **宽度**: `300.vp`（可根据容器调整）
- **高度**: `40.vp`（固定）
- **文字大小**: `16.fp`
- **文字颜色**: `#333333`
- **占位符颜色**: `#999999`
- **内边距**: `12.vp`

## API 文档

### 函数签名

```typescript
@Component
export struct InputField {
  @Prop title: string = ''
  @Prop placeholder: string = ''
  @Link text: string
  @Prop keyboardType: InputType = InputType.Normal
  @Prop isPassword: boolean = false
  @Prop enabled: boolean = true
  @Prop isError: boolean = false
  @Prop errorMessage: string = ''
  @Prop width?: number
  @Prop height: number = 40
  @Prop padding: number = 12
}
```

### 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|-----|------|--------|------|
| `title` | `string` | `''` | 输入框标题 |
| `placeholder` | `string` | `''` | 占位符（必填） |
| `text` | `string` | `''` | 输入值绑定（必填，需使用 @Link） |
| `keyboardType` | `InputType` | `InputType.Normal` | 键盘类型 |
| `isPassword` | `boolean` | `false` | 是否密码输入 |
| `enabled` | `boolean` | `true` | 是否启用 |
| `isError` | `boolean` | `false` | 是否有错误 |
| `errorMessage` | `string` | `''` | 错误提示 |
| `width` | `number \| undefined` | `undefined` | 输入框宽度，undefined 表示宽度自适应 |
| `height` | `number` | `40` | 输入框高度（建议保持默认） |
| `padding` | `number` | `12` | 内边距 |

### InputType 枚举

| 值 | 说明 |
|---|------|
| `InputType.Normal` | 默认键盘 |
| `InputType.Number` | 数字键盘 |
| `InputType.Email` | 邮箱键盘 |
| `InputType.Phone` | 电话键盘 |
| `InputType.Password` | 密码键盘 |

## 使用规则

### 1. 基础输入框

```typescript
@State email: string = ''

InputField({
  placeholder: '请输入邮箱',
  text: $email,
  keyboardType: InputType.Email,
  width: 300
})
```

### 2. 带标题的输入框

```typescript
@State password: string = ''

InputField({
  title: '密码',
  placeholder: '请输入密码',
  text: $password,
  isPassword: true,
  width: 300
})
```

### 3. 错误状态

```typescript
@State email: string = ''
@State isError: boolean = false

InputField({
  title: '邮箱',
  placeholder: '请输入邮箱',
  text: $email,
  isError: this.isError,
  errorMessage: '邮箱格式不正确',
  width: 300
})
```

### 4. 禁用状态

```typescript
@State disabledText: string = '已禁用'

InputField({
  placeholder: '禁用状态',
  text: $disabledText,
  enabled: false,
  width: 300
})
```

### 5. 手机号输入

```typescript
@State phone: string = ''

InputField({
  title: '手机号',
  placeholder: '请输入手机号',
  text: $phone,
  keyboardType: InputType.Phone,
  width: 300
})
```

### 6. 数字输入

```typescript
@State amount: string = ''

InputField({
  title: '金额',
  placeholder: '请输入金额',
  text: $amount,
  keyboardType: InputType.Number,
  width: 300
})
```

### 7. 使用 @State 管理状态

```typescript
@Entry
@Component
struct LoginPage {
  @State email: string = ''
  @State password: string = ''

  build() {
    Column({ space: 20 }) {
      InputField({
        title: '邮箱',
        placeholder: '请输入邮箱',
        text: $email,
        keyboardType: InputType.Email,
        width: 300
      })

      InputField({
        title: '密码',
        placeholder: '请输入密码',
        text: $password,
        isPassword: true,
        width: 300
      })
    }
    .padding(16)
  }
}
```

## 布局建议

### 垂直表单布局

```typescript
Column({ space: 16 }) {
  InputField({
    title: '邮箱',
    placeholder: '请输入邮箱',
    text: $email,
    keyboardType: InputType.Email,
    width: 300
  })

  InputField({
    title: '密码',
    placeholder: '请输入密码',
    text: $password,
    isPassword: true,
    width: 300
  })
}
.padding(16)
```

### 错误验证流程

```typescript
function validateEmail(email: string): boolean {
  const emailRegex = /^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$/
  return emailRegex.test(email)
}

function handleSubmit() {
  if (!validateEmail(this.email)) {
    this.isError = true
    this.errorMessage = '邮箱格式不正确'
  } else {
    // 提交逻辑
  }
}
```

## 禁止事项

1. ❌ 不要使用非设计稿规范的颜色
2. ❌ 不要修改输入框高度（除非有特殊需求）
3. ❌ 不要在占位符中使用特殊符号
4. ❌ 不要嵌套输入框
5. ❌ 不要使用 `@State` 修饰 `text`（必须使用 `@Link`）
6. ❌ 不要同时使用错误状态和禁用状态（除非业务需要）

## 鸿蒙设计规范兼容性

- 符合鸿蒙人机交互指南（HIG）
- 使用 `vp`（虚拟像素）单位，确保不同设备上的一致性
- 支持深色模式（需要额外适配）

## 版本历史

- v1.0.0 (2026-02-27): 初始版本，基于设计稿创建
