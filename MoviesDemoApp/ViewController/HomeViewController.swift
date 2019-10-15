//
//  HomeViewController.swift
//
//  Created by Sudhakar Reddy M on 15/10/19.
//  Copyright © 2019 Sudhakar Reddy M. All rights reserved.
//
import UIKit
class HomeViewController: UIViewController {
    var viewModel: NowPlayingViewModel = NowPlayingViewModel(networkManager: ServiceManager())
    var isRefreshInProgress = false
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(MovieCell.nib,
                                    forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        self.collectionView.backgroundColor = .darkGray
        self.navigationController?.view.backgroundColor = .darkGray

        if #available(iOS 11.0, *) {
            self.navigationController?.navigationItem.largeTitleDisplayMode =  .always
                self.navigationController?.navigationBar.prefersLargeTitles = true;

            // Change Color
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            // Fallback on earlier versions
        }

        if NetworkReachability.isInterNetExist() {
            isRefreshInProgress = true
            UtilsFunction.showOnLoader()
            viewModel.loadMoreData()
        } else {
            let alert = UIAlertController(title: "No Internet connection",
                                          message: "Turn on mobile data or use Wi-Fi to access data.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        self.title = "Movies"
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.isRefreshInProgress = false
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    UtilsFunction.hideOffLoader()
                }
            }
        }
    }
    private func navigateMovieDetailsWithSelectedMovieData(_ movieDetails: MovieResult) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier:
            "MovieDetailsViewController") as? MovieDetailsViewController else { return }
        controller.viewModel.movieDetailData = movieDetails
        navigationController?.pushViewController(controller, animated: true)
    }
}
// MARK: - UICollectioViewDataSource methods
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieDataResult.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier,
                                                      for: indexPath) as? MovieCell
        let movieResult = viewModel.movieDataResult[indexPath.row]
        cell?.configureCellWithData(moviePostUrl: movieResult.posterPath, title: movieResult.title)
        return cell ?? UICollectionViewCell()
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width) / 3.15, height: MovieCell.cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 5, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movieDataResult.count - 1 {
            // this is the last cell, load more data
            UtilsFunction.showOnLoader()
            viewModel.loadMoreData()
        }
    }
    @objc(collectionView:
    layout:
    minimumLineSpacingForSectionAtIndex:) func collectionView(_ collectionView: UICollectionView,
                                                              layout collectionViewLayout: UICollectionViewLayout,
                                                              minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateMovieDetailsWithSelectedMovieData(viewModel.movieDataResult[indexPath.row])
    }
}
