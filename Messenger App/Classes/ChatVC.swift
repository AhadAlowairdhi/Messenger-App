//
//  ChatVC.swift
//  Messenger App
//
//  Created by administrator on 05/01/2022.
//

import UIKit
import MessageKit

class ChatVC: MessagesViewController {

    // MARK: Var & Let
    private var messages = [Message]()
    private let selfSender = Sender(PhotoUrl: "", senderId: "1", displayName: "Ahad Alowairdhi")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind:  .text("Hi Ahad ")))
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind:  .text("Hi Saad")))
                
        
        // Do any additional setup after loading the view.
    }
}

// MARK: Extensions
extension ChatVC: MessagesDataSource,MessagesLayoutDelegate,MessagesDisplayDelegate{
    func currentSender() -> SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
}

// MARK: Structs

struct Message:MessageType{
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct Sender:SenderType{
    
    var PhotoUrl: String
    var senderId: String
    var displayName: String
    
}
