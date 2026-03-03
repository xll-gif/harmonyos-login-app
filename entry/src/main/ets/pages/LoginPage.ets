// 登录页面
import router from '@ohos.router'

@Entry
@Component
struct LoginPage {
  @State username: string = ''
  @State password: string = ''
  @State isLoading: boolean = false
  @State errorMessage: string = ''

  build() {
    Column() {
      // Logo
      Image($r('app.media.app_icon'))
        .width(100)
        .height(100)
        .margin({ top: 60, bottom: 48 })

      // 标题
      Text('欢迎登录')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 32 })

      // 用户名输入
      TextInput({ placeholder: '请输入用户名' })
        .width(300)
        .height(40)
        .onChange((value: string) => {
          this.username = value
        })
        .margin({ bottom: 16 })

      // 密码输入
      TextInput({ placeholder: '请输入密码' })
        .width(300)
        .height(40)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.password = value
        })
        .margin({ bottom: 24 })

      // 错误提示
      if (this.errorMessage) {
        Text(this.errorMessage)
          .fontSize(14)
          .fontColor('#FF0000')
          .margin({ bottom: 16 })
      }

      // 登录按钮
      Button(this.isLoading ? '登录中...' : '登录')
        .width(200)
        .height(40)
        .backgroundColor('#1890ff')
        .enabled(!this.isLoading)
        .onClick(() => {
          this.login()
        })

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor('#FFFFFF')
  }

  private async login() {
    if (!this.username || !this.password) {
      this.errorMessage = '请输入用户名和密码'
      return
    }

    this.isLoading = true
    this.errorMessage = ''

    // 模拟登录
    setTimeout(() => {
      this.isLoading = false
      if (this.username === 'admin' && this.password === '123456') {
        // 登录成功，跳转到首页
        router.pushUrl({ url: 'pages/HomePage' })
      } else {
        this.errorMessage = '用户名或密码错误'
      }
    }, 1500)
  }
}
