//
//  HTTPHeader.swift
//  homegate
//
//  Created by Phai Hoang on 21/5/26.
//
//

struct HTTPHeader {
    let field: String
    let value: String
    
    static func authorization(token: String) -> HTTPHeader {
        HTTPHeader(field: "Authorization", value: "Bearer \(token)")
    }
    
    static func contentType(_ value: String) -> HTTPHeader {
        HTTPHeader(field: "Content-Type", value: value)
    }
    
    static func accept(_ value: String) -> HTTPHeader {
        HTTPHeader(field: "Accept", value: value)
    }
}
