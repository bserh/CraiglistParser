//
//  ContinentPageParser.swift
//  CraiglistParserCon
//
//  Created by Sergey Bavykin on 3/14/16.
//  Copyright © 2016 Sergey Bavykin. All rights reserved.
//

import Foundation
import Kanna

class ContinentPageParser {
    private let urlString = "http://www.craigslist.org/about/sites"
    
    var url: NSURL
    
    init() {
        self.url = NSURL(string: urlString)!
    }
    
    func parseContinentsInfoFromCraigList(completionHandler: (data: ContinentContainer) -> Void) {
        loadHtmlByUrl(self.url, callbackHandler: { htmlAsString in
            let data = self.retrieveContinentContainerFrom(htmlDocument: htmlAsString)
            
            completionHandler(data: data)
        })
    }
    
    private func loadHtmlByUrl(url: NSURL, callbackHandler: (htmlAsString: String) -> ()) {
        let request = NSURLRequest(URL: url)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = ["User-Agent": "simple HTTP agent"]
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {
            data, response, error in
            
            guard let htmlAsString = String(data: data!, encoding: NSUTF8StringEncoding) else {
                NSLog("unable to load html page by specified url")
                return
            }
            
            callbackHandler(htmlAsString: htmlAsString)
        });
        
        task.resume()
    }
    
    private func retrieveContinentContainerFrom(htmlDocument htmlDocument: String) -> ContinentContainer {
        var continentContainer = ContinentContainer()
        
        if let document = Kanna.HTML(html: htmlDocument, encoding: NSUTF8StringEncoding) {
            continentContainer.continents = retrieveContinentsFromDocument(document)
        }
        
        return continentContainer
    }
    
    private func retrieveSitesLinksFromDocument(document: HTMLDocument) -> [Site] {
        var sites = [Site]()
        
        let linksList = document.xpath("//a")
        for link in linksList {
            var site = Site()
            
            site.name = link.text!
            site.url = link["href"]
            
            sites.append(site)
        }
        
        return sites
    }
    
    private func retrieveStatesFromDocument(document: HTMLDocument) -> [State] {
        var states = [State]()
        
        let h4SectionsWithCountryNames = document.xpath("//h4")
        let unorderedListsWithSites = document.xpath("//ul")
        
        var countryNames = h4SectionsWithCountryNames.map { $0.text! }
        
        var countryIndex = 0
        for setWithLinks in unorderedListsWithSites {
            var state = State()
            state.name = countryNames[countryIndex++]
            
            if let linksInColmaskBlock = Kanna.HTML(html: setWithLinks.innerHTML!, encoding: NSUTF8StringEncoding) {
                state.sites = retrieveSitesLinksFromDocument(linksInColmaskBlock)
            }
            states.append(state)
        }
        
        return states
    }
    
    private func retrieveContinentsFromDocument(document: HTMLDocument) -> [Continent] {
        var continents = [Continent]()
        
        let h1SectionWithContinentNames = document.xpath("//h1")
        let continentInfoContainer = document.css(".sites, .colmask")
        var continentNames = h1SectionWithContinentNames.map { $0.text! }
        
        var continentIndex = 0
        for countryNode in continentInfoContainer {
            guard continentIndex != 0 else {//excluding colmask figures in js script
                continentIndex++
                continue
            }
            var continent = Continent()
            
            continent.name = continentNames[continentIndex-1]
            
            if let colmaskBlock = Kanna.HTML(html: countryNode.innerHTML!, encoding: NSUTF8StringEncoding) {
                continent.states = retrieveStatesFromDocument(colmaskBlock)
            }
            
            continents.append(continent)
            continentIndex++
        }
        
        return continents
    }
}