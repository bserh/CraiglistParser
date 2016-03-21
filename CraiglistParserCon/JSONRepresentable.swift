//
//  JSONRepresentable.swift
//  CraiglistParserCon
//
//  Created by Sergey Bavykin on 3/21/16.
//  Copyright © 2016 Sergey Bavykin. All rights reserved.
//

import Foundation

protocol JSONRepresentable {
    
    func descriptionAsJson() -> String
}