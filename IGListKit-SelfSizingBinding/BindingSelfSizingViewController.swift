//
//  BindingSelfSizingViewController.swift
//  IGListKitExamples
//
//  Created by Harshil Shah on 13/05/17.
//  Copyright © 2017 Instagram. All rights reserved.
//

import UIKit
import IGListKit

final class BindingSelfSizingViewController: UIViewController {
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 40)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        let refreshItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItem = refreshItem
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func refresh() {
        NotificationCenter.default.post(name: .refresh, object: nil)
//        adapter.performUpdates(animated: true, completion: nil)
    }
    
}

// MARK: ListAdapterDataSource

extension BindingSelfSizingViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        let text = ["Aenean lacinia bibendum nulla sed consectetur. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras mattis consectetur purus sit amet fermentum.",
                                 "Donec sed odio dui. Donec id elit non mi porta gravida at eget metus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed posuere consectetur est at lobortis. Cras justo odio, dapibus ac facilisis in, egestas eget quam.",
                                 "Sed posuere consectetur est at lobortis. Nullam quis risus eget urna mollis ornare vel eu leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum."]
        
        let labelModels: [LabelModel] = text.map {
            let hue = CGFloat(arc4random() % 256) / 256
            let color = UIColor(hue: hue, saturation: 0.4, brightness: 1, alpha: 1)
            
            return LabelModel(text: $0, color: color)
        }
        
        return [LabelSectionModel(labelModels)]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return LabelModelSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}
