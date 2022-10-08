//
//  GroupsCell.swift
//  tms-25-project
//
//  Created by Daria Sechko on 28.08.22.
//

import UIKit
import SDWebImage

class GroupCell: UITableViewCell {
    
    static let reuseID = "GroupCell"
    
    var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(mainImageView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            mainImageView.widthAnchor.constraint(equalToConstant: 80),
            mainImageView.heightAnchor.constraint(equalToConstant: 80),
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            mainImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    //MARK: - Public
    
    func configure(_ scheme: Group) {
        nameLabel.text = "\(scheme.name)"
        
        let url = URL.init(string: scheme.photo100)
        mainImageView.sd_setImage(with: url)
    }
}


