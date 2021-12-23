//
//  NewsDetailViewController.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 12. 09..
//

import UIKit
import Lottie
import SDWebImage
import SafariServices

class NewsDetailViewController: UIViewController, UIScrollViewDelegate {
    
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    private let newsImageView = UIImageView()
    private let newsTitleLabel = UILabel()
    private let newsSourceLabel = UILabel()
    private let newsDateLabel = UILabel()
    private let newsDescriptionLabel = UILabel()
    private let bookAnimationView = AnimationView(name: "readAnimation")
    private let readArticleButton = UIButton()
    private let gradientLayer = CAGradientLayer()
    private let formatter = DateFormatter()
    
    private var selectedNews: Article
    
    init(selectedNews: Article) {
        self.selectedNews = selectedNews
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bookAnimationView.play()
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .clear
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: newsImageView.frame.size.width, height: newsImageView.frame.size.height)
    }
    private func setup() {
        configureNavigationController()
        configureScrollView()
        configureNewsImage()
        configureNewsTitle()
        configureNewsSource()
        configureNewsDate()
        configureNewsDescription()
        setupBookAnimation()
        setupReadArticleButton()
    }
    private func configureNavigationController() {
        navigationItem.title = selectedNews.title
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .systemBackground
    }
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 750)
        ])
    }
    private func configureNewsImage() {
        view.addSubview(newsImageView)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.layer.masksToBounds = true
        newsImageView.sd_setImage(with: URL(string: selectedNews.urlToImage ?? ""))
        
        gradientLayer.colors = [UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0).cgColor,
                                UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor]
        self.newsImageView.layer.insertSublayer(gradientLayer, at: 0)
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: -20),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImageView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    private func configureNewsTitle() {
        newsImageView.addSubview(newsTitleLabel)
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        newsTitleLabel.text = selectedNews.title
        newsTitleLabel.numberOfLines = 2
        newsTitleLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 250),
            newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    private func configureNewsSource() {
        newsImageView.addSubview(newsSourceLabel)
        newsSourceLabel.translatesAutoresizingMaskIntoConstraints = false
        newsSourceLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        newsSourceLabel.text = selectedNews.author
        newsSourceLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            newsSourceLabel.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: -10),
            newsSourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsSourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    private func configureNewsDate() {
        newsImageView.addSubview(newsDateLabel)
        let date = selectedNews.publishedAt
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        newsDateLabel.translatesAutoresizingMaskIntoConstraints = false
        newsDateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        newsDateLabel.text = formatter.string(from: date)
        newsDateLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            newsDateLabel.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: -10),
            newsDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    private func configureNewsDescription() {
        contentView.addSubview(newsDescriptionLabel)
        newsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        newsDescriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        newsDescriptionLabel.numberOfLines = 5
        newsDescriptionLabel.text = selectedNews.articleDescription
        newsDescriptionLabel.textColor = .label
        
        NSLayoutConstraint.activate([
            newsDescriptionLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 10),
            newsDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            newsDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
    private func setupBookAnimation() {
        bookAnimationView.frame = view.bounds
        bookAnimationView.contentMode = .scaleAspectFit
        bookAnimationView.loopMode = .loop
        bookAnimationView.animationSpeed = 0.5
        bookAnimationView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookAnimationView)
        
        NSLayoutConstraint.activate([
            bookAnimationView.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 20),
            bookAnimationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bookAnimationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    private func setupReadArticleButton() {
        readArticleButton.layer.cornerRadius = 20
        readArticleButton.layer.backgroundColor = UIColor(red: 239/255, green: 163/255, blue: 15/255, alpha: 1).cgColor
        readArticleButton.setTitle("Read article".localized, for: .normal)
        readArticleButton.setTitleColor(.label, for: .normal)
        readArticleButton.translatesAutoresizingMaskIntoConstraints = false
        readArticleButton.addTarget(self, action: #selector(readArticleButtonTapped), for: .touchUpInside)
        contentView.addSubview(readArticleButton)
        
        NSLayoutConstraint.activate([
            readArticleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            readArticleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            readArticleButton.topAnchor.constraint(equalTo: bookAnimationView.bottomAnchor, constant: -50),
            readArticleButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            readArticleButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    @objc func readArticleButtonTapped() {
        guard let url = URL(string: selectedNews.url ?? "") else {
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        navigationController?.present(safariViewController, animated: true, completion: nil)
    }
}
