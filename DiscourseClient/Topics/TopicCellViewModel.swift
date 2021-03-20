//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// ViewModel que representa un topic en la lista
class TopicCellViewModel {
    let topic: Topic
    var textLabelText: String?
    var messagesCount: String?
    var usersCount: String?
    var calendarDate: String?
    var imageURL: String?
    let apiURL = "https://mdiscourse.keepcoding.io"
    
    init(topic: Topic, user: User) {
        self.topic = topic
        textLabelText = topic.title
        messagesCount = "\(topic.postsCount)"
        usersCount = "\(topic.replyCount)"
        let completePath = apiURL + user.avatarTemplate.replacingOccurrences(of: "{size}", with: "50")
        imageURL = completePath
        getTopicDateFormatter()

    }

    private func getTopicDateFormatter() {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        if let date = dateFormatterGet.date(from: topic.createdAt) {
            calendarDate = dateFormatterPrint.string(from: date)
        } else {
            calendarDate = "error"
        }
    }
}
