# Shortcuts

This is an API that shows the user meanings of the shortcuts.
We used vapor, and PSQL. 

The required data to add a shortcut:

     - Shortcut 
     - Description
     - Field
     
We did a completed CRUD

1- Create: 

The method:
       app.post("shortcuts") { req -> EventLoopFuture<Shortcut> in
           let shortcut = try req.content.decode(Shortcut.self)
           return shortcut.create(on: req.db).map { shortcut }
       }
  
The result:
  
![5737a4b0-4aab-417b-9c5a-452e42ab546d 2](https://user-images.githubusercontent.com/84997943/226893304-032086b2-8ee7-4da1-b2d7-e99445733235.JPG)

2- Read:

  The method:
       app.get("shortcuts") { req -> EventLoopFuture<[Shortcut]> in
           return Shortcut.query(on: req.db).all()
       }
  
The result:
  
![929a9e67-28b8-4486-9fb9-afc35c4bdee9 2](https://user-images.githubusercontent.com/84997943/226894104-17ddccc6-e943-4c17-bdec-b055ade6c017.JPG)

3- Update:

  The method:
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
  
The result: 
  
![eeeade85-907d-482e-a3e1-9fe46732e047 2](https://user-images.githubusercontent.com/84997943/226894250-98492331-82e1-45aa-ac5d-0ee4aa882cff.JPG)
 
4- Delete:
  
The method:
  
       app.delete("shortcuts", ":id") { req -> EventLoopFuture<HTTPStatus> in
          let id = try req.parameters.require("id", as: UUID.self)
          
          return Shortcut.find(id, on: req.db)
              .unwrap(or: Abort(.notFound))
              .flatMap { shortcut in
                  shortcut.delete(on: req.db)
              }
              .transform(to: .ok)
      }
  
The result:
  
![2b0de04c-01f7-453d-9b43-550acfc98b8f 2](https://user-images.githubusercontent.com/84997943/226894421-4a36c11d-dbe6-4bec-b8e6-7b820e420f98.JPG)
  

 Final database:
  ![8216923e-78ea-43f7-b478-278e7b6a3618 2](https://user-images.githubusercontent.com/84997943/226894550-d5304b53-72ce-4b88-b03c-92db7ea2bdfd.JPG)

  
  
