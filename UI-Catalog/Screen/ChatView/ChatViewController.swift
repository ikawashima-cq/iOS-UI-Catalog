//
//  ChatViewController.swift
//  UI-Catalog
//
//  Created by Iichiro Kawashima on 2019/04/30.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import UIKit
import MessageKit
import MessageInputBar

class ChatViewController: MessagesViewController {

    private var messages: [Message] = []
    private var member: Member!

    override func viewDidLoad() {
        super.viewDidLoad()

        member = Member(name: "bluemoon", color: .blue)
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - DataSource
extension ChatViewController: MessagesDataSource {
    func currentSender() -> Sender {
        return Sender(id: member.name, displayName: member.name)
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

    func messageTopLabelHeight(
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) -> CGFloat {

        return 12
    }
}

// MARK: - Layout
extension ChatViewController: MessagesLayoutDelegate {
    func heightForLocation(message: MessageType,
                           at indexPath: IndexPath,
                           with maxWidth: CGFloat,
                           in messagesCollectionView: MessagesCollectionView) -> CGFloat {

        return 0
    }
}

extension ChatViewController: MessagesDisplayDelegate {
    func configureAvatarView(
        _ avatarView: AvatarView,
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) {

        let message = messages[indexPath.section]
        let color = message.member.color
        avatarView.backgroundColor = color
    }
}

extension ChatViewController: MessageInputBarDelegate {
    func messageInputBar(
        _ inputBar: MessageInputBar,
        didPressSendButtonWith text: String) {

        let newMessage = Message(
            member: member,
            text: text,
            messageId: UUID().uuidString)

        messages.append(newMessage)
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
}
