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
    
    let homeViewModel = HomeViewModel()
    let celulaViewModel = FilmeCollectionCellViewModel()
    
    var filmes:[Filme] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmesCollectionView.dataSource = self
        filmesCollectionView.delegate = self
        self.setNeedsStatusBarAppearanceUpdate()
        
        bind()
        carregaFilmes(pagina: 0)

    }
    
    func bind() {
        homeViewModel.homeViewData.bind { (homeViewData) in
            
            guard let `homeViewData` = homeViewData else { return }
            
            self.filmes = homeViewData.filmes
            self.filmesCollectionView.reloadData()
            
        }
    }
    
    // MARK: - StatusBar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - IBActions

    @IBAction func carregaPaginaAnterior(_ sender: UIButton) {
        carregaFilmes(pagina: -1)
    }
   
    @IBAction func botaoProximaPagina(_ sender: UIButton) {
        carregaFilmes(pagina: +1)
    }
    
    // MARK: - Methods
    
    func carregaFilmes(pagina:Int) {
        homeViewModel.carregaImagens(self, valueToAddOnPage: pagina)
    }
}

// MARK: - CollectionView data source

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.filmesToShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return celulaViewModel.loadFilmes(indexPath, filmes: filmes,collection: collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filme = homeViewModel.filmesToShow[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detalhes") as! DetalhesFilmeViewController
   
        controller.filmeSelecionado = filme

        self.present(controller, animated: true, completion: nil)
        
    }
}
