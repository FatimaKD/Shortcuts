//
//  SwiftUIView.swift
//  
//
//  Created by Alanoud Almansour on 28/08/1444 AH.
//
import Fluent
import Vapor

final class Shortcut: Model, Content {
    static let schema = "shortcuts"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "shortcut")
    var shortcut: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "field")
    var field: String
    
    init() {}
    
    init(id: UUID? = nil, shortcut: String, description: String, field: String) {
        self.id = id
        self.shortcut = shortcut
        self.description = description
        self.field = field
    }
}

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "field")
    var field: String
    
    init() {}
    
    init(id: UUID? = nil, field: String) {
        self.id = id
        self.field = field
    }
}
