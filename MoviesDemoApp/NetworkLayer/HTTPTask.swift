//  HTTPTask.swift
//  NetworkLayer
//
//  Created by Sudhakar Reddy M on 15/10/19.
//  Copyright © 2019 Sudhakar Reddy M. All rights reserved.
//

import Foundation
public typealias HTTPHeaders = [String: String]
public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    case requestParametersWithHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
    // case download, upload...etc
}
