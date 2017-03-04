//
//  main.swift
//  TrySwiftFIRDBClient
//
//  Created by Takayoshi Fujiki on 2017/03/04.
//  Copyright © 2017 Weblio, Inc. All rights reserved.
//

import Foundation

let config : TrySwiftFIRDBClientConfig = TrySwiftFIRDBClientConfig(
        dbUrl: URL(string: "https://tryswiftfirdbclient-ceca0.firebaseio.com/")!,
        apiSecret: "E826Cq9Lsz9LvcfHtjEIVa1SrMeEESed3y59dqDE")

let semaphore = DispatchSemaphore(value:0)
let client : TrySwiftFIRDBClient = TrySwiftFIRDBClient(config: config)
client.get { (responseData, response, error) in
    print("\(responseData)")
    semaphore.signal()
}

semaphore.wait()


//client.get(path: "")
//client.get(path: "/")
//client.get(path: "/messages")

