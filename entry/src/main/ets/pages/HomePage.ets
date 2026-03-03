// 首页
import router from '@ohos.router'

@Entry
@Component
struct HomePage {
  @State isLoggedIn: boolean = true

  build() {
    Scroll() {
      Column() {
        // 顶部间距
        Blank()
          .height(80)

        // 成功图标
        Image($r('sys.symbol.checkmark_circle_fill'))
          .width(80)
          .height(80)
          .fillColor('#4CAF50')
          .margin({ bottom: 24 })

        Text('欢迎回来！')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ bottom: 16 })

        Text('您已成功登录')
          .fontSize(16)
          .fontColor('#999999')
          .margin({ bottom: 48 })

        Button('退出登录')
          .width('100%')
          .height(50)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#E0E0E0')
          .fontColor('#000000')
          .onClick(() => {
            router.back()
          })
          .margin({ left: 24, right: 24 })

        Blank()
      }
      .width('100%')
      .padding({ left: 0, right: 0 })
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .scrollBar(BarState.Off)
  }
}
