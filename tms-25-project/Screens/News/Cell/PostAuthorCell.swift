//
//  AuthorCell.swift
//  tms-25-project
//
//  Created by Daria Sechko on 18.09.22.
//

import UIKit
import SnapKit
import SDWebImage

class PostAuthorCell: UITableViewCell {
    
    static var reuseId = "PostAuthorCell"
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill //растянуть
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
        photoImageView.image = nil
        nameLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        lazy var nameLabel: UILabel = UILabel.createNameLabel()
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private

    private func setupViews() {
        contentView.addSubview(photoImageView)//в ячейках отличается корневая вьюшка
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        
        photoImageView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(20)
            make.width.height.equalTo(80)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    //MARK: - Public
    
    func configure(_ model: PostModelCell) {
        
        nameLabel.text = model.authorName
        
        if let url = URL.init(string: model.authorImageUrl) {
            photoImageView.sd_setImage(with: url)
        }
    }
}
//MARK: - Extension
extension UILabel {
    static func createNameLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }
}
