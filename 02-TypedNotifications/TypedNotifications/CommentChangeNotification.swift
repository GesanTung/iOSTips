//
//  CommentChangeNotification.swift
//  TypedNotifications
//
//  Created by Gesantung on 2019/3/24.
//  Copyright © 2019 laofeng. All rights reserved.
//

import Foundation

struct Comment {
    var user_id: Int = 0
    var content = ""
}

struct CommentChangeNotification: TypedNotification {

    static var name: Notification.Name {
        return "com.notification.comment"
    }

    let newsId: Int
    let comment: Comment

    var userInfo: [AnyHashable: Any]? {
        return ["newsId": newsId,
                "comment": comment
        ]
    }

    init(_ notification: Notification) {
        newsId = notification.userInfo?["newsId"] as! Int
        comment = notification.userInfo?["comment"] as! Comment
    }

    init( newsId: Int, comment: Comment) {
        self.newsId = newsId
        self.comment = comment
    }
}
