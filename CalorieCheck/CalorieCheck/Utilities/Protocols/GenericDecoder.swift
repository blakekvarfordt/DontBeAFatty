//
//  GenericDecoder.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/11/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import Foundation

protocol CodableObject {
    associatedtype GenericObject: Codable
    static func decode(data: [String : Any]) -> GenericObject?
    static func encode(object: GenericObject) -> [String : Any]?
}

extension CodableObject {
    
    static func decode(data: [String : Any]) -> GenericObject? {
        let decoder = JSONDecoder()
        var object: GenericObject? = nil
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            object = try decoder.decode(GenericObject.self, from: jsonData)
            
        } catch(let e) {
            print("Fialed to parse object: \(e.localizedDescription)")
        }
        return object
    }
    
    static func encode(object: GenericObject) -> [String : Any]? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        var jsonString: [String: Any]? = nil
        do {
            let data = try encoder.encode(object)
            jsonString = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
            
        } catch(let e) {
            print("Failed to encode object: \(e.localizedDescription)")
        }
        return jsonString
    }
}
