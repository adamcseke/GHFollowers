//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 08..
//

import UIKit
import SnapKit
import TBEmptyDataSet

class FollowerListViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var addFavoritesButton: UIButton!
    
    private var followers: [Follower] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    private var user: User?
    private var username: String?
    private var page: Int?
    
    private var isFavorite: Bool = false
    private var deleted: Bool = true
    private var inserted: Bool = false
    
    private var searchVC: SearchViewController = SearchViewController()
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tabBarController?.tabBar.isHidden = true
        isFavorite = isInTheFavorites(name: username ?? "")
        changeFavoriteButton(isFavorite: isFavorite)
    }
    
    private func setup() {
        configureViewController()
        configureCollectionView()
        configureNavigationController()
        getFollowersData()
        changeFavoriteButton(isFavorite: isFavorite)
    }
    
    private func getFollowers(user: String, page: Int) {
        RestClient.shared.getFollowers(user: user, page: page) { result in
            switch result {
                
            case .success(let follower):
                self.followers = follower
            case .failure(let error):
                if let error = error as? GithubError {
                    switch error {
                    case .wrongURL:
                        print("Wrong url")
                    }
                    
                }
                print(error.localizedDescription)
                return
            }
        }
    }
    
    private func getUserInfo(user: String, completion: @escaping () -> ()) {
        RestClient.shared.getUserInfo(user: user) { result in
            switch result {
                
            case .success(let user):
                self.user = user
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func getFollowersData() {
        getFollowers(user: self.username ?? "", page: page ?? 0)
    }
    
    private func configureNavigationController() {
        navigationItem.title = username
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: #selector(didTapGetUserInfoButton))
    }
    
    @objc private func didTapGetUserInfoButton() {
        getUserInfo(user: username ?? "") {
            guard let user = self.user else {
                return
            }
            
            if self.isFavorite {
                DatabaseManager.main.delete(username: self.username ?? "") { _ in
                    self.isFavorite = false
                    self.changeFavoriteButton(isFavorite: self.isFavorite)
                }
            } else {
                DatabaseManager.main.insert(username: self.username ?? "", avatar: user.avatarURL) { _ in
                    self.isFavorite = true
                    self.changeFavoriteButton(isFavorite: self.isFavorite)
                }
            }
        }
        
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        
        let width =  view.bounds.width
        let availableWidth = width - 50
        let itemWidth = availableWidth / 3.2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 30, left: 12, bottom: 12, right: 12)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 25)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: "followerCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.emptyDataSetDataSource = self
        collectionView.emptyDataSetDelegate = self
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension FollowerListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUser = followers[indexPath.row]
        getUserInfo(user: selectedUser.login) {
            guard let user = self.user else {
                return
            }
            let selectedUserVC = UserInfoViewController(selectedUser: user)
            self.navigationController?.pushViewController(selectedUserVC, animated: true)
        }
    }
}

extension FollowerListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "followerCell", for: indexPath) as? FollowerCell else {
            return UICollectionViewCell()
        }
        let followers = followers[indexPath.row]
        cell.set(userImageUrl: followers.avatarUrl, userTitle: followers.login)
        return cell
    }
}

extension FollowerListViewController: TBEmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(in scrollView: UIScrollView) -> Bool {
        return followers.count == 0
    }
}

extension FollowerListViewController: TBEmptyDataSetDataSource {
    
    func customViewForEmptyDataSet(in scrollView: UIScrollView) -> UIView? {
        let view = EmptyView(frame: scrollView.frame)
        view.bind(text: "EmptyFollowersView.EmptyLabel".localized)
        return view
    }
}
