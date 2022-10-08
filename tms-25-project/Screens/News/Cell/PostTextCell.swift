//
//  TextCell.swift
//  tms-25-project
//
//  Created by Daria Sechko on 18.09.22.
//

import UIKit

class PostTextCell: UITableViewCell {
    
    static var reuseId = "PostTextCell"
    
    var titleLabel: UILabel = {
        let label = UILabel()

        return label
    }()
    
    //MARK: - Lifecycle
    override func prepareForReuse() {
        titleLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        lazy var label: UILabel = self.createTitleLabel()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - Public
    
    func configure(_ model: PostModelCell) {
        titleLabel.text = model.text
    }
}
