//  EndPoint.swift
//  NetworkLayer
//
//  Created by Sudhakar Reddy M on 15/10/19.
//  Copyright © 2019 Sudhakar Reddy M. All rights reserved.
//
import Foundation
protocol ServiceRouterType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
