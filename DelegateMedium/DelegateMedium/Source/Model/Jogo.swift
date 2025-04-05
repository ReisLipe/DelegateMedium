//
//  Jogo.swift
//  DelegateMedium
//
//  Created by Joao Filipe Reis Justo da Silva on 05/04/25.
//

struct Jogo {
    let nome: String
    let desenvovledora: String
    let ano: String
    let dono: String
    let image: String
    
    init(nome: String, desenvovledora: String, ano: String, dono: String, image: String) {
        self.nome = nome
        self.desenvovledora = desenvovledora
        self.ano = ano
        self.dono = dono
        self.image = image
    }
    
    func descricao() -> String {
        return "Jogo: \(nome), \(desenvovledora) (\(ano)) - Dono: \(dono)"
    }
}


