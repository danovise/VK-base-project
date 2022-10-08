//
//  Data+PrettyJSON.swift
//  tms-25-project
//
//  Created by Daria Sechko on 28.08.22.
//

import Foundation

extension Data {
    
    var prettyJSON: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
