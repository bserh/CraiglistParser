//
//  State.swift
//  CraiglistParserCon
//
//  Created by Sergey Bavykin on 3/18/16.
//  Copyright © 2016 Sergey Bavykin. All rights reserved.
//

import Foundation

struct State: JSONRepresentable, XMLRepresetable {
    var name: String?
    var sites: [Site]?
    
    func descriptionAsJson() -> String {
        var formattedString = sites!
            .map { $0.descriptionAsJson() }
            .joinWithSeparator(",\n")
        
        formattedString = "{\n\"name\": \(name!),\n\"sites\":[" + formattedString
        formattedString += "\n]}"
        
        return formattedString
    }
    
    func descriptionAsXml() -> String {
        let lastContinentName = sites?.last?.name
        
        var formattedString = sites!
            .map { $0.descriptionAsXml() + (($0.name != lastContinentName) ? "\n" :"") }
            .joinWithSeparator("")
        
        formattedString = "<state name=\"\(name!)\">\n<sites>\n" + formattedString
        formattedString += "\n</sites>\n</state>"
        
        return formattedString
    }
}
