import Fluent
import FluentPostgresDriver
import Foundation
  

//First creat shortcutsdb dtabase !
struct CreateShortcuts: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
       return database.schema("shortcuts")
            .id()
            .field("shortcut", .string, .required)
            .field("description", .string, .required)
            .field("field", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
      return  database.schema("shortcuts").delete()
    }
}

struct CreateUsers: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users")
            .id()
            .field("field", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }
}
