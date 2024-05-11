import { UserInfo, UserInfoModel } from '../../models/user'
import { WeChatStore } from '../../utils/chat_store'

@Preview
@Component
struct Connect {
  @State
  userList: UserInfoModel[] = []
  @State
  filterList: UserInfoModel[] = []
  @State
  @Watch('getFilterList')
  searchName: string = ''

  getFilterList() {
    if (this.searchName) {
      this.filterList = this.userList.filter((item => item.username.includes(this.searchName)))
    } else {
      this.filterList = this.userList
    }
  }

  aboutToAppear(): void {
    this.getUserList()
  }

  getUserList() {
    this.userList = WeChatStore.getWeChatConnect()
    this.filterList = this.userList
  }

  build() {
    Column() {
      Row() {
        Search({ placeholder: '搜索', value: $$this.searchName })
          .height(30)
          .borderRadius(4)
          .backgroundColor($r('app.color.white'))
      }
      .width('100%')
      .padding({
        left: 10,
        right: 10
      })

      List() {
        ForEach(this.filterList, (item: UserInfoModel) => {
          ListItem() {
            Row({ space: 15 }) {
              Image(item.avatar)
                .width(40)
                .aspectRatio(1)
                .borderRadius(4)
              Text(item.username)
                .fontSize(16)
                .fontColor($r('app.color.text_primary'))
            }
            .width('100%')
            .height(60)
          }
          .stateStyles({
            pressed: {
              .backgroundColor($r('app.color.back_color'))
            },
            normal: {
              .backgroundColor($r('app.color.white'))
            }
          })
        })
      }
      .layoutWeight(1)
      .backgroundColor($r('app.color.white'))
      .divider({
        strokeWidth: 1,
        color: $r('app.color.border_color')
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.back_color'))
  }
}

export default Connect