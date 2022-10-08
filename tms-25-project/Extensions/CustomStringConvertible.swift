//
//  CustomStringConvertible.swift
//  tms-25-project
//
//  Created by Daria Sechko on 16.09.22.
//

import Foundation

// Экстеншн который реализует для Codable-модели переменную description у протокола CustomStringConvertible

// Кейс: принтануть массив из опциональных элементов или опциональный массив элементов

extension CustomStringConvertible where Self: Codable {
    
    var description: String {
        var description = "\n \(type(of: self)) \n"
        
        //Интроспекция
        let selfMirror = Mirror(reflecting: self)
        
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
}
