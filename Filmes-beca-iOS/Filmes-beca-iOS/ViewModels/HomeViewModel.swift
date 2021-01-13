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
    var homeViewData: Bindable<HomeViewData?> = Bindable(nil)
    
    // MARK: - Methods
    
    func carregaImagens(_ viewController: UIViewController, valueToAddOnPage:Int) {
        
        if(paginaAtual + valueToAddOnPage >= 1){
        
            paginaAtual = paginaAtual + valueToAddOnPage
            carregamento.showSpinner(onView: viewController.view)
                
            filmesAPI.getImagens(paginaAtual) { (filmes, filmesArray) in
                self.filmesToShow = filmes
                
                if(self.filmesToShow.count == filmesArray?.count) {
                    self.filmesToShow.remove(at: 0)
                    
                    self.homeViewData.value = HomeViewData(model: self.filmesToShow)
                    
                    self.carregamento.removeSpinner()
                }
            }
        } else {
            print("Voce esta na primeira página")
        }
    }
}

