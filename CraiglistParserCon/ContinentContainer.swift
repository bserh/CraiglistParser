//
//  ContinentContainer.swift
//  CraiglistParserCon
//
//  Created by Sergey Bavykin on 3/18/16.
//  Copyright © 2016 Sergey Bavykin. All rights reserved.
//

import Foundation

struct ContinentContainer: JSONRepresentable, XMLRepresetable {
    var continents: [Continent]?
    
    func descriptionAsJson() -> String {
        var formattedString = continents!
            .map { $0.descriptionAsJson() }
            .joinWithSeparator(",\n")
        
        formattedString = "{\n\"continents\":[" + formattedString
        formattedString += "\n]}"
        
        return formattedString
    }
    
    func descriptionAsXml() -> String {
        let lastContinentName = continents?.last?.name
        
        var formattedString = continents!
            .map { $0.descriptionAsXml() + (($0.name != lastContinentName) ? "\n" :"") }
            .joinWithSeparator("")

        formattedString = "<continents>\n" + formattedString
        formattedString += "\n</continents>"
        
        return formattedString
    }
}