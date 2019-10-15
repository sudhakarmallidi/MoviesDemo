//
//  ServiceManager.swift
//
//  Created by Sudhakar Reddy M on 15/10/19.
//  Copyright © 2019 Sudhakar Reddy M. All rights reserved.
//
import Foundation
import UIKit
enum ServiceResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}
enum Result<String> {
    case success
    case failure(String)
}
struct ServiceManager {
    static let environment: NetworkEnvironment = .production
    let router = BaseNetworkRouter<GetMovielistApi>()
    func getNowPlayingListData(page: Int,
                               completion: @escaping (_ dataModel: BaseDataModel?,
        _ error: String?) -> Void) {
        router.request(.nowPlaying(page: page)) { data, response, error in
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, ServiceResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let apiResponse = try BaseDataModel.init(data: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        print(error)
                        completion(nil, ServiceResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getSimilarMovieData(movieID: Int,
                             completion: @escaping (_ dataModel: BaseDataModel?,
        _ error: String?) -> Void) {
        router.request(.similar(movieId: movieID)) { data, response, error in
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, ServiceResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let apiResponse = try BaseDataModel.init(data: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        print(error)
                        completion(nil, ServiceResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(ServiceResponse.authenticationError.rawValue)
        case 501...599: return .failure(ServiceResponse.badRequest.rawValue)
        case 600: return .failure(ServiceResponse.outdated.rawValue)
        default: return .failure(ServiceResponse.failed.rawValue)
        }
    }
}
