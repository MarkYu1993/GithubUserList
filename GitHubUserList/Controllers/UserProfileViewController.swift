//
//  UserProfileViewController.swift
//  GitHubUserList
//
//  Created by EMCT on 2022/4/8.
//

import UIKit
import SDWebImage

class UserProfileViewController: UIViewController {
    
    var userUrl = ""
    
    var userData: PersonalResponse? {
        didSet {
            DispatchQueue.main.async {
                self.view.layoutIfNeeded()
                guard let userData = self.userData else {return}
                self.nameLabel.text = userData.name
                self.accountLabel.text = userData.login
                self.blogLabel.text = userData.blog
                self.locationLabel.text = userData.location
                self.timeLabel.text = userData.updated_at
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private let userProfileView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "testImage")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Kobe Bryant!"
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let personImageView: UIView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let accountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "KB24"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let locationImageView: UIView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.circle")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Taipei, Taiwan"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let blogImageView: UIView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "globe")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy private var blogLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.textAlignment = .left
        label.text = "https://www.google.com.tw/"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        // 變成超連結
        let tap = UITapGestureRecognizer(target: self, action: #selector(blogLabelTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }()
    
    private let timeImageView: UIView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clock.arrow.circlepath")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "2022-04-03T23:40:06Z"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        let xImage = UIImage(systemName: "x.circle")
        button.setImage(xImage, for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFill
        // 改變button大小
        button.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("didLoad")
        setupUI()
        fetchUserData(url: userUrl)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupAutoLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 進入此頁時需要時間更新UI
        sleep(1)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 0.5)
        userProfileView.backgroundColor = .white
        view.addSubview(userProfileView)
        userProfileView.addSubview(closeButton)
        userProfileView.addSubview(avatarImageView)
        userProfileView.addSubview(nameLabel)
        userProfileView.addSubview(separatorView)
        userProfileView.addSubview(personImageView)
        userProfileView.addSubview(accountLabel)
        userProfileView.addSubview(locationImageView)
        userProfileView.addSubview(locationLabel)
        userProfileView.addSubview(blogImageView)
        userProfileView.addSubview(blogLabel)
        userProfileView.addSubview(timeImageView)
        userProfileView.addSubview(timeLabel)
    }
    
    private func setupAutoLayout() {
        let padding = 16
        userProfileView.snp.makeConstraints {
            $0.top.equalTo(view).offset(80)
            $0.leading.equalTo(view).offset(padding)
            $0.trailing.equalTo(view).offset(-padding)
            $0.bottom.equalTo(timeLabel.snp.bottom).offset(padding*2)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(userProfileView).offset(padding)
            $0.leading.equalTo(userProfileView).offset(padding)
        }
        
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.snp.makeConstraints {
            $0.top.equalTo(closeButton)
            $0.centerX.equalTo(userProfileView)
            $0.height.equalTo(100)
            $0.width.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImageView.snp.bottom).offset(8)
            $0.centerX.equalTo(avatarImageView)
        }
        
        separatorView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(userProfileView)
            $0.trailing.equalTo(userProfileView)
        }
        
        personImageView.snp.makeConstraints {
            $0.top.equalTo(separatorView).offset(16)
            $0.leading.equalTo(userProfileView).offset(padding)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        
        accountLabel.snp.makeConstraints {
            $0.centerY.equalTo(personImageView)
            $0.leading.equalTo(personImageView.snp.trailing).offset(8)
        }
        
        locationImageView.snp.makeConstraints {
            $0.centerX.equalTo(personImageView)
            $0.top.equalTo(personImageView.snp.bottom).offset(8)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        
        locationLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationImageView)
            $0.leading.equalTo(locationImageView.snp.trailing).offset(8)
        }
        
        blogImageView.snp.makeConstraints {
            $0.centerX.equalTo(personImageView)
            $0.top.equalTo(locationImageView.snp.bottom).offset(8)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        
        blogLabel.snp.makeConstraints {
            $0.centerY.equalTo(blogImageView)
            $0.leading.equalTo(blogImageView.snp.trailing).offset(8)
        }
        
        timeImageView.snp.makeConstraints {
            $0.centerX.equalTo(personImageView)
            $0.top.equalTo(blogImageView.snp.bottom).offset(8)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(timeImageView)
            $0.leading.equalTo(timeImageView.snp.trailing).offset(8)
        }
        
    }
    
    @objc private func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func blogLabelTapped() {
        guard let blogLabelString = blogLabel.text else {return}
        guard let url = URL(string: blogLabelString) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func fetchUserData(url: String) {
        APIService.shared.fetchPersonalData(userUrl: url) { [weak self]results in
            switch results {
            case .success(let result):
                self?.userData = result
            case .failure(let error):
                print(error)
            }
        }
    }

}
