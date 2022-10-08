//
//  PhotoCell.swift
//  tms-25-project
//
//  Created by Daria Sechko on 18.09.22.
//

import UIKit
import SnapKit
import SDWebImage

class PostPhotoCell: UITableViewCell {
    
    static var reuseId = "PostPhotoCell"
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .darkGray
        
        return imageView
    }()
    
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
        photoImageView.image = nil
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
        contentView.addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        
        photoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(UIScreen.main.bounds.width)
            make.top.bottom.left.right.equalTo(contentView).inset(0)
        }
    }
    
    //MARK: - Public
    
    func configure(_ model: PostModelCell) {
        
        if let url = URL.init(string: model.photoUrl) {
            photoImageView.sd_setImage(with: url)
        }
    }
}
