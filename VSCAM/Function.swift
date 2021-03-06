

import UIKit
import SwiftMessages
import SVProgressHUD

enum MessageBoxType {
    case error
    case info
    case success
}

class Function: NSObject {

    //简单的模态消息弹窗
    static func MessageBox(_ controller: UIViewController, title: String?, content: String?, buttonTitle: String = "确定",
                           type: MessageBoxType = .error, finish: ((UIAlertAction) -> Void)? = nil) {
        if nil != finish {
            let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: finish))
            controller.present(alert, animated: true, completion: nil)
        } else {
            switch type {
            case .error:
                SVProgressHUD.showError(withStatus: content)
                break
            case .info:
                SVProgressHUD.showInfo(withStatus: content)
                break
            case .success:
                SVProgressHUD.showSuccess(withStatus: content)
                break
            }
        }
    }

    //收起键盘
    static func HideKeyboard() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }

    static func setStatusBar(hidden: Bool) {
        UIApplication.shared.isStatusBarHidden = hidden
    }

    //打开分享对话框
    static func openShareView(controller: UIViewController, title: String, url: String) {
        if let tryUrl = NSURL(myString: url) {
            let shareVC = UIActivityViewController(activityItems: [title, tryUrl], applicationActivities: nil)

            //阻止 iPad Crash
            shareVC.popoverPresentationController?.sourceView = controller.view
            shareVC.popoverPresentationController?.sourceRect = CGRect(
                x: controller.view.bounds.size.width / 2.0,
                y: controller.view.bounds.size.height / 2.0,
                width: 1.0, height: 1.0
            )

            controller.present(shareVC, animated: true) {
                //分享完成回调
                print("分享内容[\(title)][\(url)]")
            }
        }
    }

    //打开 AppStore
    static func openAppStore() {
        if let tryUrl = URL(myString: NetworkURL.appStore) {
            UIApplication.shared.openURL(tryUrl)
        }
    }
}
