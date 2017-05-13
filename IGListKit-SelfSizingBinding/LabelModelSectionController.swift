//
//  LabelModelSectionController.swift
//  IGListKitExamples
//
//  Created by Harshil Shah on 13/05/17.
//  Copyright © 2017 Instagram. All rights reserved.
//

import IGListKit

final class LabelModelSectionController: ListBindingSectionController<ListDiffable>, ListBindingSectionControllerDataSource {
    
    override init() {
        super.init()
        dataSource = self
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
    
}
