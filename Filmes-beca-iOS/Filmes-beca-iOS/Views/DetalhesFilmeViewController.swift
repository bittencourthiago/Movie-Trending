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
    
    var detalhesViewModel:DetalhesFilmeViewModel?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    // MARK: - IBActions
    
    @IBAction func botaoVoltar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func configurarAcessibilidade() {

        tituloTextLabel.accessibilityTraits = .header
        imagemFilme.accessibilityTraits = .image
        sinopseTextLabel.accessibilityTraits = .staticText
        lancamentoTextLabel.accessibilityTraits = .staticText

    }
    
}

extension DetalhesFilmeViewController: DetalhesFilmeViewModelDelegate {
    func reloadData() {

        guard let filme = detalhesViewModel?.devolveDadosDoFilme() else { return }
       
        tituloTextLabel.text = filme.nome
        imagemFilme.image = filme.imagem
        sinopseTextLabel.text = filme.sinopse
        lancamentoTextLabel.text = filme.lancamento
    
    }
}
