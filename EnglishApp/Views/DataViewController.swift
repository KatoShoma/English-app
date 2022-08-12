//
//  DataViewController.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/12.
//

import UIKit

class DataViewController: UIViewController, UICollectionViewDelegate {

    private var collectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewLayout {
        UICollectionViewCompositionalLayout { _, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
            configuration.headerMode = .supplementary
            configuration.backgroundColor = .white
            let section = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )
            return section
        }
    }

    let titleLabel: UILabel = {
        let view = UILabel.init()
        view.text = "スクリーン2"
        view.translatesAutoresizingMaskIntoConstraints = false // NSLayoutConstraintの利用に必要
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "学習記録"
        navigationItem.largeTitleDisplayMode = .never
        setupHierarchy()
    }

    private func setupHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.delegate = self
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}
