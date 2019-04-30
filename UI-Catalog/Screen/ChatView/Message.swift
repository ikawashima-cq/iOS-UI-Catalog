//
//  Message.swift
//  UI-Catalog
//
//  Created by Iichiro Kawashima on 2019/04/30.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import UIKit
import MessageKit

struct Member {
    let name: String
    let color: UIColor
}

struct Message {
    let member: Member
    let text: String
    let messageId: String
}

extension Message: MessageType {
    var sender: Sender {
        return Sender(id: member.name, displayName: member.name)
    }

    var sentDate: Date {
        return Date()
    }

    var kind: MessageKind {
        return .text(text)
    }
}
