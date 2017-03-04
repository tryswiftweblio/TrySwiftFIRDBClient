//
//  main.swift
//  TrySwiftFIRDBClient
//
//  Created by Takayoshi Fujiki on 2017/03/04.
//  Copyright © 2017 Weblio, Inc. All rights reserved.
//

import Foundation

let DEFAULT_CONFIG = TrySwiftFIRDBClientConfig(
    dbUrl: URL(string: "https://tryswiftfirdbclient-ceca0.firebaseio.com/")!,
    apiSecret: "E826Cq9Lsz9LvcfHtjEIVa1SrMeEESed3y59dqDE")

let USAGE = "app [--db-url url] [--api-secret key] [get|post|put|delete|patch [args ...]]"

let args = parseArgs()!
let options: [String:String]! = args.optionalArgsMap
let positionalArgs: [String]! = args.positionalArgs

if options["--help"] != nil {
    print(USAGE)
    exit(0)
}

let config : TrySwiftFIRDBClientConfig = TrySwiftFIRDBClientConfig(
    dbUrl: options["--db-url"] != nil ? URL(string: options["--db-url"]!)! : DEFAULT_CONFIG.dbUrl,
        apiSecret: options["--api-secret"] ?? DEFAULT_CONFIG.apiSecret)

let command = positionalArgs.first ?? "get"
switch command {
    case "get":
        let semaphore = DispatchSemaphore(value:0)
        let path = positionalArgs.count > 1 ? positionalArgs[1] : ""
        let client : TrySwiftFIRDBClient = TrySwiftFIRDBClient(config: config)
        client.get(path: path) { (responseData, response, error) in
            if responseData != nil && error == nil {
                let json = try! JSONSerialization.data(withJSONObject: responseData as Any, options: .prettyPrinted)
                print(String(data: json, encoding: .utf8)!)
            } else {
                print("\(error)")
                exit(1)
            }
            semaphore.signal()
        }
        semaphore.wait()
        break
    case "post":
        guard positionalArgs.count > 2, let value = positionalArgs[2].data(using: .utf8) else {
            print("error")
            exit(1)
        }
        let semaphore = DispatchSemaphore(value:0)
        let path = positionalArgs[1]

        let client : TrySwiftFIRDBClient = TrySwiftFIRDBClient(config: config)
        client.post(value: value, path: path) { (responseData, response, error) in
            if responseData != nil && error == nil {
                let json = try! JSONSerialization.data(withJSONObject: responseData as Any, options: .prettyPrinted)
                print(String(data: json, encoding: .utf8)!)
            } else {
                print("\(error)")
                exit(1)
            }
            semaphore.signal()
        }
        semaphore.wait()
        break
    case "put":
        break
    case "delete":
        let semaphore = DispatchSemaphore(value:0)
        let path = positionalArgs.count > 1 ? positionalArgs[1] : ""
        let client : TrySwiftFIRDBClient = TrySwiftFIRDBClient(config: config)
        client.delete(path: path) { (result, response, error) in
            if error == nil {
                print(result)
            } else {
                print("\(error)")
                exit(1)
            }
            semaphore.signal()
        }
        semaphore.wait()
        break
    case "patch":
        break
    default:
        print(USAGE)
        exit(1)
}
