//
//  MainViewTableViewCell.swift
//  GitHubUserList
//
//  Created by EMCT on 2022/4/7.
//

import Foundation
import UIKit
import SDWebImage

class MainViewTableViewCell: UITableViewCell {
    static let identifier: String = "MainViewTableViewCell"
    
    var mainCellViewModel: MainCellViewModel? {
        didSet {
            let defaultImage = "https://www.gannett-cdn.com/presto/2020/01/26/USAT/048dcaa6-9da8-422f-a57f-2af33fb7ef3e-sw01_reg_4_1202.JPG"
            nameLabel.text = mainCellViewModel?.nameText
            headImageView.sd_setImage(with: URL(string: mainCellViewModel?.imageUrl ?? defaultImage), completed: nil)
        }
    }
    
    private var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private var headImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "testImage")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "MarkYu!!!!"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAutoLayout()
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(bgView)
        bgView.addSubview(headImageView)
        bgView.addSubview(nameLabel)
    }
    
    private func setupAutoLayout() {
        let padding = 16
        bgView.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(padding)
            $0.trailing.equalTo(contentView).offset(-padding)
            $0.top.equalTo(contentView).offset(8)
            $0.bottom.equalTo(contentView).offset(-8)
        }
        
        headImageView.snp.makeConstraints {
//            $0.centerY.equalTo(bgView)
            $0.top.equalTo(bgView).offset(8)
            $0.bottom.equalTo(bgView).offset(-8)
            $0.leading.equalTo(bgView).offset(padding)
            $0.width.equalTo(bgView.snp.height).offset(-16)
        }
        headImageView.layer.cornerRadius = headImageView.frame.width / 2
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(headImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(bgView)
        }
        
    }
}
