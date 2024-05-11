import { preferences } from '@kit.ArkData'
import { WeChat_ConnectKey, WeChat_StoreKey } from '../constant'
import { DefaultUserList, UserInfoModel } from '../models/user'

//单例
export class WeChatStore {
  //获取首选项仓库
  static getWeChatStore() {
    return preferences.getPreferencesSync(getContext(), {
      name: WeChat_StoreKey
    })
  }

  static getWeChatConnect() {
    const store = WeChatStore.getWeChatStore()
    return JSON.parse(store.getSync(WeChat_ConnectKey, JSON.stringify(DefaultUserList)) as string) as UserInfoModel[]
  }
}