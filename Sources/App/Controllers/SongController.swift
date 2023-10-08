//
//  SongController.swift
//
//
//  Created by Promal on 8/10/23.
//

import Foundation
import Fluent
import Vapor

struct SongController: RouteCollection {
  
  func boot(routes: Vapor.RoutesBuilder) throws {
    let songs = routes.grouped("songs")
    songs.get(use: index)
    songs.post(use: create)
    songs.put(use: update)
    songs.group(":songID") { song in
      song.delete(use: delete)
    }
  }
  // This function is a get request /songs route
  func index(req: Request) throws -> EventLoopFuture<[Song]> {
    return Song.query(on: req.db).all()
  }
  
  // Post request /songs route
  func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
    let song = try req.content.decode(Song.self)
    return song.save(on: req.db).transform(to: .ok)
  }
  
  //PUT Request -> Update /songs route
  func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
    let song = try req.content.decode(Song.self)
    return Song.find(song.id, on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap {
        $0.title = song.title
        return $0.update(on: req.db).transform(to: .ok)
      }
  }
  
  //Delete Request /songs/id route
  func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
     Song.find(req.parameters.get("songID"), on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap {
        $0.delete(on: req.db)
      }
      .transform(to: .ok)
    
  }
}
