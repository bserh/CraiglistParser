//
//  Site.swift
//  CraiglistParserCon
//
//  Created by Sergey Bavykin on 3/18/16.
//  Copyright © 2016 Sergey Bavykin. All rights reserved.
//

import Foundation

struct Site: JSONRepresentable, XMLRepresetable {
    var name: String?
    var url: String?
    
    func descriptionAsJson() -> String {
        return "{\n\"name\": \(name!),\n\"url\":\"\(url!)\"\n}"
    }
    
    func descriptionAsXml() -> String {
        return "<site>\n<name>\(name!)</name>\n<url>\(url!)</url>\n</site>"
    }
}