// 首页
import router from '@ohos.router'

@Entry
@Component
struct HomePage {
  @State isLoggedIn: boolean = true

  build() {
    Column() {
      Text('欢迎回来！')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Text('您已成功登录')
        .fontSize(18)
        .fontColor('#999999')
        .margin({ bottom: 48 })

      Button('退出登录')
        .width(200)
        .height(40)
        .backgroundColor('#CCCCCC')
        .onClick(() => {
          router.back()
        })

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
  }
}
