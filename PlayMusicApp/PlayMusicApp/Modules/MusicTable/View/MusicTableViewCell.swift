//
//  MusicTableViewCell.swift
//  PlayMusicApp
//
//  Created by Даниил Циркунов on 22.06.2023.
//

import UIKit
import SnapKit

final class MusicTableViewCell: UITableViewCell {
    static let reuseIdentifier = "Cell"
    
    private let trackLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.dynamicTextColor
        label.font = Constants.Font.body
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.dynamicTextColor
        label.font = Constants.Font.body
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackLabel.text = nil
    }
    
    func configure(with model: MusicTableViewCellModel) {
        trackLabel.text = model.track
        durationLabel.text = model.duration
    }
}

// MARK: - Private extension

private extension MusicTableViewCell {
    func setupViews() {
        self.backgroundColor = Constants.Color.background
        self.contentView.addSubview(trackLabel)
        self.contentView.addSubview(durationLabel)
        
        trackLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(Constants.Spacing.standart)
            make.trailing.equalToSuperview().inset(50)
        }
        
        durationLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(Constants.Spacing.standart)
        }
    }
}

