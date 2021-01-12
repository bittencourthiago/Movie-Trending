//
//  DetalhesFilmeViewController.swift
//  Filmes-beca-iOS
//
//  Created by Thiago Bittencourt Coelho on 08/01/21.
//  Copyright © 2021 Thiago Bittencourt Coelho. All rights reserved.
//

import UIKit

class DetalhesFilmeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tituloTextLabel: UILabel!
    @IBOutlet weak var imagemFilme: UIImageView!
    @IBOutlet weak var sinopseTextLabel: UILabel!
    @IBOutlet weak var lancamentoTextLabel: UILabel!
    
    // MARK: - Variables
    
    let filmesAPI = FilmesRequisition()
    
    var filmeSelecionado:Filme?
    
    var paginaAtual:Int = 1
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showFilme()
    }
    
    // MARK: - IBActions
    
    @IBAction func botaoVoltar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func showFilme() {
        
        guard let filme = filmeSelecionado else { return }
        
        imagemFilme.image = filme.imagem
        
        tituloTextLabel.text = filme.nome
        sinopseTextLabel.text = filme.sinopse
        
        let lancamentoArr:[String] = filme.lancamento.components(separatedBy: "-")
        
        let lancamentoLapidado = "\(lancamentoArr[2])/\(lancamentoArr[1])/\(lancamentoArr[0])"
        
        lancamentoTextLabel.text = lancamentoLapidado
    }
}
