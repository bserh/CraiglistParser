//
//  Continent.swift
//  CraiglistParserCon
//
//  Created by Sergey Bavykin on 3/18/16.
//  Copyright © 2016 Sergey Bavykin. All rights reserved.
//

import Foundation

struct Continent: JSONRepresentable, XMLRepresetable {
    var name: String?
    var states: [State]?
    
    func descriptionAsJson() -> String {
        var formattedString = states!
            .map { $0.descriptionAsJson() }
            .joinWithSeparator(",\n")
        
        formattedString = "{\n\"name\": \(name!),\n\"states\":[" + formattedString
        formattedString += "\n]}"
        
        return formattedString
    }
    
    func descriptionAsXml() -> String {
        let lastContinentName = states?.last?.name
        
        var formattedString = states!
            .map { $0.descriptionAsXml() + (($0.name != lastContinentName) ? "\n" :"") }
            .joinWithSeparator("")
        
        formattedString = "<continent name=\"\(name!)\">\n<states>\n" + formattedString
        formattedString += "\n</states>\n</continent>"
        
        return formattedString
    }
}