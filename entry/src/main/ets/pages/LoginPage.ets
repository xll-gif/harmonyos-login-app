/**
 * 登录页面
 * 功能：邮箱/密码登录，实时表单验证，错误提示，加载状态
 */

import { Button, ButtonVariant } from '../components/Button'
import { InputField } from '../components/InputField'
import {
  LoginErrorType,
  LoginErrorMessages,
  LoginRequest,
  MockLoginService
} from '../services/LoginAPI'

@Entry
@Component
struct LoginPage {
  // 登录服务
  private loginService: MockLoginService = new MockLoginService()

  // 表单状态
  @State email: string = ''
  @State password: string = ''
  @State showPassword: boolean = false

  // 验证状态
  @State emailError: string = ''
  @State passwordError: string = ''
  @State submitError: string = ''

  // 加载状态
  @State isLoading: boolean = false

  // 路由跳转
  @State isLoginSuccess: boolean = false

  aboutToAppear() {
    // 检查登录状态
    const token = AppStorage.get('token')
    if (token) {
      this.isLoginSuccess = true
    }
  }

  build() {
    if (this.isLoginSuccess) {
      // 跳转到首页
      HomePage({
        onLogout: () => {
          this.isLoginSuccess = false
          AppStorage.set('token', '')
          AppStorage.set('userId', '')
        }
      })
    } else {
      // 显示登录页
      Column() {
        // Logo
        this.LogoView()

        // 标题
        Text('登录')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ top: 16, bottom: 16 })

        // 表单
        Column({ space: 16 }) {
          // 邮箱输入框
          InputField({
            title: '邮箱',
            placeholder: '请输入邮箱地址',
            value: this.email,
            isError: this.emailError !== '',
            errorMessage: this.emailError,
            onChange: (value: string) => {
              this.email = value
              this.validateEmail(value)
            }
          })

          // 密码输入框
          InputField({
            title: '密码',
            placeholder: '请输入密码',
            value: this.password,
            isPassword: !this.showPassword,
            isError: this.passwordError !== '',
            errorMessage: this.passwordError,
            onChange: (value: string) => {
              this.password = value
              this.validatePassword(value)
            }
          })

          // 密码显示/隐藏切换
          Row() {
            Spacer()
            Button({
              title: this.showPassword ? '隐藏密码' : '显示密码',
              variant: ButtonVariant.Secondary,
              width: 120,
              height: 36,
              onClick: () => {
                this.showPassword = !this.showPassword
              }
            })
          }
          .width('100%')

          // 登录按钮
          Button({
            title: this.isLoading ? '登录中...' : '登录',
            enabled: this.isFormValid() && !this.isLoading,
            onClick: () => {
              this.handleLogin()
            }
          })

          // 提交错误提示
          if (this.submitError !== '') {
            Text(this.submitError)
              .fontSize(14)
              .fontColor('#FF3B30')
              .width('100%')
              .padding(12)
              .backgroundColor('#FFF5F5')
              .borderRadius(4)
          }
        }
        .width('100%')

        Spacer()

        // 辅助链接
        Column({ space: 12 }) {
          Button({
            title: '忘记密码？',
            variant: ButtonVariant.Secondary,
            width: 200,
            onClick: () => {
              // 跳转到找回密码页面
            }
          })

          Row({ space: 4 }) {
            Text('还没有账号？')
              .fontSize(14)
              .fontColor('#666666')

            Button({
              title: '立即注册',
              variant: ButtonVariant.Secondary,
              width: 60,
              onClick: () => {
                // 跳转到注册页面
              }
            })
          }
        }

        // 测试账号提示
        this.TestAccountsView()
      }
      .width('100%')
      .height('100%')
      .padding(20)
      .backgroundColor('#FFFFFF')
    }
  }

  /**
   * Logo 视图
   */
  @Builder LogoView() {
    Stack() {
      Circle()
        .width(80)
        .height(80)
        .fill(LinearGradient({
          angle: 45,
          colors: [['#007AFF', 0.0], ['#5AC8FA', 1.0]]
        }))
        .shadow({ radius: 4, color: '#000000', offsetX: 0, offsetY: 4 })

      Text('L')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
    }
  }

  /**
   * 测试账号视图
   */
  @Builder TestAccountsView() {
    Column({ space: 8 }) {
      Text('测试账号：')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#666666')

      Text('邮箱: test@example.com / 密码: password123')
        .fontSize(12)
        .fontColor('#999999')

      Text('邮箱: admin@example.com / 密码: admin123')
        .fontSize(12)
        .fontColor('#999999')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(8)
    .margin({ top: 20 })
  }

  /**
   * 验证邮箱
   */
  validateEmail(email: string) {
    if (email === '') {
      this.emailError = ''
    } else if (!this.loginService.validateEmail(email)) {
      this.emailError = LoginErrorMessages[LoginErrorType.INVALID_EMAIL]
    } else {
      this.emailError = ''
    }
  }

  /**
   * 验证密码
   */
  validatePassword(password: string) {
    if (password === '') {
      this.passwordError = ''
    } else {
      const result = this.loginService.validatePassword(password)
      this.passwordError = result.error || ''
    }
  }

  /**
   * 判断表单是否有效
   */
  isFormValid(): boolean {
    return this.email !== '' &&
           this.password !== '' &&
           this.emailError === '' &&
           this.passwordError === ''
  }

  /**
   * 处理登录
   */
  async handleLogin() {
    // 清除之前的提交错误
    this.submitError = ''

    // 表单验证
    if (!this.isFormValid()) {
      return
    }

    // 开始加载
    this.isLoading = true

    try {
      const request: LoginRequest = {
        email: this.email,
        password: this.password
      }

      const response = await this.loginService.login(request)

      if (response.code === 200 && response.data) {
        // 登录成功
        console.info('登录成功:', JSON.stringify(response.data))

        // 保存 Token 到 AppStorage
        AppStorage.set('token', response.data.token)
        AppStorage.set('userId', response.data.userId)

        // 跳转到首页
        this.isLoginSuccess = true
      } else {
        // 登录失败
        this.submitError = response.message || '登录失败，请重试'
      }
    } catch (error) {
      // 网络错误
      console.error('登录失败:', error)
      this.submitError = LoginErrorMessages[LoginErrorType.NETWORK_ERROR]
    } finally {
      // 结束加载
      this.isLoading = false
    }
  }
}

/**
 * 首页组件
 */
@Component
struct HomePage {
  onLogout: () => void = () => {}

  build() {
    Column({ space: 24 }) {
      // Logo
      Stack() {
        Circle()
          .width(80)
          .height(80)
          .fill(LinearGradient({
            angle: 45,
            colors: [['#007AFF', 0.0], ['#5AC8FA', 1.0]]
          }))
          .shadow({ radius: 4, color: '#000000', offsetX: 0, offsetY: 4 })

        Text('H')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }

      // 标题
      Text('首页')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      // 欢迎信息
      Text(`欢迎回来，${AppStorage.get('userId') || '未知用户'}`)
        .fontSize(16)
        .fontColor('#666666')

      // 登出按钮
      Button({
        title: '退出登录',
        onClick: () => {
          this.onLogout()
        }
      })
        .width(300)

      Spacer()

      // 功能列表
      Column({ space: 16 }) {
        Text('更多功能开发中...')
          .fontSize(14)
          .fontColor('#999999')
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
  }
}
