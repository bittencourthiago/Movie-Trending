//
//  DetalhesFilmeViewModel.swift
//  Filmes-beca-iOS
//
//  Created by Thiago Bittencourt Coelho on 12/01/21.
//  Copyright © 2021 Thiago Bittencourt Coelho. All rights reserved.
//

import Foundation
import UIKit

class DetalhesFilmeViewModel {
    
    func mostrarDetalhes( _ filme:Filme? ,completion:@escaping(_ filme:Filme) -> Void) {
        
        guard var `filme` = filme else { return }
        
        filme.lancamento = lapidaLancamento(filme.lancamento)
        completion(filme)
        
    }
    func lapidaLancamento(_ lancamento:String) -> String {
        
        let lancamentoArr:[String] = lancamento.components(separatedBy: "-")
        
        let lancamentoLapidado = "\(lancamentoArr[2])/\(lancamentoArr[1])/\(lancamentoArr[0])"
        
        return lancamentoLapidado
        
    }
    
}
