//  NetworkLogger.swift
//  NetworkLayer
//
//  Created by Sudhakar Reddy M on 15/10/19.
//  Copyright © 2019 Sudhakar Reddy M. All rights reserved.

import Foundation
class ServiceLogs {
    static func log(request: URLRequest) {
        let urlBaseString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlBaseString)
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        var logOutput = """
                        \(urlBaseString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
       // print(logOutput)
    }
    static func log(response: URLResponse) {}
}
