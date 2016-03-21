//
//  ReportFunctions.swift
//  CraiglistParserCon
//
//  Created by Sergey Bavykin on 3/21/16.
//  Copyright © 2016 Sergey Bavykin. All rights reserved.
//

import Foundation

enum ReportType: String {
    case JSON = "json"
    case XML = "xml"
}

func reportDataAsJSON(data: JSONRepresentable) -> Void {
    NSLog(data.descriptionAsJson())
}

func reportDataAsXML(data: XMLRepresetable) -> Void {
    NSLog(data.descriptionAsXml())
}