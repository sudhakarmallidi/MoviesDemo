//
//  BaseURLWithRouterType.swift
//  MVVM-Example
//
//  Created by Sudhakar Reddy M on 15/10/19.
//  Copyright © 2019 Ivan Magda. All rights reserved.
//

import Foundation
enum NetworkEnvironment {
    case production
    case staging
}
public enum GetMovielistApi {
    case nowPlaying(page: Int)
    case similar(movieId: Int)
}
extension GetMovielistApi: ServiceRouterType {
    var environmentBaseURL: String {
        switch ServiceManager.environment {
        case .production: return "https://api.themoviedb.org/3/movie/"
        case .staging: return "https://api.themoviedb.org/3/movie/"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    var path: String {
        switch self {
        case .nowPlaying:
            return "now_playing"
        case .similar(let movieId):
            return "\(movieId)/similar"
        }
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    var task: HTTPTask {
        switch self {
        case .nowPlaying(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page": page, "api_key": BaseConstant.API_KEY])
        case .similar:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key": BaseConstant.API_KEY])
        }
    }
    var headers: HTTPHeaders? {
        return nil
    }
}
