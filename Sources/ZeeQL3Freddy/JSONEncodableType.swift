//
//  JSONEncodableType.swift
//  ZeeQL3Freddy
//
//  Created by Helge Hess on 29.06.17.
//  Copyright © 2017-2019 ZeeZide GmbH. All rights reserved.
//

import ZeeQL
import Freddy

public enum JSONAttributeType {
  case array, dictionary, double, int, string, bool, null
}

public extension JSON {
  
  func getValue(at key: JSONPathType, type: JSONAttributeType)
         throws -> JSONEncodableType?
  {
    // Note: this doesn't support a path because Freddy doesn't have a matching
    //       array method
    switch type {
      /*#if false
      case .array:      return try getArray     (at: key)
      case .dictionary: return try getDictionary(at: key)
      #endif*/
      case .double:     return try getDouble    (at: key)
      case .int:        return try getInt       (at: key)
      case .string:     return try getString    (at: key)
      case .bool:       return try getBool      (at: key)
      default:          return try getString    (at: key)
    }
  }
}


public protocol JSONEncodableType {
  
  var jsonAttributeType : JSONAttributeType { get }
  
}

extension String : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .string }
}

#if false // TODO:
extension Data    : JSONEncodableType {}
extension Date    : JSONEncodableType {}
extension Decimal : JSONEncodableType {}
#endif

extension Int     : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .int }
}
extension Int16   : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .int }
}
extension Int32   : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .int }
}
extension Int64   : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .int }
}
extension Float   : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .double }
}
extension Double  : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .double }
}
extension Bool    : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .bool }
}

import struct Foundation.URL

extension URL     : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .string }
}

public extension Attribute {
  
  var jsonAttributeType : JSONAttributeType {
    // TODO: support a userInfo key to override the mapping
    
    if let v = self.valueType {
      if let av = v as? JSONEncodableType {
        return av.jsonAttributeType
      }
    }
    
    if let et = self.externalType?.uppercased(), !et.isEmpty {
      if et.hasPrefix("VARCHAR") || et.hasPrefix("CHAR") || et == "TEXT" {
        return .string
      }
      if et.hasPrefix("INT") || et.hasPrefix("SMALLINT") ||
         et.hasPrefix("BIGINT") || et == "SERIAL" || et == "BIGSERIAL"
      {
        return .int
      }
      if et == "REAL" || et.hasPrefix("DOUBLE") {
        return .double
      }
    }
    
    return .string // TBD: or make it optional?
  }
}

