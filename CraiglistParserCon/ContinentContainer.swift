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
        guard let continents = continents else {
            return ""
        }
        
        let formattedString = continents
            .map { $0.descriptionAsJson() }
            .joinWithSeparator(",\n")
        
        return "{\n\"continents\":[" + formattedString + "\n]}"
    }
    
    func descriptionAsXml() -> String {
        guard let continents = continents else {
            return ""
        }
        
        let formattedString = continents
            .map { $0.descriptionAsXml() }
            .joinWithSeparator("\n")

        return "<continents>\n" + formattedString + "\n</continents>"
    }
}