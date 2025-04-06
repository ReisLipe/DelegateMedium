//
//  Jogo.swift
//  DelegateMedium
//
//  Created by Joao Filipe Reis Justo da Silva on 05/04/25.
//

struct Jogo {
    private let nome: String
    private let desenvovledora: String
    private let ano: String
    private let dono: String
    let imagem: String
    
    init(nome: String, desenvovledora: String, ano: String, dono: String, imagem: String) {
        self.nome = nome
        self.desenvovledora = desenvovledora
        self.ano = ano
        self.dono = dono
        self.imagem = imagem
    }
    
    func descricaoJogo() -> String {
        return "Jogo: \(nome), \(desenvovledora) (\(ano))"
    }
    
    func descricaoDono() -> String {
        return "Dono: \(dono)"
    }
}


