import SnapKit
import UIKit

class TableHeaderView: UIView {
    // MARK: Views
    private let cardContainer: UIView = {
        let card = UIView()
        card.backgroundColor = UIColor.tangerine
        card.layer.cornerRadius = 8
        return card
    }()

    private let pinImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pin")
        return image
    }()

    private let titleLabel: UILabel = {
        let text = UILabel()
        text.text = "Bienvenido e eh.ho"
        text.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return text
    }()

    private let subtitleLabel: UILabel = {
        let text = UILabel()
        text.text = "Discourse Setup The first paragraph of this pinned topicafffas afasfasfa afafasfasf afasfa"
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.numberOfLines = 2
        return text
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        backgroundColor = .black

        addSubviews(
            cardContainer.addSubviews(
                titleLabel,
                pinImage,
                subtitleLabel
            )
        )

        cardContainer.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(24)
            make.leading.trailing.equalToSuperview().inset(16).priority(.high)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(8)
        }

        pinImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(8)
            make.width.equalTo(30)
            make.height.equalTo(35)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.trailing.equalToSuperview().offset(-73)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}
