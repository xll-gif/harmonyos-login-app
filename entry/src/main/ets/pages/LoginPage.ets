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
    Scroll() {
      Column() {
        // 顶部空白，用于垂直居中
        Blank()

        // Logo
        Image($r('app.media.app_icon'))
          .width(80)
          .height(80)
          .fillColor('#1890ff')
          .margin({ bottom: 32 })

        // 标题
        Text('欢迎登录')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ bottom: 48 })

        // 输入框容器
        Column() {
          // 用户名输入
          Row() {
            Image($r('sys.symbol.person'))
              .width(20)
              .height(20)
              .fillColor('#999999')
              .margin({ right: 12 })

            TextInput({ placeholder: '请输入用户名' })
              .layoutWeight(1)
              .height(50)
              .type(InputType.Normal)
              .backgroundColor(Color.Transparent)
              .onChange((value: string) => {
                this.username = value
              })
          }
          .width('100%')
          .height(50)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#F5F5F5')
          .borderRadius(10)
          .margin({ bottom: 20 })

          // 密码输入
          Row() {
            Image($r('sys.symbol.lock'))
              .width(20)
              .height(20)
              .fillColor('#999999')
              .margin({ right: 12 })

            TextInput({ placeholder: '请输入密码' })
              .layoutWeight(1)
              .height(50)
              .type(InputType.Password)
              .backgroundColor(Color.Transparent)
              .onChange((value: string) => {
                this.password = value
              })
          }
          .width('100%')
          .height(50)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#F5F5F5')
          .borderRadius(10)
        }
        .width('100%')
        .padding({ left: 32, right: 32 })
        .margin({ bottom: 24 })

        // 错误提示
        if (this.errorMessage) {
          Text(this.errorMessage)
            .fontSize(14)
            .fontColor('#FF0000')
            .height(20)
            .margin({ bottom: 0 })
        } else {
          // 占位高度，保持布局稳定
          Text('')
            .fontSize(14)
            .height(20)
            .margin({ bottom: 0 })
        }

        // 登录按钮
        Button(this.isLoading ? '登录中...' : '登录')
          .width('100%')
          .height(50)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(this.username && this.password ? '#1890ff' : '#CCCCCC')
          .enabled(!this.isLoading && !!(this.username && this.password))
          .onClick(() => {
            this.login()
          })
          .margin({ left: 32, right: 32, top: 24 })

        // 底部空白，用于垂直居中
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ top: 0, bottom: 0 })
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .scrollBar(BarState.Off)
    .align(Alignment.Center)
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
