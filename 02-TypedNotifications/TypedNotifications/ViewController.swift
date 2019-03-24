//
//  ViewController.swift
//  TypedNotifications
//
//  Created by Gesantung on 2019/3/24.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var notificationHolder: NotificationToken?

    var notificationHolder1: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()



notificationHolder = CommentChangeNotification.registerObserver { (info) in
    print(info.newsId)
    print(info.comment)
}

notificationHolder1 = NotificationCenter.default.addObserver(forName: NSNotification.Name.init(rawValue: "com.notification.comment"), object: nil, queue: nil) { (notification) in
    guard let userInfo = notification.userInfo as? [String:Any] else { return }
    guard let newsId = userInfo["newsId"] as? Int else { return }
    guard let comment = userInfo["comment"] as? Int else { return }
    print(newsId)
    print(comment)
}
    }

    @IBAction func doPost(_ sender: Any) {
        CommentChangeNotification.init(newsId: 12345, comment: Comment.init(user_id: 1, content: "laofeng talk: TypedNotification")).post()

//        let info = ["newsId": 12345,"comment": Comment.init(user_id: 1, content: "laofeng talk: exp")] as [String : Any]
//        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "com.notification.comment"), object: nil, userInfo: info)

    }


}

