//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 28/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {

    private lazy var userImage = RoundImageView()

    private lazy var userText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    private func setup() {
        contentView.addSubviews(userImage, userText)
        userImage.snp.makeConstraints { make in
            make.size.equalTo(80)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        userText.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.greaterThanOrEqualToSuperview()
        }
    }

    public func configure(viewModel: UserCellViewModel) {
        userImage.backgroundColor = UIColor.white
        userText.text = viewModel.textLabelText
        if let url = viewModel.url{
            let avatarURL = URL(string: url)
            userImage.kf.setImage(
                with: avatarURL,
                placeholder: UIImage(),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        }
        layoutIfNeeded()
    }
}

extension UserCell: UserCellViewModelViewDelegate {
    func userImageFetched() {
        setNeedsLayout()
    }
}
