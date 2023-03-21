import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.post("shortcuts") { req -> EventLoopFuture<Shortcut> in
           let shortcut = try req.content.decode(Shortcut.self)
           return shortcut.create(on: req.db).map { shortcut }
       }
       
       app.get("shortcuts") { req -> EventLoopFuture<[Shortcut]> in
           return Shortcut.query(on: req.db).all()
       }
       
       app.put("shortcuts", ":id") { req -> EventLoopFuture<Shortcut> in
           let id = try req.parameters.require("id", as: UUID.self)
           let updateData = try req.content.decode(Shortcut.self)
           
           return Shortcut.find(id, on: req.db)
               .unwrap(or: Abort(.notFound))
               .flatMap { shortcut in
                   shortcut.shortcut = updateData.shortcut
                   shortcut.description = updateData.description
                   shortcut.field = updateData.field
                   
                   return shortcut.save(on: req.db).map { shortcut }
               }
       }
     //delete by ID
    app.delete("shortcuts", ":id") { req -> EventLoopFuture<HTTPStatus> in
          let id = try req.parameters.require("id", as: UUID.self)
          
          return Shortcut.find(id, on: req.db)
              .unwrap(or: Abort(.notFound))
              .flatMap { shortcut in
                  shortcut.delete(on: req.db)
              }
              .transform(to: .ok)
      }
    
  //  try app.register(collection: CreateShortcuts())
}

