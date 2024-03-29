//
//  NowPlayingViewModel.swift
//  SampleMovieList
//
//  Created by Sudhakar Reddy M on 15/10/19.
//  Copyright © 2019 Sudhakar Reddy M. All rights reserved.
//

import UIKit
protocol reloadDataWithCollectionView {
    func reloadDataWithSucess(completion: @escaping () -> Void)
}
class NowPlayingViewModel: BaseProtocols {
    var movieDataResult: [MovieResult] = [MovieResult]()
    var networkManager: ServiceManager!
    var page: Int = 1
    var totalPages: Int = 1
    var reloadTable: () -> Void = { }
    init(networkManager: ServiceManager) {
        self.networkManager = networkManager
    }
}
extension NowPlayingViewModel: reloadDataWithCollectionView {
    func reloadDataWithSucess(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.networkManager.getNowPlayingListData(page: self.page, completion: { ( movies, error) in
                if let serverError = error, !serverError.isEmpty {
                } else {
                    DispatchQueue.main.async {
                        guard let responseData = movies else {
                            return
                        }
                        self.movieDataResult += responseData.movieResults ?? self.movieDataResult
                        self.page += 1
                        self.totalPages = movies?.totalPages ?? 1
                        completion()
                    }
                }
            })
        }
    }
    func loadMoreData() {
        if shouldLoadMoreData(totalPage: self.totalPages, totalPageLoaded: self.page) {
            self.reloadDataWithSucess(completion: { [weak self] in
                self?.reloadTable()
            })
        }
    }
    // Condition to check load more data
    func shouldLoadMoreData(totalPage: Int, totalPageLoaded: Int) -> Bool {
        return ( totalPage >= totalPageLoaded )
    }
}
