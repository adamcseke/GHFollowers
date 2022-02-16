//
//  FavoritesViewController.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 07..
//

import UIKit
import SnapKit
import TBEmptyDataSet

class FavoritesViewController: UIViewController {
    
    private var tableView: UITableView!
    private var favorites: [Follower] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        configureViewController()
        configureTableView()
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .clear
        tabBarController?.tabBar.isHidden = false
        getFavorites()
    }
    private func configureViewController() {
        view.backgroundColor = .systemBackground
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
    
    private func getFavorites() {
        favorites = DatabaseManager.main.getUsers()
        print(favorites)
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseID)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetDataSource = self
        
        tableView.rowHeight = 80
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseID, for: indexPath) as? FavoritesCell else {
            return UITableViewCell()
        }
        let fav = favorites[indexPath.row]
        cell.set(imageURL: fav.avatarUrl, usernameLabelText: "\(fav.login)")
        print(fav.login)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = favorites[indexPath.row]
        getUserInfo(user: selectedUser.login) {
            guard let user = self.user else {
                return
            }
            let userInfoVC = UserInfoViewController(selectedUser: user)
            self.navigationController?.pushViewController(userInfoVC, animated: true)
        }
    }
}

extension FavoritesViewController: TBEmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(in scrollView: UIScrollView) -> Bool {
        return favorites.count == 0
    }
}

extension FavoritesViewController: TBEmptyDataSetDataSource {
    
    func customViewForEmptyDataSet(in scrollView: UIScrollView) -> UIView? {
        let view = EmptyView(frame: scrollView.frame)
        view.bind(text: "EmptyFavoritesView.EmptyLabel".localized)
        return view
    }
}
