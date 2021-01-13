//
//  DetalhesFilmeViewModel.swift
//  Filmes-beca-iOS
//
//  Created by Thiago Bittencourt Coelho on 12/01/21.
//  Copyright © 2021 Thiago Bittencourt Coelho. All rights reserved.
//

import Foundation
import UIKit

protocol DetalhesFilmeViewModelDelegate {
    func reloadData()
}

class DetalhesFilmeViewModel {
    
    // MARK: - Variables
    
    var viewData: DetalhesFilmeViewData
    var filmeSelecionado:Filme? = nil
    
    init(_ filme:Filme) {
        self.viewData = DetalhesFilmeViewData(model: filme)
    }
    
    // MARK: - Methods
    func reloadData(_ filme: Filme) {
        
    }
    
    func lapidaLancamento(_ lancamento:String) -> String {
        
        let lancamentoArr:[String] = lancamento.components(separatedBy: "-")
        let lancamentoLapidado = "\(lancamentoArr[2])/\(lancamentoArr[1])/\(lancamentoArr[0])"
        
        return lancamentoLapidado
        
    }
}
