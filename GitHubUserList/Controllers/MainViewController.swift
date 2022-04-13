//
//  ViewController.swift
//  GitHubUserList
//
//  Created by EMCT on 2022/4/6.
//

import UIKit

class MainViewController: UIViewController {

    // 跟MainViewModel做綁定(值)
    var viewModel: MainViewModel = {
        return MainViewModel()
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.register(MainViewTableViewCell.self, forCellReuseIdentifier: MainViewTableViewCell.identifier)
        return tableView
    }()
    
    // Loading動畫
    lazy var activityIndicator: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .large)
        loadingView.center = self.view.center
        return loadingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        initVM()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupUI() {
        title = "GitHub List"
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func initVM() {
        viewModel.initFetchData()
        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewTableViewCell.identifier, for: indexPath) as? MainViewTableViewCell else {return UITableViewCell()}
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.mainCellViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 讀取畫面
        activityIndicator.startAnimating()
        
        viewModel.cellPressed(at: indexPath)
        let vc = UserProfileViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        // 將url傳過去
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        let userUrl = cellVM.personalUrl
        vc.userUrl = userUrl
        present(vc, animated: true) {[weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}
