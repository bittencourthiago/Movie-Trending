//
//  HomeTableViewController.swift
//  Filmes-beca-iOS
//
//  Created by Thiago Bittencourt Coelho on 07/01/21.
//  Copyright © 2021 Thiago Bittencourt Coelho. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var filmesCollectionView: UICollectionView!
    
    // MARK: - Variables
    
    let viewModel = HomeViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmesCollectionView.dataSource = self
        filmesCollectionView.delegate = self
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        carregaFilmes()
    }
    
    // MARK: - StatusBar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - IBActions

    @IBAction func carregaPaginaAnterior(_ sender: UIButton) {
            
        viewModel.carregaImagens(self, collectionView: filmesCollectionView, valueToAddOnPage: -1)
    }
   
    @IBAction func botaoProximaPagina(_ sender: UIButton) {
        
        viewModel.carregaImagens(self, collectionView: filmesCollectionView, valueToAddOnPage: +1)
        
    }
    
    // MARK: - Methods
    
    func carregaFilmes() {
        
        viewModel.carregaImagens(self, collectionView: filmesCollectionView, valueToAddOnPage: 0)
        
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    // MARK: - CollectionView data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filmesToShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaFilme = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaFilme", for: indexPath) as! FilmeCollectionViewCell
    
        let filmeAtual = viewModel.filmesToShow[indexPath.item]
        
        guard let imagem = filmeAtual.imagem else { return celulaFilme }
        
        celulaFilme.imagemFilme.image = imagem
        
        celulaFilme.tituloFilme.text = filmeAtual.nome
        
        return celulaFilme
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filme = viewModel.filmesToShow[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detalhes") as! DetalhesFilmeViewController
        
        controller.filmeSelecionado = filme
        controller.paginaAtual = viewModel.paginaAtual
        
        self.present(controller, animated: true, completion: nil)
        
    }
}
