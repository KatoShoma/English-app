//
//  SettingViewController.swift
//  UniqueDictionary
//
//  Created by 加藤祥真 on 2022/07/31.
//

import Combine
import UIKit

final class SettingViewController: UIViewController, UICollectionViewDelegate {

    enum Section: Int, CaseIterable {
        case aboutApp, other
        var title: String {
            switch self {
            case .aboutApp:
                return "アプリについて"
            case .other:
                return "その他"
            }
        }
    }

    enum SectionItem: Int, CaseIterable {
        case review, share, hint, version
        var title: String {
            switch self {
            case .review:
                return "レビューを書く"
            case .share:
                return "友達に教える"
            case .hint:
                return "ヒントを見る"
            case .version:
                return "バージョン"
            }
        }
    }

    private var presenter: SettingPresenterProtocol
    private var collectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewLayout { // 画面上にどのように配置するか決定する
        UICollectionViewCompositionalLayout { _, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
            configuration.headerMode = .supplementary // header = Section
            configuration.backgroundColor = .settingPink // ここの色は変更
            let section = NSCollectionLayoutSection.list(// 指定されたリスト構成とレイアウト環境でリストセクションを作成
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )
            return section
        }
    }

    private var dataSource: UICollectionViewDiffableDataSource<Section, SectionItem>!// データをUIに紐づけて表示するクラス(第一引数: Section, 第二引数: Cell)
    private var cancellables: Set<AnyCancellable> = []

    // REFER: https://stackoverflow.com/questions/70439910/thread-1-fatal-error-initcoder-has-not-been-implemented
    required init?(coder: NSCoder) {
        self.presenter = SettingPresenter()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "設定"
        navigationItem.largeTitleDisplayMode = .never
        setupHierarchy()
        setupDataSource()
        configureDatasource()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true) // アイテムの指定
        guard let sectionItem = dataSource.itemIdentifier(for: indexPath) else { return }
        // 以下，セルを押した場合の処理
        switch sectionItem {
        case .review:
            print("aaaaaa")
        case .share:
            print("bbbbbb")
        case .hint:
            print("cccccc")
        case .version:
            print("dddddd")
        }
    }

    private func reloadItem(_ sectionItem: SectionItem) {
        var snapshot = dataSource.snapshot()
        snapshot.reloadItems([sectionItem])
        dataSource.apply(snapshot) // UIの変更を反映
    }

    private func reloadSection(_ section: Section) {
        var snapshot = dataSource.snapshot()
        snapshot.reloadSections([section])
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func setupHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout) // viewのサイズを画面サイズに合わせて被せる
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // 画面サイズ，向きが変わっても自動でサイズ調整
        view.addSubview(collectionView)
        collectionView.delegate = self // collectionViewでアクションが起きたときにselfに問い合わせ
    }

    private func setupDataSource() {
        let other: UICollectionView.CellRegistration<UICollectionViewListCell, SectionItem> // セルの型，モデルの型の指定
        other = .init { [weak self] cell, _, item in
            guard let self = self else { return }
            cell.automaticallyUpdatesContentConfiguration = true // セル状態が変化したときにコンテンツ構成を更新
            switch item {
            case .review, .share, .hint:
                var content = cell.defaultContentConfiguration() // デフォルトの設定を利用
                content.text = item.title
                content.textProperties.font = .systemFont(ofSize: 14)
                cell.contentConfiguration = content // 新しい設定をセット
                // ここでアクセサリを設定
                cell.accessories = [
                    .customView(
                        configuration: .init(
                            customView: UIImageView(image: .init(named: "arrow_s")),
                            placement: .trailing(displayed: .always),
                            reservedLayoutWidth: .actual
                        )
                    )
                ]
            case .version:
                var content = cell.defaultContentConfiguration()
                content.text = item.title
                content.textProperties.font = .systemFont(ofSize: 14)
                cell.contentConfiguration = content
                cell.accessories = [
                    .label(
                        text: self.presenter.versionNumber, // ここは自動更新できるようにアルゴリズムを更新
                        displayed: .always,
                        options: .init(tintColor: .pastelRed, font: .systemFont(ofSize: 13))
                    )
                ]
                cell.automaticallyUpdatesBackgroundConfiguration = false
            }
        }

        // 以下でセルを定義 cellProvider→ビューの各セルを作成して返すクロージャー
        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            default:
                return collectionView
                    .dequeueConfiguredReusableCell(using: other, for: indexPath, item: item) // セルオブジェクトを返す
            }
        })

        let header = UICollectionView.SupplementaryRegistration // セルのheaderを作成
        <UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { (cell, _, indexPath) in
            var config = UIListContentConfiguration.groupedHeader()
            config.text = Section(rawValue: indexPath.section)?.title
            config.textProperties.font = .systemFont(ofSize: 14)
            config.textProperties.color = .black
            if indexPath.section == 0 {
                config.directionalLayoutMargins = .init(top: 33, leading: 0, bottom: 8, trailing: 0)
            }
            cell.contentConfiguration = config
        }

        dataSource.supplementaryViewProvider = .init { collectionView, _, indexPath in
            switch Section(rawValue: indexPath.section)! {
            default:
                return collectionView
                    .dequeueConfiguredReusableSupplementary(using: header, for: indexPath)
            }
        }
    }

    // ここでセルの情報を追加
    private func configureDatasource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SectionItem>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([.review, .share, .hint], toSection: .aboutApp)
        snapshot.appendItems([.version], toSection: .other)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
