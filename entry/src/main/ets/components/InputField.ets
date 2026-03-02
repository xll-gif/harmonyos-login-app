/**
 * 通用输入框组件
 *
 * 基于设计稿样式：
 * - 边框: #DDDDDD
 * - 边框宽度: 1.vp
 * - 圆角: 4.vp
 * - 高度: 40.vp
 * - 内边距: 12.vp
 *
 * 使用规则：
 * 1. 默认使用单行文本输入
 * 2. 密码输入设置 type: InputType.Password
 * 3. 邮箱输入设置 type: InputType.Email
 * 4. 输入框宽度建议使用固定宽度（如 300.vp）或宽度自适应
 * 5. 输入框高度固定为 40.vp
 * 6. 错误状态设置 isError: true
 *
 * @param title 输入框标题
 * @param placeholder 占位符（必填）
 * @param text 输入值绑定（必填）
 * @param keyboardType 键盘类型（默认：InputType.Normal）
 * @param isPassword 是否密码输入（默认：false）
 * @param enabled 是否启用（默认：true）
 * @param isError 是否有错误（默认：false）
 * @param errorMessage 错误提示
 * @param width 输入框宽度
 * @param height 输入框高度（默认：40）
 * @param padding 内边距（默认：12）
 */
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

  build() {
    Column({ space: 4 }) {
      // 标题
      if (this.title) {
        Text(this.title)
          .fontSize(14)
          .fontColor('#333333')
          .fontWeight(this.isError ? FontWeight.SemiBold : FontWeight.Regular)
      }

      // 输入框容器
      Row({ space: 8 }) {
        // 错误图标
        if (this.title && this.isError) {
          Image($r('app.media.ic_error'))
            .width(16)
            .height(16)
            .fillColor('#FF3B30')
        }

        // 输入框
        TextInput({
          placeholder: this.placeholder,
          text: this.text
        })
          .enabled(this.enabled)
          .type(this.getInputType())
          .height(this.height)
          .width(this.width ?? '100%')
          .fontSize(16)
          .fontColor('#333333')
          .placeholderColor('#999999')
          .backgroundColor('#FFFFFF')
          .borderRadius(4)
          .border(this.getBorderWidth())
          .borderColor(this.getBorderColor())
          .padding({ left: this.padding, right: this.padding })
          .opacity(this.enabled ? 1 : 0.5)
          .onChange((value: string) => {
            this.text = value
          })
      }

      // 错误提示
      if (this.isError && this.errorMessage) {
        Text(this.errorMessage)
          .fontSize(12)
          .fontColor('#FF3B30')
      }
    }
  }

  /**
   * 获取输入框类型
   */
  private getInputType(): InputType {
    if (this.isPassword) {
      return InputType.Password
    }
    return this.keyboardType
  }

  /**
   * 获取边框颜色
   */
  private getBorderColor(): ResourceColor {
    if (!this.enabled) {
      return '#DDDDDD'
    } else if (this.isError) {
      return '#FF3B30'
    } else {
      return '#DDDDDD'
    }
  }

  /**
   * 获取边框宽度
   */
  private getBorderWidth(): Length {
    return 1
  }
}

/**
 * 键盘类型枚举
 */
export enum InputType {
  /** 默认键盘 */
  Normal,
  /** 数字键盘 */
  Number,
  /** 邮箱键盘 */
  Email,
  /** 电话键盘 */
  Phone,
  /** 密码键盘 */
  Password
}
