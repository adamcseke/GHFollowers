//
//  DatabaseManager.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 15..
//

import Foundation
import SQLite

class DatabaseManager {
    // MARK: Singleton
    static let main = DatabaseManager()
    init() {
        openIfNeeded()
    }
    
    internal var database: Connection?
    
    private let databaseName = "user"
    
    let user = Table("users")
    fileprivate let login = Expression<String>("id")
    fileprivate let avatarURL = Expression<String?>("avatarURL")
    
    internal func openIfNeeded() {
        if self.database != nil {
            return
        }
        self.copyDatabaseIfNeeded(self.databaseName)
        if let path = NSSearchPathForDirectoriesInDomains(
            .libraryDirectory, .userDomainMask, true
        ).first {
            print(path)
            do {
                let database = try Connection("\(path)/\(databaseName).sqlite")
                print("Database opened...")
                self.database = database
                
                try database.run(user.create { t in
                    t.column(login, primaryKey: true)
                    t.column(avatarURL)
                })
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func copyDatabaseIfNeeded(_ database: String) {
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .libraryDirectory, in: .userDomainMask)
        if documentsUrl.isEmpty { return }
        
        guard let finalDatabaseURL = documentsUrl.first?.appendingPathComponent("\(database).sqlite") else {
            print("finalDatabaseURL is nil")
            return
        }
        
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            print("DB does not exist in documents folder")
            let databaseInMainBundleURL = Bundle.main.resourceURL?.appendingPathComponent("\(database).sqlite")
            
            do {
                guard let fromPath = databaseInMainBundleURL?.path else {
                    print("fromPath is nil")
                    return
                }
                try fileManager.copyItem(atPath: fromPath, toPath: finalDatabaseURL.path)
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
        } else {
            print("Database file found at path: \(finalDatabaseURL.path)")
        }
    }
    
    func insert(username: String, avatar: String, completion: BoolCompletition?) {
        self.openIfNeeded()
        let insert = user.insert(
            login <- username.lowercased(),
            avatarURL <- avatar
        )
        
        do {
            _ = try database?.run(insert)
            print("User inserted to database...")
            completion?(true)
        } catch let error {
            print(error.localizedDescription)
            completion?(false)
        }
    }
    
    func getUsers() -> [Follower] {
        var users: [Follower] = []
        if let db = database {
            
            do {
                for user in try db.prepare(user) {
                    let followert = Follower(login: user[login], avatarUrl: user[avatarURL] ?? "")
                    users.append(followert)
                    print("login: \(user[login]), avatarURL: \(user[avatarURL] ?? "")")
                }
            } catch {
                print (error)
            }
        }
        
        return users
    }
    
    func delete(username: String, completion: BoolCompletition?) {
        self.openIfNeeded()
        let item = self.user.filter(login == username)
        do {
            try database?.run(item.delete())
            print("User deleted from database...")
            completion?(true)
        } catch let error {
            print(error)
            completion?(false)
        }
    }
}
