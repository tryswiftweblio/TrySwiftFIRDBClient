//
//  TrySwiftFIRDBClientConfig.swift
//  TrySwiftFIRDBClient
//
//  Created by Takayoshi Fujiki on 2017/03/04.
//  Copyright © 2017 Weblio, Inc. All rights reserved.
//

import Foundation

struct TrySwiftFIRDBClientConfig {
    let apiSecret: String!
    let dbUrl: URL!

    init(dbUrl: URL, apiSecret: String) {
        self.apiSecret = apiSecret

        let regex = try! NSRegularExpression(pattern: "/+$", options: [])
        let range = NSMakeRange(0, dbUrl.absoluteString.characters.count)
        let normedUrlString = regex.stringByReplacingMatches(
            in: dbUrl.absoluteString,
            options: [],
            range: range,
            withTemplate: "")
        self.dbUrl = URL(string: normedUrlString)!
    }
}
