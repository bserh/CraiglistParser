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
        guard let states = states, name = name else {
            return ""
        }
        
        let formattedString = states
            .map { $0.descriptionAsJson() }
            .joinWithSeparator(",\n")
        
        return "{\n\"name\": \(name),\n\"states\":[" + formattedString + "\n]}"
    }
    
    func descriptionAsXml() -> String {
        guard let states = states, name = name else {
            return ""
        }
        
        let formattedString = states
            .map { $0.descriptionAsXml() }
            .joinWithSeparator("\n")
        
        return "<continent name=\"\(name)\">\n<states>\n" + formattedString + "\n</states>\n</continent>"
    }
}