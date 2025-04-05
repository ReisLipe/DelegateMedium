//
//  MeusJogos.swift
//  DelegateMedium
//
//  Created by Joao Filipe Reis Justo da Silva on 05/04/25.
//

import UIKit

// MARK: - Funcionário: espera pelas ordens do patrão.
class MeusJogosViewController: UIViewController, CompraJogoDelegate {

    
    private var jogoImagem: UIImageView!
    private var jogoInfo: UILabel!
    private var btnComprar: UIButton!
    private var jogoComprado = Jogo(nome: "Nenhum Jogo", desenvovledora: "", ano: "", dono: "", image: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAcoes()
    }
    
    private func setupAcoes() {
        btnComprar.addTarget(self, action: #selector(abreCompraJogo), for: .touchUpInside)
    }
    
    func comprouJogo(_ jogo: Jogo) {
        /// Toda vez que fizermos delegate?.comprouJogo() na view Patrão
        /// Essa função daqui será chamada na view Funcionário
        /// Isso acontece pois a view Funcionário se conforma ao delegate (CompraJogoDelegate)
        /// E em `abreCompraJogo` se declara funcionária de `CompraJogoViewController`
        self.jogoComprado = jogo
        resetUI()
        
        print(jogoComprado.descricao())
    }
    
    @objc func abreCompraJogo() {
        /// Aqui declaramos que o funcionário (delegado) da tela de compras será
        /// nossa tela MeusJogosViewController
        let telaDeCompra = CompraJogoViewController()
        telaDeCompra.delegate = self

        // Configuração da Tela de Compra
        telaDeCompra.modalPresentationStyle = .pageSheet
        telaDeCompra.sheetPresentationController?.detents = [.medium()]
        telaDeCompra.sheetPresentationController?.prefersGrabberVisible = true
        present(telaDeCompra, animated: true)
    }
}


// MARK: UI
extension MeusJogosViewController {
    private func resetUI() {
        /// remove UI antiga
        jogoImagem.removeFromSuperview()
        jogoInfo.removeFromSuperview()
        
        /// cria UI nova
        self.jogoImagem = generateImageView(jogoComprado.image)
        self.jogoInfo = generateLbl(text: jogoComprado.descricao())
        
        /// adiciona UI nova na View
        self.view.addSubview(jogoImagem)
        self.view.addSubview(jogoInfo)
        setupConstraints()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        jogoImagem = generateImageView(jogoComprado.image)
        jogoInfo = generateLbl(text: jogoComprado.descricao())
        btnComprar = generateBtn(btnName: "Comprar")
        
        self.view.addSubview(jogoImagem)
        self.view.addSubview(jogoInfo)
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
            btnComprar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btnComprar.topAnchor.constraint(equalTo: jogoInfo.bottomAnchor, constant: 20),
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
    MeusJogosViewController()
}
