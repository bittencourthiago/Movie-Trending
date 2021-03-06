//
//  TestRequisition.swift
//  Filmes-beca-iOS
//
//  Created by Thiago Bittencourt Coelho on 07/01/21.
//  Copyright © 2021 Thiago Bittencourt Coelho. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import CoreData

class FilmesRequisition: NSObject {
    
    // MARK: - Variables
    
    var filmes:[Filme]? = []

    // MARK: - Methods
    
    func getFilmes(_ pagina:Int=1, completion:@escaping(_ filmes:[Filme]) -> Void ) {
        
        let myKey = "122c287761eefdfe3d8bcc0154354e73"
        
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/all/week?api_key=\(myKey)&language=pt-BR&page=\(pagina)") else { return }
        
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
                case .success:
                    if let resposta = response.result.value as? [String:Any] {
                        
                        var tituloOuNome = ""
                        var lancaOuEstreia = ""
                        var filmesBruto:[Filme] = []
                        
                        guard let filmes = resposta["results"] as? [[String:Any]] else { return }
                        
                        for filme in filmes {
                            if(filme["title"] != nil) {
                                tituloOuNome = "title"
                                
                            } else {
                                tituloOuNome = "name"
                                
                            }
                            if(filme["release_date"] != nil) {
                                
                                lancaOuEstreia = "release_date"
                                
                            } else {
                                lancaOuEstreia = "first_air_date"
                            }
                                  
                            guard let id = filme["id"] as? Int else { return }
                            guard let nomeAtual = filme[tituloOuNome] as? String else { return }
                            guard let caminhoAtual = filme["poster_path"] as? String else { return }
                            guard let sinopseAtual = filme["overview"] as? String else { return }
                            guard let dataDeLancamento = filme[lancaOuEstreia] as? String else { return }
  
                            let filmeAtual = Filme(nome: nomeAtual, id: id, caminho: caminhoAtual, sinopse: sinopseAtual, lancamento: dataDeLancamento, imagem: nil)
                                   
                            filmesBruto.append(filmeAtual)
                        }
                        completion(filmesBruto)
                    }
                    break
                case .failure:
                    print(response.error!)
                    break
            }
        }
    }
    func getImagens(_ pagina:Int=1, completion: @escaping(_ filme: [Filme], _ filmes: [Filme]?) ->Void) {
        
        getFilmes(pagina) { (filmes) in
            
            var filmesProntos:[Filme] = []
            
            for filme in filmes {
      
                guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: filme.caminho))") else { return }
                    
                var filmeAtual:Filme? = nil
                    
                Alamofire.request(url, method: .get).responseImage(completionHandler: { (response) in
                    switch response.result {
                        case .success:
                            
                            if let image = response.result.value {
                                
                                filmeAtual = Filme(nome: filme.nome, id: filme.id,caminho: filme.caminho , sinopse: filme.sinopse, lancamento: filme.lancamento, imagem: image)
                      
                                
                                guard let `filmeAtual` = filmeAtual else { return }
                                
                                filmesProntos.append( filmeAtual)
                                completion(filmesProntos, filmes)
                            }
                            
                            break
                        
                        case .failure:
                            print("Erro na requisição de imagens")
                            break
                    }
                })
            }
        }
    }
}
