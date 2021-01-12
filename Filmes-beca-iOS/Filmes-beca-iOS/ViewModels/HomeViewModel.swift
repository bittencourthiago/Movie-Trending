//
//  HomeViewModel.swift
//  Filmes-beca-iOS
//
//  Created by Thiago Bittencourt Coelho on 12/01/21.
//  Copyright © 2021 Thiago Bittencourt Coelho. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModel {
    
    // MARK: - Variables
    var filmesToShow:[Filme] = []
    var carregamento = SpinerViewController()
    var filmesAPI = FilmesRequisition()
    var paginaAtual:Int = 1
    
    // MARK: - Methods
    func carregaImagens(_ viewController: UIViewController, collectionView:UICollectionView, valueToAddOnPage:Int) {
        
        if(paginaAtual + valueToAddOnPage >= 1){
        
            paginaAtual = paginaAtual + valueToAddOnPage
            
            carregamento.showSpinner(onView: viewController.view)
                
            filmesAPI.getImagens(paginaAtual) { (filme, filmesArray) in
                self.filmesToShow = filme
                if(self.filmesToShow.count == filmesArray?.count) {
                    self.filmesToShow.remove(at: 0)
                    self.carregamento.removeSpinner()
                    collectionView.reloadData()
                }
            }
        } else {
            print("Voce esta na primeira página")
        }
    }
}

