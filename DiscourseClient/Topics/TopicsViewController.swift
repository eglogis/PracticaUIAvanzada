//
//  TopicsViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit
import SnapKit

/// ViewController que representa un listado de topics
class TopicsViewController: UIViewController {

    lazy var tableHeader = TableHeaderView()

    lazy var refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.refreshControl = refresh
        table.tableHeaderView = tableHeader
        table.tableHeaderView?.frame.size.height = 150
        table.register(TopicCell.self, forCellReuseIdentifier: TopicCell.identifier)
        table.estimatedRowHeight = UITableView.automaticDimension
        table.rowHeight = UITableView.automaticDimension
        return table
    }()

    lazy var plusButton: UIImageView = {
        let button = UIImageView()
        button.image = UIImage(named: "addFab")
        button.isUserInteractionEnabled = true
        return button
    }()

    let viewModel: TopicsViewModel

    init(viewModel: TopicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.viewWasLoaded()
    }

    func setup() {
        view.addSubviews(tableView, plusButton)
        title = "Temas"
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        plusButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12 + (tabBarController?.tabBar.frame.height ?? 0))
        }

        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icoAdd"), style: .plain, target: self, action: #selector(plusButtonTapped))
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icoSearch"), style: .plain, target: self, action: #selector(searchButtonTapped))
        rightBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc func plusButtonTapped() {
        viewModel.plusButtonTapped()
    }

    @objc func searchButtonTapped() {
        // Add search functionality
    }

    @objc func refresh(_ sender: AnyObject) {
        viewModel.viewWasLoaded()
    }

    fileprivate func showErrorFetchingTopicsAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topics\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
}

extension TopicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TopicCell.identifier, for: indexPath) as? TopicCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) {
            cell.configure(viewModel: cellViewModel)
            return cell
        }
        fatalError()
    }
}

extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension TopicsViewController: TopicsViewDelegate {

    func topicsFetched() {
        refresh.endRefreshing()
        tableView.reloadData()
    }

    func errorFetchingTopics() {
        showErrorFetchingTopicsAlert()
    }
}
