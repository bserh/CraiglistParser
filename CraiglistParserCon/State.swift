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
        guard let sites = sites, name = name else {
            return ""
        }
        
        let formattedString = sites
            .map { $0.descriptionAsJson() }
            .joinWithSeparator(",\n")
        
        return "{\n\"name\": \(name),\n\"sites\":[" + formattedString + "\n]}"

    }
    
    func descriptionAsXml() -> String {
        guard let sites = sites, name = name else {
            return ""
        }
        
        let formattedString = sites
            .map { $0.descriptionAsXml() }
            .joinWithSeparator("\n")
        
        return "<state name=\"\(name)\">\n<sites>\n" + formattedString + "\n</sites>\n</state>"
    }
}
