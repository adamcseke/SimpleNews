//
//  CustomTableViewCell.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 11. 29..
//

import UIKit
import SDWebImage

protocol CellDelegate: AnyObject {
    func buttonTapped(at indexPath: IndexPath)
}

class CustomTableViewCell: UITableViewCell {
    
    weak var delegate: CellDelegate?
    private var indexPath: IndexPath?
    
    private let cellView = UIView()
    private let newsTitleLabel = UILabel()
    private let sourceLabel = UILabel()
    private let dateLabel = UILabel()
    private let gradientLayer = CAGradientLayer()
    private let saveButton = UIButton()
    private let cellBackgroundImageView = UIImageView()
    private let alertView = UIAlertController(title: "Saved to Favorites", message: "Yay, you just saved the news for later to read it.", preferredStyle: .actionSheet)
    private var query: String = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup() {
        selectionStyle = .none
        configureCellView()
        configureCellBackgroundView()
        configureSourceLabel()
        configureNewsTitleLabel()
        configureDateLabel()
        configureSaveButton()
        addGradientOnPhoto()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: cellBackgroundImageView.frame.width, height: cellBackgroundImageView.frame.height)
    }
    private func configureCellView() {
        contentView.addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    private func addGradientOnPhoto() {
        gradientLayer.colors = [UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0),
                                UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7).cgColor]
        self.cellBackgroundImageView.layer.insertSublayer(gradientLayer, at: 0)
    }
    private func configureCellBackgroundView() {
        cellView.addSubview(cellBackgroundImageView)
        cellBackgroundImageView.image = UIImage(named: "cellBackgroundImage")
        cellBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        cellBackgroundImageView.contentMode = .scaleAspectFill
        cellBackgroundImageView.layer.cornerRadius = 12
        cellBackgroundImageView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            cellBackgroundImageView.topAnchor.constraint(equalTo: cellView.topAnchor),
            cellBackgroundImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            cellBackgroundImageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            cellBackgroundImageView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
        ])
    }
    private func configureSourceLabel() {
        cellBackgroundImageView.addSubview(sourceLabel)
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.font = UIFont.systemFont(ofSize: 12)
        sourceLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            sourceLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            sourceLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            sourceLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -150),
        ])
    }
    private func configureNewsTitleLabel() {
        cellBackgroundImageView.addSubview(newsTitleLabel)
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.numberOfLines = 2
        newsTitleLabel.textColor = .white
        newsTitleLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        
        NSLayoutConstraint.activate([
            newsTitleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            newsTitleLabel.bottomAnchor.constraint(equalTo: sourceLabel.topAnchor, constant: -10),
            newsTitleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -5),
        ])
    }
    private func configureDateLabel() {
        cellBackgroundImageView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            dateLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            dateLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 10)
        ])
    }
    private func configureSaveButton() {
        cellView.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setImage(UIImage(systemName: "bookmark")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal), for: .normal)
        saveButton.setImage(UIImage(systemName: "bookmark.fill")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal), for: .selected)
        saveButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.30).cgColor
        saveButton.layer.cornerRadius = 20
        saveButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    @objc func buttonTapped() {
        saveButton.isSelected.toggle()
        if let indexPath = indexPath, let delegate = delegate {
            delegate.buttonTapped(at: indexPath)
        }
        
        UIView.animate(withDuration: 0.05,
            animations: {
                self.saveButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.saveButton.transform = CGAffineTransform.identity
                }
            })
    }
    func bind(titleLabelText: String,
              sourceLabelText: String,
              dateLabelText: String,
              backgroundImageURL: String,
              indexPath: IndexPath,
              delegate: CellDelegate?,
              isFavorite: Bool) {
        sourceLabel.text = sourceLabelText
        newsTitleLabel.text = titleLabelText
        dateLabel.text = dateLabelText
        cellBackgroundImageView.sd_setImage(with: URL(string: backgroundImageURL), placeholderImage: UIImage(named: "cellBackgroundImage"))
        self.indexPath = indexPath
        self.delegate = delegate
        saveButton.isSelected = isFavorite
    }
}

