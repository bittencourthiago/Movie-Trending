//
//  HomeTableViewController.swift
//  Filmes-beca-iOS
//
//  Created by Thiago Bittencourt Coelho on 07/01/21.
//  Copyright © 2021 Thiago Bittencourt Coelho. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var filmesCollectionView: UICollectionView!
    
    // MARK: - Variables
    
    let filmesAPI = FilmesRequisition()
    var filmesToShow:[Filme] = []
    var paginaAtual:Int = 1
    var carregamento = SpinerViewController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmesCollectionView.dataSource = self
        filmesCollectionView.delegate = self
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        recuperaImages()
    }
    
    // MARK: - StatusBar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - CollectionView data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmesToShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaFilme = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaFilme", for: indexPath) as! FilmeCollectionViewCell
    
        let filmeAtual = filmesToShow[indexPath.item]
        
        guard let imagem = filmeAtual.imagem else { return celulaFilme }
        
        celulaFilme.imagemFilme.image = imagem   
        
        celulaFilme.tituloFilme.text = filmeAtual.nome
        
        return celulaFilme
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filme = filmesToShow[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detalhes") as! DetalhesFilmeViewController
        
        controller.filmeSelecionado = filme
        controller.paginaAtual = paginaAtual
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    // MARK: - IBActions

    @IBAction func carregaPaginaAnterior(_ sender: UIButton) {
        if(paginaAtual != 1) {
            paginaAtual = paginaAtual - 1
            
            recuperaImages()
        } else {
            print("Voce esta na primeira página")
        }
    }
   
    @IBAction func botaoProximaPagina(_ sender: UIButton) {
        carregamento.showSpinner(onView: self.view)
        paginaAtual = paginaAtual + 1
        
        filmesAPI.getImagens(paginaAtual) { (filme, filmesArray ) in
            
            self.filmesToShow = filme
            if(self.filmesToShow.count == filmesArray?.count ) {
                self.filmesToShow.remove(at: 0)
                self.filmesCollectionView.reloadData()
                self.carregamento.removeSpinner()
            }
        }
    }
    
    // MARK: - Methods
    
    func recuperaImages() {
        
        //animação de carregamento enquanto espera a requisição
        carregamento.showSpinner(onView: self.view)
        
        filmesAPI.getImagens(paginaAtual) { (filme, filmesArray) in
            self.filmesToShow = filme
            if(self.filmesToShow.count == filmesArray?.count) {
                self.filmesToShow.remove(at: 0)
                self.carregamento.removeSpinner()
                self.filmesCollectionView.reloadData()
            }
        }
    }
}