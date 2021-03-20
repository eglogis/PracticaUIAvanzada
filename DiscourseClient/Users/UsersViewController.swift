//
//  UsersViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 28/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    let viewModel: UsersViewModel

    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.minimumInteritemSpacing = CGFloat(Constants.spacing)
        collectionLayout.minimumLineSpacing = CGFloat(Constants.lineSpacing)
        return collectionLayout
    }()

    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.alwaysBounceVertical = true
        collection.showsVerticalScrollIndicator = false
        collection.register(UserCell.self, forCellWithReuseIdentifier: UserCell.identifier)
        return collection
    }()

    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        title = "Usuarios"
        setupNavigationController()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icoAdd"), style: .plain, target: self, action: #selector(plusButtonTapped))
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icoSearch"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc func plusButtonTapped() {
        // Add user functionality
    }

    @objc func searchButtonTapped() {
        // Add search functionality
    }

    fileprivate func showErrorFetchingUsers() {
        showAlert("Error fetching users\nPlease try again later")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: Constants.advisorCellWidth, height: Constants.advisorCellHeight)
        }
    }
}

extension UsersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.identifier, for: indexPath) as? UserCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) {
            cell.configure(viewModel: cellViewModel)
            return cell
        }
        fatalError()
    }
}

extension UsersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension UsersViewController: UsersViewModelViewDelegate {
    func usersWereFetched() {
        collectionView.reloadData()
    }

    func errorFetchingUsers() {
        showErrorFetchingUsers()
    }
}

private struct Constants {
    static let spacing = 20
    static let lineSpacing = 18
    static let advisorCellWidth = 94
    static let advisorCellHeight = 124
}
