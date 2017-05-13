//
//  LabelModel.swift
//  IGListKitExamples
//
//  Created by Harshil Shah on 13/05/17.
//  Copyright © 2017 Instagram. All rights reserved.
//

import IGListKit

final class LabelModel: NSObject {
    
    let text: String
    let color: UIColor
    
    init(text: String, color: UIColor) {
        self.text = text
        self.color = color
    }
    
}

extension LabelModel: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
    
}

final class LabelSectionModel: NSObject {
    
    let data: [LabelModel]
    
    init(_ data: [LabelModel]) {
        self.data = data
    }
    
}

extension LabelSectionModel: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return object is LabelSectionModel
    }
    
}
