//
//  Song.swift
//
//
//  Created by Promal on 8/10/23.
//

import Fluent
import Vapor

final class Song: Model, Content {
  static let schema: String = "songs" //MARK: Table name
  
  @ID(key: .id)
  var id: UUID?
  
  @Field(key: "title")
  var title: String
  
  init() { }
  
  init(id: UUID? = nil, title: String) {
    self.id = id
    self.title = title
  }
  

}
