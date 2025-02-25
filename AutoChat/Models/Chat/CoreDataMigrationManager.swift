import CoreData
import Foundation

class CoreDataMigrationManager {
    static let shared = CoreDataMigrationManager()
    
    private init() {}
    
    // MARK: - Migration Configuration
    
    /// 配置轻量级迁移
    private func configureLightweightMigration() -> NSPersistentStoreDescription {
        let description = NSPersistentStoreDescription()
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        return description
    }
    
    // MARK: - Migration Methods
    
    /// 执行数据迁移
    /// - Parameters:
    ///   - sourceModel: 源数据模型
    ///   - destinationModel: 目标数据模型
    ///   - storeURL: 数据存储URL
    /// - Returns: 迁移是否成功
    func migrateStore(from sourceModel: NSManagedObjectModel,
                     to destinationModel: NSManagedObjectModel,
                     storeURL: URL) -> Bool {
        do {
            // 创建迁移管理器
            let manager = NSMigrationManager(sourceModel: sourceModel,
                                           destinationModel: destinationModel)
            
            // 创建迁移映射模型
            guard let mapping = NSMappingModel(from: nil,
                                             forSourceModel: sourceModel,
                                             destinationModel: destinationModel) else {
                print("⚠️ 无法创建映射模型")
                return false
            }
            
            // 创建临时存储URL
            let tempURL = storeURL.deletingLastPathComponent()
                .appendingPathComponent("temp_\(UUID().uuidString)")
            
            // 执行迁移
            try manager.migrateStore(from: storeURL,
                                    sourceType: NSSQLiteStoreType,
                                    options: nil,
                                    with: mapping,
                                    toDestinationURL: tempURL,
                                    destinationType: NSSQLiteStoreType,
                                    destinationOptions: nil)
            
            // 备份原始存储
            let backupURL = storeURL.deletingLastPathComponent()
                .appendingPathComponent("backup_\(Date().timeIntervalSince1970)")
            try FileManager.default.moveItem(at: storeURL, to: backupURL)
            
            // 移动临时存储到原始位置
            try FileManager.default.moveItem(at: tempURL, to: storeURL)
            
            // 迁移成功后删除备份
            try FileManager.default.removeItem(at: backupURL)
            
            return true
        } catch {
            print("❌ 数据迁移失败: \(error)")
            return false
        }
    }
    
    // MARK: - Backup Methods
    
    /// 创建数据库备份
    /// - Parameter storeURL: 数据存储URL
    /// - Returns: 备份文件URL
    func createBackup(for storeURL: URL) -> URL? {
        do {
            let backupURL = storeURL.deletingLastPathComponent()
                .appendingPathComponent("backup_\(Date().timeIntervalSince1970)")
            try FileManager.default.copyItem(at: storeURL, to: backupURL)
            return backupURL
        } catch {
            print("❌ 创建备份失败: \(error)")
            return nil
        }
    }
    
    /// 从备份恢复数据
    /// - Parameters:
    ///   - backupURL: 备份文件URL
    ///   - storeURL: 目标存储URL
    /// - Returns: 恢复是否成功
    func restoreFromBackup(at backupURL: URL, to storeURL: URL) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: storeURL.path) {
                try FileManager.default.removeItem(at: storeURL)
            }
            try FileManager.default.copyItem(at: backupURL, to: storeURL)
            return true
        } catch {
            print("❌ 恢复备份失败: \(error)")
            return false
        }
    }
}