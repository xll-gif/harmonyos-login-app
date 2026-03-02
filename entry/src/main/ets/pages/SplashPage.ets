/**
 * 启动页面组件
 *
 * 功能：
 * 1. 展示品牌 Logo 和加载动画
 * 2. 自动跳转到登录页面（延迟 2 秒）
 */
@Component
export struct SplashPage {
  @State progress: number = 0
  @State isLoaded: boolean = false

  aboutToAppear() {
    this.startLoading()
  }

  build() {
    Column({ space: 24 }) {
      Column().layoutWeight(1)

      // Logo
      this.logoView()

      // 品牌名称
      this.brandNameView()

      // 加载动画
      this.loadingIndicatorView()

      Column().layoutWeight(1)

      // 版本信息
      this.versionInfoView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  /**
   * Logo 视图
   */
  @Builder
  logoView() {
    Stack() {
      Circle()
        .width(100)
        .height(100)
        .fill({
          type: LinearGradient,
          angle: 45,
          colors: [['#007AFF', 0.0], ['#5AC8FA', 1.0]]
        })
        .shadow({
          radius: 10,
          color: 'rgba(0,0,0,0.1)'
        })

      Text('L')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
    }
  }

  /**
   * 品牌名称视图
   */
  @Builder
  brandNameView() {
    Text('LoginApp')
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor('#333333')
      .opacity(this.isLoaded ? 1 : 0)
      .animation({
        duration: 500,
        curve: Curve.EaseInOut
      })
  }

  /**
   * 加载指示器视图
   */
  @Builder
  loadingIndicatorView() {
    Column({ space: 12 }) {
      // 进度条
      Stack() {
        // 背景条
        Text('')
          .width(200)
          .height(4)
          .borderRadius(2)
          .backgroundColor('#E5E5E5')

        // 进度条
        Text('')
          .width(`${200 * this.progress}`)
          .height(4)
          .borderRadius(2)
          .fill({
            type: LinearGradient,
            angle: 0,
            colors: [['#007AFF', 0.0], ['#5AC8FA', 1.0]]
          })
      }
      .height(4)
      .width(200)
      .alignContent(Alignment.Start)

      // 加载文字
      Text('正在加载...')
        .fontSize(14)
        .fontColor('#999999')
    }
  }

  /**
   * 版本信息视图
   */
  @Builder
  versionInfoView() {
    Column({ space: 4 }) {
      Text('Version 1.0.0')
        .fontSize(12)
        .fontColor('#999999')

      Text('© 2026 Multi-Platform App')
        .fontSize(10)
        .fontColor('#CCCCCC')
    }
    .padding({ bottom: 40 })
  }

  /**
   * 开始加载
   */
  startLoading() {
    setInterval(() => {
      if (this.progress < 1) {
        this.progress = (this.progress + 0.05).toFixed(2) as number
      } else {
        this.isLoaded = true
        
        // 延迟 0.5 秒后跳转
        setTimeout(() => {
          // TODO: 跳转到登录页面
          // router.pushUrl({ url: 'pages/LoginPage' })
        }, 500)
      }
    }, 100)
  }
}
