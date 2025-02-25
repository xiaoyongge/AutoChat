import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AutoChat")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("无法加载Core Data存储: \(error)")
            }
        }
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("保存Core Data上下文失败: \(error)")
            }
        }
    }
    
    // MARK: - ChatSession操作
    
    func createChatSession(title: String? = nil) -> ChatSession {
        let session = ChatSession(context: viewContext)
        session.id = UUID()
        session.title = title
        session.createdAt = Date()
        session.updatedAt = Date()
        saveContext()
        return session
    }
    
    func fetchChatSessions() -> [ChatSession] {
        let request: NSFetchRequest<ChatSession> = ChatSession.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ChatSession.updatedAt, ascending: false)]
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("获取会话列表失败: \(error)")
            return []
        }
    }
    
    func deleteChatSession(_ session: ChatSession) {
        viewContext.delete(session)
        saveContext()
    }
    
    // MARK: - Message操作
    
    func createMessage(content: String, isUserMessage: Bool, in session: ChatSession) -> Message {
        let message = Message(context: viewContext)
        message.id = UUID()
        message.content = content
        message.createdAt = Date()
        message.isUserMessage = isUserMessage
        message.session = session
        session.updatedAt = Date()
        saveContext()
        return message
    }
    
    func fetchMessages(for session: ChatSession) -> [Message] {
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        request.predicate = NSPredicate(format: "session == %@", session)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Message.createdAt, ascending: true)]
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("获取消息列表失败: \(error)")
            return []
        }
    }
    
    func deleteMessage(_ message: Message) {
        viewContext.delete(message)
        if let session = message.session {
            session.updatedAt = Date()
        }
        saveContext()
    }
}