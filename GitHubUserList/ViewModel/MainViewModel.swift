//
//  MainViewModel.swift
//  GitHubUserList
//
//  Created by EMCT on 2022/4/8.
//

import Foundation

class MainViewModel {
    private var cellViewModels: [MainCellViewModel] = [MainCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var reloadTableViewClosure: (() -> ())?
    
    var gitHubDatas: [GithubResponse] = [GithubResponse]()
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func initFetchData() {
        APIService.shared.fetchGitHubData { [weak self] results in
            switch results {
            case .success(let datas):
                self?.processFetchedGithubDatas(datas: datas)
            case .failure(let error):
                print(error)
            default:
                break
            }
        }
    }
    
    func createCellViewModel(data: GithubResponse) -> MainCellViewModel{
        return MainCellViewModel(imageUrl: data.avatar_url,
                                 nameText: data.login,
                                 personalUrl: data.url)
    }
    
    func processFetchedGithubDatas(datas: [GithubResponse]) {
        self.gitHubDatas = datas
        var vms = [MainCellViewModel]()
        for data in datas {
            vms.append(createCellViewModel(data: data))
        }
        self.cellViewModels = vms
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> MainCellViewModel {
        return cellViewModels[indexPath.row]
    }
}

extension MainViewModel {
    func cellPressed(at indexPath: IndexPath) {
        let data = self.gitHubDatas[indexPath.row]
    }
}
