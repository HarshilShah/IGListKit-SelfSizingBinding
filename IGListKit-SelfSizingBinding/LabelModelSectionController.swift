//
//  LabelModelSectionController.swift
//  IGListKitExamples
//
//  Created by Harshil Shah on 13/05/17.
//  Copyright © 2017 Instagram. All rights reserved.
//

import IGListKit
import Foundation

final class LabelModelSectionController: ListBindingSectionController<ListDiffable>, ListBindingSectionControllerDataSource {
    
    override init() {
        super.init()
        dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .refresh, object: nil)
    }
    
    // MARK: ListBindingSectionControllerDataSource
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
        guard let object = object as? LabelSectionModel else { return [] }
        
        return object.data
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell {
        return collectionContext?.dequeueReusableCell(of: FullWidthSelfSizingCell.self, for: self, at: index) ?? UICollectionViewCell()
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else {
            return .zero
        }
        
        return CGSize(width: width, height: 55.0)
    }
    
    func refresh() {
        guard let indices = collectionContext?.visibleIndexPaths(for: self) else {
            return
        }
        
        let models = fetchNewModels().data
        
        for i in indices.map({ $0.row }) {
            let labelModel = models[i]
            if let cell = collectionContext?.cellForItem(at: i, sectionController: self) as? ListBindable {
                cell.bindViewModel(labelModel)
            }
        }
        
    }
    
    func fetchNewModels() -> LabelSectionModel {
        let text = ["Aenean lacinia bibendum nulla sed consectetur. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras mattis consectetur purus sit amet fermentum.",
                    "Donec sed odio dui. Donec id elit non mi porta gravida at eget metus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed posuere consectetur est at lobortis. Cras justo odio, dapibus ac facilisis in, egestas eget quam.",
                    "Sed posuere consectetur est at lobortis. Nullam quis risus eget urna mollis ornare vel eu leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum."]
        
        let labelModels: [LabelModel] = text.map {
            let hue = CGFloat(arc4random() % 256) / 256
            let color = UIColor(hue: hue, saturation: 0.4, brightness: 1, alpha: 1)
            
            return LabelModel(text: $0, color: color)
        }
        
        return LabelSectionModel(labelModels)
    }
    
}
