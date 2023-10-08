//
//  CreateSongs.swift
//
//
//  Created by Promal on 8/10/23.
//

import Fluent

struct CreateSongs: Migration {
  func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
    //MARK: Creating a table named "songs"
    return database.schema("songs")
      .id() // Adding an identifier field
      .field("title", .string, .required) // Adding a field named title with dataType string and constraint required
      .create()
  }
  
  func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
    return database.schema("songs").delete()
  }
}
