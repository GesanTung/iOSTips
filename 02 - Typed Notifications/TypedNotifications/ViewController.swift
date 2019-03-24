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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        notificationHolder = CommentChangeNotification.registerObserver { (info) in
            print(info.newsId)
            print(info.comment)
        }
    }

    @IBAction func doPost(_ sender: Any) {
        CommentChangeNotification.init(newsId: 12345, comment: Comment.init(user_id: 1, content: "laofeng talk")).post()
    }


}

