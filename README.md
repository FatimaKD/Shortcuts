Shortcuts Table

This is an API that access a shortcut table which show the user the meaning of the most useable shortcuts in each filed so he can be aware of them whenever and wherever he need.
We used vapor, using PSQL database ,  and making it flunt to develop it.

and we also use Docker desktop and postico to make sure that our project work and reflect the data in the best way, and postman to send the requests.

The coulomns we have in our database : 

 - Shortcut 
 - Description
 - Field

Note : all columns are required , that’s mean if you send any POST or PUT request you need to put all the three columns in the JSON body, otherwise it will show you an error massage .

In this API,

You can make a completed CRUD operation (create, read, update, delete), on the database

1- Create:

This is the POST method,which is responsible for creating a new record of sent data and saving it in the database :

  app.post("shortcuts") { req -> EventLoopFuture<Shortcut> in
           let shortcut = try req.content.decode(Shortcut.self)
           return shortcut.create(on: req.db).map { shortcut }
       }

Note: “shortcut” is the name of our database, so make sure to change it if you using another name.

POST request result:

5737a4b0-4aab-417b-9c5a-452e42ab546d 2
2- Read:

This is the GET method,which is responsible for reading all the stored data in the database :

app.get("shortcuts") { req -> EventLoopFuture<[Shortcut]> in
           return Shortcut.query(on: req.db).all()
       }

Note: here we use .all() to bring all the stored data in the database, so if you want to bring just a one record you need to change it.

GET request result :

929a9e67-28b8-4486-9fb9-afc35c4bdee9 2
3- Update:

This is the PUT method,which is responsible for updating data in the database :

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
Note: we update the data using the id of the record , so if you want to update any data in any record , you must put the id of the chosen record you want to update in the request path after a slash like the pic below .
PUT request result in postman:

eeeade85-907d-482e-a3e1-9fe46732e047 2
4- Delete:

This is the DELETE method,which is responsible for deleting record in the database :
    app.delete("shortcuts", ":id") { req -> EventLoopFuture<HTTPStatus> in
         let id = try req.parameters.require("id", as: UUID.self)
         return Shortcut.find(id, on: req.db)
         .unwrap(or: Abort(.notFound))
         .flatMap { shortcut in
      shortcut.delete(on: req.db) }
         .transform(to: .ok)
 }
Note: we delete the record by id  , so if you want to delete any record , you must put the id of the chosen record you want to delete in the request path after a slash like the pic below .
DELETE request result :

2b0de04c-01f7-453d-9b43-550acfc98b8f 2
Shortcut table :

8216923e-78ea-43f7-b478-278e7b6a3618 2
Developers:

 - Malak Hulimi @MalakHulimi
 - Alanoud Almansour @AlanoudAM9
 - Fatimah Dagriri @FatimaKD
