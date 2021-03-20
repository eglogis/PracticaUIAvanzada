//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit
import Kingfisher

/// Celda que representa un topic en la lista
class TopicCell: UITableViewCell {

    private lazy var userImage = RoundImageView()

    private lazy var topicText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    private lazy var infoContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = CGFloat(Constants.infoContainerSpacing)
        return stack
    }()

    private lazy var messageContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = CGFloat(Constants.infoContainerItemSpacing)
        return stack
    }()

    private lazy var messageImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "message")
        image.contentMode = .scaleAspectFill
        return image
    }()

    private lazy var messageCountText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.alpha = 0.5
        return label
    }()

    private lazy var usersContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = CGFloat(Constants.infoContainerItemSpacing)
        return stack
    }()

    private lazy var userIconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "user")
        image.contentMode = .scaleAspectFill
        return image
    }()

    private lazy var usersCountText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.alpha = 0.5
        return label
    }()

    private lazy var calendarContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = CGFloat(Constants.infoContainerItemSpacing)
        return stack
    }()

    private lazy var calendarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "calendar")
        image.contentMode = .scaleAspectFill
        return image
    }()

    private lazy var calendarCountText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.alpha = 0.5
        label.text = "24"
        return label
    }()

    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    private func setup() {
        contentView.addSubviews(
            userImage,
            topicText,
            infoContainer.addArrangedSubviews(
                messageContainer.addArrangedSubviews(
                    messageImage,
                    messageCountText
                ),
                usersContainer.addArrangedSubviews(
                    userIconImage,
                    usersCountText
                ),
                calendarContainer.addArrangedSubviews(
                    calendarImage,
                    calendarCountText
                )
            )
        )

        userImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.leadingOffset)
            make.top.bottom.equalToSuperview().inset(Constants.leadingOffset).priority(.medium)
            make.size.equalTo(Constants.imageSize)
        }

        topicText.snp.makeConstraints { make in
            make.leading.equalTo(userImage.snp.trailing).offset(Constants.textLeadingOffset)
            make.trailing.equalToSuperview().offset(Constants.textTraillingOffset)
            make.top.equalToSuperview().offset(Constants.leadingOffset)
        }

        infoContainer.snp.makeConstraints { make in
            make.leading.equalTo(topicText.snp.leading)
            make.bottom.equalToSuperview().offset(Constants.bottomOffset)
        }

        calendarImage.snp.makeConstraints { make in
            make.size.equalTo(Constants.iconSize)
        }

        userIconImage.snp.makeConstraints { make in
            make.size.equalTo(Constants.iconSize)
        }

        messageImage.snp.makeConstraints { make in
            make.size.equalTo(Constants.iconSize)
        }
    }

    public func configure(viewModel: TopicCellViewModel) {
        userImage.backgroundColor = UIColor.white
        topicText.text = viewModel.textLabelText
        messageCountText.text = viewModel.messagesCount
        usersCountText.text = viewModel.usersCount
        calendarCountText.text = viewModel.calendarDate
        if let url = viewModel.imageURL{
            let avatarURL = URL(string: url)
            userImage.kf.setImage(
                with: avatarURL,
                placeholder: UIImage(),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.5)),
                    .cacheOriginalImage
                ])
        }
        layoutIfNeeded()
    }
}

private struct Constants {
    static let imageSize = 64
    static let leadingOffset = 16
    static let textLeadingOffset = 11
    static let textTraillingOffset = -60
    static let infoContainerSpacing = 8
    static let infoContainerItemSpacing = 4
    static let bottomOffset = -16
    static let iconSize = 12
}
