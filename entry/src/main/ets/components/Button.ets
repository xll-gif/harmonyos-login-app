/**
 * 通用登录按钮组件
 *
 * 基于设计稿样式：
 * - 背景色: #007AFF
 * - 文字颜色: #FFFFFF
 * - 圆角: 4.vp
 * - 高度: 44.vp
 *
 * 使用规则：
 * 1. 主要操作按钮使用 variant: ButtonVariant.Primary（默认）
 * 2. 次要操作按钮使用 variant: ButtonVariant.Secondary
 * 3. 危险操作按钮使用 variant: ButtonVariant.Danger
 * 4. 禁用状态设置 enabled: false
 * 5. 按钮宽度建议使用固定宽度（如 300.vp）或宽度自适应
 * 6. 按钮高度固定为 44.vp
 *
 * @param title 按钮文字
 * @param variant 按钮样式变体（默认：ButtonVariant.Primary）
 * @param enabled 是否可用（默认：true）
 * @param width 按钮宽度（默认：null，宽度自适应）
 * @param height 按钮高度（默认：44）
 * @param onClick 点击事件
 */
@CustomDialog
@Component
export struct Button {
  @Prop title: string = ''
  @Prop variant: ButtonVariant = ButtonVariant.Primary
  @Prop enabled: boolean = true
  @Prop width?: number
  @Prop height: number = 44
  onClick: () => void = () => {}

  build() {
    Button(this.title)
      .enabled(this.enabled)
      .width(this.width ?? '100%')
      .height(this.height)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.getContentColor())
      .backgroundColor(this.getBackgroundColor())
      .borderRadius(4)
      .border(this.getBorderWidth())
      .borderColor(this.getBorderColor())
      .opacity(this.enabled ? 1 : 0.5)
      .onClick(() => {
        if (this.enabled) {
          this.onClick()
        }
      })
  }

  /**
   * 获取按钮背景色
   */
  private getBackgroundColor(): ResourceColor {
    if (!this.enabled) {
      return '#E5E5E5'
    }
    switch (this.variant) {
      case ButtonVariant.Primary:
        return '#007AFF'
      case ButtonVariant.Secondary:
        return '#FFFFFF'
      case ButtonVariant.Danger:
        return '#FF3B30'
      default:
        return '#007AFF'
    }
  }

  /**
   * 获取按钮文字颜色
   */
  private getContentColor(): ResourceColor {
    if (!this.enabled) {
      return '#999999'
    }
    switch (this.variant) {
      case ButtonVariant.Primary:
        return '#FFFFFF'
      case ButtonVariant.Secondary:
        return '#007AFF'
      case ButtonVariant.Danger:
        return '#FFFFFF'
      default:
        return '#FFFFFF'
    }
  }

  /**
   * 获取边框颜色
   */
  private getBorderColor(): ResourceColor {
    if (!this.enabled) {
      return '#DDDDDD'
    }
    switch (this.variant) {
      case ButtonVariant.Secondary:
        return '#007AFF'
      default:
        return Color.Transparent
    }
  }

  /**
   * 获取边框宽度
   */
  private getBorderWidth(): Length {
    switch (this.variant) {
      case ButtonVariant.Secondary:
        return 1
      default:
        return 0
    }
  }
}

/**
 * 按钮样式变体枚举
 */
export enum ButtonVariant {
  /** 主要按钮（蓝色背景，白色文字） */
  Primary,
  
  /** 次要按钮（白色背景，蓝色文字，蓝色边框） */
  Secondary,
  
  /** 危险按钮（红色背景，白色文字） */
  Danger
}
