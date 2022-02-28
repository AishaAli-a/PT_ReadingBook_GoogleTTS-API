//
//  Books.swift
//  Json
//
//  Created by Marzouq Almukhlif on 25/05/1443 AH.
//

import Foundation

class Books {
  let id:Int
  let authors:[[String:Any]]
  let bookshelves:[String]
  let download_count:Int
  let formats:[String:String]
  let languages:[String]
  let media_type:String
  let subjects:[String]
  let title:String
  
  init(id:Int,
       authors:[[String:Any]],
       bookshelves:[String],
       download_count:Int,
       formats:[String:String],
       languages:[String],
       media_type:String,
       subjects:[String],
       title:String){
    self.id = id
    self.authors = authors
    self.bookshelves = bookshelves
    self.download_count = download_count
    self.formats = formats
    self.languages = languages
    self.media_type = media_type
    self.subjects = subjects
    self.title = title
    
  }
  
}
