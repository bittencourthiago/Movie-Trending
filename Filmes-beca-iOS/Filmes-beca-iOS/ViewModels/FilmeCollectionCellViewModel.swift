//
//  FilmeCollectionViewModel.swift
//  Filmes-beca-iOS
//
//  Created by Thiago Bittencourt Coelho on 13/01/21.
//  Copyright © 2021 Thiago Bittencourt Coelho. All rights reserved.
//

import Foundation
import UIKit

class FilmeCollectionCellViewModel {
    
    var homeViewModel = HomeViewModel()
    
    
    func loadFilmes(_ index: IndexPath, filmes:[Filme] , collection: UICollectionView) -> UICollectionViewCell {
        
        let celulaFilme = collection.dequeueReusableCell(withReuseIdentifier: "celulaFilme", for: index) as! FilmeCollectionViewCell
    
        let filmeAtual = filmes[index.item]
        
        guard let imagem = filmeAtual.imagem else { return celulaFilme }
        
        celulaFilme.imagemFilme.image = imagem
        celulaFilme.tituloFilme.text = filmeAtual.nome
        
        
        return celulaFilme
    }
}
