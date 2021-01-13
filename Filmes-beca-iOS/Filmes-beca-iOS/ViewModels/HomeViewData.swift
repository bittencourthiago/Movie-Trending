//
//  MainViewData.swift
//  Filmes-beca-iOS
//
//  Created by Thiago Bittencourt Coelho on 12/01/21.
//  Copyright © 2021 Thiago Bittencourt Coelho. All rights reserved.
//

import Foundation

protocol HomeViewDataType {
    var filmes: [Filme] { get }
}
class HomeViewData {
    
    private let model:[Filme]
    
    init(model:[Filme]) {
        self.model = model
    }
}
extension HomeViewData: HomeViewDataType {
    var filmes: [Filme] {
        return model
    }
}
