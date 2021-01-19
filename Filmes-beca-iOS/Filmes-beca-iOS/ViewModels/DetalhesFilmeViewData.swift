//
//  DetalhesFilmeViewData.swift
//  Filmes-beca-iOS
//
//  Created by Thiago Bittencourt Coelho on 13/01/21.
//  Copyright © 2021 Thiago Bittencourt Coelho. All rights reserved.
//

import Foundation
import UIKit

protocol DetalhesFilmeViewDataType {
    var nome: String { get }
    var id: Int { get }
    var imagem: UIImage? { get }
    var sinopse: String { get }
    var lancamento: String { get }
    var caminho: String { get }
}
class DetalhesFilmeViewData {
    
    private let model:Filme
    
    init(model:Filme) {
        
        self.model = model
        
        
    }
    func lapidaLancamento(_ lancamento:String) -> String {
        
        let lancamentoArr:[String] = lancamento.components(separatedBy: "-")
        let lancamentoLapidado = "\(lancamentoArr[2])/\(lancamentoArr[1])/\(lancamentoArr[0])"
        
        return lancamentoLapidado
        
    }
}
extension DetalhesFilmeViewData: DetalhesFilmeViewDataType {
    var caminho: String {
        return model.caminho
    }
    
    var nome: String {
        return model.nome
    }
    
    var id: Int {
        return model.id
    }
    
    var imagem: UIImage? {
        guard let imagem = model.imagem else { return nil }
        return imagem
    }
    
    var sinopse: String {
        return model.sinopse
    }
    
    var lancamento: String {
        return lapidaLancamento(model.lancamento)
    }
    
    
}
