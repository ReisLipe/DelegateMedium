//
//  HomeViewController.swift
//  DelegateMedium
//
//  Created by Joao Filipe Reis Justo da Silva on 05/04/25.
//

import UIKit

// MARK: - Funcionário (delegado)
/// A classe responsável por executar as tarefas descritas no delegate com base
/// nas informações passadas pelo patrão (delegante).
class HomeViewController: UIViewController, CompraJogoDelegate {
    /// Perceba que HomeViewController está de acordo com CompraJogoDelegate. Isso
    /// fica explícito quando temos `class HomeViewController: CompraJogoDelegate {}`.
    
    private var jogoImagem: UIImageView!
    private var jogoInfo: UILabel!
    private var donoInfo: UILabel!
    private var btnComprar: UIButton!
    private var jogoComprado = Jogo(nome: "Nenhum Jogo", desenvovledora: "", ano: "", dono: "Não informado", imagem: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAcoes()
    }
    
    // Ações dos componentes
    private func setupAcoes() {
        btnComprar.addTarget(self, action: #selector(abreCompraJogo), for: .touchUpInside)
    }
    
    func comprouJogo(_ jogo: Jogo) {
        /// Toda vez que o patrao chamar funcionario?.comprouJogo(), esta
        /// exata função será executada
        self.jogoComprado = jogo
        atualizaUI()
        
        print(jogoComprado.descricaoJogo())
        print(jogoComprado.descricaoDono())
        print("===========================")
    }
    
    @objc func abreCompraJogo() {
        let loja = LojaViewController()     /// Instancia LojaViewController
        loja.funcionario = self             /// Declara que o funcionário de LojaViewController
                                                    /// será está classe (HomeViewController)

        // Configuração da Tela de Compra
        loja.modalPresentationStyle = .pageSheet
        loja.sheetPresentationController?.detents = [.medium()]
        loja.sheetPresentationController?.prefersGrabberVisible = true
        present(loja, animated: true)
    }
}


// MARK: UI
extension HomeViewController {
    private func atualizaUI() {
        /// remove UI antiga
        jogoImagem.removeFromSuperview()
        jogoInfo.removeFromSuperview()
        donoInfo.removeFromSuperview()
        
        /// cria UI nova
        self.jogoImagem = generateImageView(jogoComprado.imagem)
        self.jogoInfo = generateLbl(text: jogoComprado.descricaoJogo())
        self.donoInfo = generateLbl(text: jogoComprado.descricaoDono())
        
        /// adiciona UI nova na View
        self.view.addSubview(jogoImagem)
        self.view.addSubview(jogoInfo)
        self.view.addSubview(donoInfo)
        setupConstraints()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        jogoImagem = generateImageView(jogoComprado.imagem)
        jogoInfo = generateLbl(text: jogoComprado.descricaoJogo())
        donoInfo = generateLbl(text: jogoComprado.descricaoDono())
        btnComprar = generateBtn(btnName: "Comprar")
        
        self.view.addSubview(jogoImagem)
        self.view.addSubview(jogoInfo)
        self.view.addSubview(donoInfo)
        self.view.addSubview(btnComprar)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            jogoImagem.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            jogoImagem.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            jogoImagem.widthAnchor.constraint(equalToConstant: 300),
            jogoImagem.heightAnchor.constraint(equalToConstant: 600),
        ])
        
        NSLayoutConstraint.activate([
            jogoInfo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            jogoInfo.topAnchor.constraint(equalTo: jogoImagem.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            donoInfo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            donoInfo.topAnchor.constraint(equalTo: jogoInfo.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            btnComprar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btnComprar.topAnchor.constraint(equalTo: donoInfo.bottomAnchor, constant: 20),
            btnComprar.widthAnchor.constraint(equalToConstant: 120),
            btnComprar.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func generateBtn(btnName: String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(btnName, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 10
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
    
    private func generateImageView(_ imageName: String) -> UIImageView {
        let img = UIImageView()
        img.image = UIImage(named: imageName)
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }
    
    private func generateLbl(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

#Preview {
    HomeViewController()
}
