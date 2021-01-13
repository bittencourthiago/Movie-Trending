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
    
    var viewData: DetalhesFilmeViewData? = nil
    
    // MARK: - Methods
    func getSelecionado(_ filme: Filme?, completion:@escaping(_ filme: DetalhesFilmeViewData)->Void) {
        
        guard let movie = filme else { return }
        let filme = DetalhesFilmeViewData(model: movie)
  
        completion(filme)
        
    }
    
    func lapidaLancamento(_ lancamento:String) -> String {
        
        let lancamentoArr:[String] = lancamento.components(separatedBy: "-")
        let lancamentoLapidado = "\(lancamentoArr[2])/\(lancamentoArr[1])/\(lancamentoArr[0])"
        
        return lancamentoLapidado
        
    }
}
