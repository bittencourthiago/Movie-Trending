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
    
    let viewModel = DetalhesFilmeViewModel()
    var filmeSelecionado:Filme? = nil
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mostrar()
    }
    
    // MARK: - IBActions
    
    @IBAction func botaoVoltar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func mostrar() {
        guard let filme = filmeSelecionado else { return }
        
        viewModel.mostrarDetalhes(filme) { (filme) in
            self.tituloTextLabel.text = filme.nome
            self.imagemFilme.image = filme.imagem
            self.sinopseTextLabel.text = filme.sinopse
            self.lancamentoTextLabel.text = filme.lancamento
        }
    }
    
    
}
