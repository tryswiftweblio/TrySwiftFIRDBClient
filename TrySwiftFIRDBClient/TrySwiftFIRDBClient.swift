//
//  TrySwiftFIRDBClient.swift
//  TrySwiftFIRDBClient
//
//  Created by Takayoshi Fujiki on 2017/03/04.
//  Copyright © 2017 Weblio, Inc. All rights reserved.
//

import Foundation

fileprivate enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class TrySwiftFIRDBClient {
    let config: TrySwiftFIRDBClientConfig
    let session: URLSession = URLSession.shared

    init(config: TrySwiftFIRDBClientConfig) {
        self.config = config
    }

    fileprivate func createMutableUrlRequest(path: String? = nil) -> NSMutableURLRequest! {
        return createMutableUrlRequest(method: .get, path: path)
    }

    fileprivate func createMutableUrlRequest(method: HttpMethod, path: String? = nil) -> NSMutableURLRequest! {
        let regex = try! NSRegularExpression(pattern: "^/+", options: [])
        let p = (path ?? "")
        let range = NSMakeRange(0, p.characters.count)
        let normedPath = regex.stringByReplacingMatches(
            in: p,
            options: [],
            range: range,
            withTemplate: "")
        let url = URL(string: "\(config.dbUrl.appendingPathComponent(normedPath).absoluteString).json")!

        let components: NSURLComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem]()
        components.queryItems?.append(URLQueryItem(name: "auth", value: config.apiSecret))
        let mutableRequest = NSMutableURLRequest(url: components.url!)
        mutableRequest.httpMethod = method.rawValue
        return mutableRequest
    }

    func get(path: String? = nil, completionHandler: @escaping (NSDictionary?, URLResponse?, Error?) -> Void) {
        let request: URLRequest = createMutableUrlRequest(path: path) as URLRequest
        let task = session.dataTask(with: request) { (data, response, error) in
            var result: NSDictionary? = nil

            if data != nil && error == nil {
                result = try! JSONSerialization.jsonObject(with: data!, options: [.mutableContainers]) as! NSDictionary
            }
            completionHandler(result, response, error)
        }
        task.resume()
    }

    func post(value: Any, path: String? = nil, completionHandler: @escaping (NSDictionary?, URLResponse?, Error?) -> Void) {
        let mutableRequest: NSMutableURLRequest = createMutableUrlRequest(method: .post, path: path)
        let jsonData = try! JSONSerialization.data(withJSONObject: value)
        mutableRequest.httpBody = jsonData
        let request: URLRequest = mutableRequest as URLRequest
        let task = session.dataTask(with: request) { (data, response, error) in
            var result: NSDictionary? = nil
            if data != nil && error == nil {
                result = try! JSONSerialization.jsonObject(with: data!, options: [.mutableContainers]) as! NSDictionary
            }
            completionHandler(result, response, error)
        }
        task.resume()
    }
    
    func put(value: Any, path: String? = nil, parameter: String? = nil, completionHandler: @escaping (NSDictionary?, URLResponse?, Error?) -> Void) {
        var request: URLRequest = createMutableUrlRequest(method: .put, path: path) as URLRequest
        request.httpBody = try! JSONSerialization.data(withJSONObject: value)
        let task = session.dataTask(with: request) { (data, response, error) in
            var result: NSDictionary? = nil
            if data != nil && error == nil {
                result = try! JSONSerialization.jsonObject(with: data!, options: [.mutableContainers]) as! NSDictionary
            }
            completionHandler(result, response, error)
        }
        task.resume()
    }
    
    func patch() {}
    func delete(path: String, completionHandler: @escaping (String, URLResponse?, Error?) -> Void) {
        if path.isEmpty {
            print("error")
            return
        }
        let request: URLRequest = createMutableUrlRequest(method: .delete, path: path) as URLRequest
        let task = session.dataTask(with: request) { (data, response, error) in
            var result: String = "error"

            if error == nil {
                result = "success"
            }
            completionHandler(result, response, error)
        }
        task.resume()
    }
}
