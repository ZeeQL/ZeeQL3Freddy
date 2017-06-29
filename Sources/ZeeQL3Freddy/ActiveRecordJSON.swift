//
//  ActiveRecordJSON.swift
//  ZeeQL3JSON
//
//  Created by Helge Hess on 06/04/17.
//  Copyright © 2017 ZeeZide GmbH. All rights reserved.
//

import ZeeQL
import Freddy

extension ZeeQL.ActiveRecord : Freddy.JSONEncodable {
}

// TBD: We cannot make it JSONDecodable because we first need the entity,
//      right?

public extension ActiveRecordType {
  
  public func toJSON() -> JSON {
    return entity.toJSON(object: self)
  }
  
}

public extension Entity {
  
  public func toJSON(object : ZeeQL.KeyValueCodingType,
                     brief  : Bool = false)
               -> JSON
  {
    var json = [ String : JSON ]()
    
    for attr in attributes {
      let name  = attr.name
      
      if let value = object.value(forKey: name) {
        if let jsonValue = value as? JSONEncodable {
          json[name] = jsonValue.toJSON()
        }
        else {
          json[name] = .string("\(value)")
        }
      }
      else if !brief {
        json[name] = JSON.null
      }
    }
    
    return .dictionary(json)
  }
  
}

