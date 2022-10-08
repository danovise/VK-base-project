//
//  LikesCell.swift
//  tms-25-project
//
//  Created by Daria Sechko on 18.09.22.
//

import UIKit

class PostLikesCell: UITableViewCell {
    
    static var reuseId = "PostLikesCell"
    
    var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail //троеточие при большом тексте
        label.text = "♥️ 0"
        
        return label
    }()
    
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
        likesLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    
    private func setupViews() {
        contentView.addSubview(likesLabel)
    }
    
    private func setupConstraints() {
        
        likesLabel.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - Public
    
    func configure(_ model: PostModelCell) {
        likesLabel.text = "♥️ \(model.likesCount)"
    }
}
