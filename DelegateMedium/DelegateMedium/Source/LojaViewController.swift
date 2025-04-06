//
//  CompraJogoViewController.swift
//  DelegateMedium
//
//  Created by Joao Filipe Reis Justo da Silva on 05/04/25.
//

import UIKit

//MARK: - Delegate:
/// A lesgislação que diz o que deve ser feito pelo funcionário e pelo
/// patrão.
protocol CompraJogoDelegate: AnyObject {
    func comprouJogo(_ jogo: Jogo) -> Void
}


// MARK: - Patrão (delegante)
/// A classe resposável por delegar tarefas. Ela passará informaçãoes
/// para o funcionário (delegado), para que esse seja capaz de realizar
/// seu trabalho.
class LojaViewController: UIViewController {

    // Anúncio de vaga de trabalho (delegate ou delegado)
    weak var funcionario: CompraJogoDelegate?
    
    // Campo de assinatura do nome do comprador.
    private var lblNomeComprador: UILabel!
    private var tfNomeComprador: UITextField!
    private var btnConfirmar: UIButton!
    private var nomeDoComprador: String = ""
    
    /// Botões de escolha do jogo.
    private var btnCompraBF: UIButton!
    private var btnCompraCOD: UIButton!
    private var btnCompraMOH: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAcoes()
    }
    
    // Ações dos componentes
    private func setupAcoes() {
        // Ações dos componentes do nome do comprador
        tfNomeComprador.addTarget(self, action: #selector(onNameEditingChanged), for: .editingChanged)
        btnConfirmar.addTarget(self, action: #selector(confirmouNome), for: .touchUpInside)
        
        // Ações dos componentes de compra de jogos
        btnCompraBF.addTarget(self, action: #selector(apertouBotãoComprarBattlefield), for: .touchUpInside)
        btnCompraCOD.addTarget(self, action: #selector(apertouBotãoComprarCallOfDuty), for: .touchUpInside)
        btnCompraMOH.addTarget(self, action: #selector(apertouBotãoComprarMedalOfHonor), for: .touchUpInside)
    }
    
    @objc private func confirmouNome() {
        // Esconde os objetos anteriores
        lblNomeComprador.isHidden = true
        tfNomeComprador.isHidden = true
        btnConfirmar.isHidden = true
        
        // Mostra os novos objetos
        btnCompraBF.isHidden = false
        btnCompraCOD.isHidden = false
        btnCompraMOH.isHidden = false
    }
    
    @objc private func onNameEditingChanged(_ sender: UITextField) {
        self.nomeDoComprador = sender.text ?? ""
    }
    
    
    /// Essas funções abaixo são chamadas quando os seus respectivos
    /// botões são apertados. Elas são responsáveis por chamar o
    /// método do funcionario (`funcionario?.comprouJogo`), quando esse
    /// método é chamado, ele informa a view que implementa o
    /// `ComprouJogoDelegate`.
    @objc private func apertouBotãoComprarBattlefield() {
        let bf = geraBF()               /// Gera o jogo
        funcionario?.comprouJogo(bf)    /// Envia o jogo para o funcionário
        dismiss(animated: true)         /// Fecha a tela
    }
    @objc private func apertouBotãoComprarCallOfDuty() {
        let cod = geraCOD()             /// Gera o jogo
        funcionario?.comprouJogo(cod)   /// Envia o jogo para o funcionário
        dismiss(animated: true)         /// Fecha a tela
    }
    @objc private func apertouBotãoComprarMedalOfHonor() {
        let bf = geraMOH()              /// Gera o jogo
        funcionario?.comprouJogo(bf)    /// Envia o jogo para o funcionário
        dismiss(animated: true)         /// Fecha a tela
    }
}


// MARK: Gerador de Jogos
extension LojaViewController {
    private func geraBF() -> Jogo {
        return Jogo(nome: "Battlefield 2", desenvovledora: "DICE", ano: "2005", dono: nomeDoComprador, imagem: "BF")
    }
    private func geraCOD() -> Jogo {
        return Jogo(nome: "Call Of Duty 2", desenvovledora: "Infinity Ward", ano: "2005", dono: nomeDoComprador, imagem: "COD")
    }
    private func geraMOH() -> Jogo {
        return Jogo(nome: "Medal Of Honor: Allied Assault", desenvovledora: "2015", ano: "2002", dono: nomeDoComprador, imagem: "MOH")
    }
}


// MARK: UI
extension LojaViewController {
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.lblNomeComprador = generateLabel(text: "Assine seu nome:")
        self.tfNomeComprador = generateTf(placeholder: "Seu nome")
        self.btnConfirmar = generateBtn(btnName: "Confirmar")
        
        self.btnCompraBF = generateBtn(btnName: "Battlefield 2")
        self.btnCompraCOD = generateBtn(btnName: "Call Of Duty 2")
        self.btnCompraMOH = generateBtn(btnName: "Medal Of Honor: Allied Assault")
        
        self.view.addSubview(lblNomeComprador)
        self.view.addSubview(tfNomeComprador)
        self.view.addSubview(btnConfirmar)
        self.view.addSubview(btnCompraBF)
        self.view.addSubview(btnCompraCOD)
        self.view.addSubview(btnCompraMOH)
        
        btnCompraBF.isHidden = true
        btnCompraCOD.isHidden = true
        btnCompraMOH.isHidden = true
        
        NSLayoutConstraint.activate([
            lblNomeComprador.leadingAnchor.constraint(equalTo: tfNomeComprador.leadingAnchor),
            lblNomeComprador.bottomAnchor.constraint(equalTo: tfNomeComprador.topAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            tfNomeComprador.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tfNomeComprador.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            tfNomeComprador.widthAnchor.constraint(equalToConstant: 250),
        ])
        
        NSLayoutConstraint.activate([
            btnConfirmar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btnConfirmar.topAnchor.constraint(equalTo: tfNomeComprador.bottomAnchor, constant: 45),
            btnConfirmar.widthAnchor.constraint(equalToConstant: 120),
            btnConfirmar.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        // Tamanho dos botões dos jogos:
        let btnJogoWidth: CGFloat = 300
        let btnJogoHeight: CGFloat = 45
        NSLayoutConstraint.activate([
            btnCompraBF.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btnCompraBF.bottomAnchor.constraint(equalTo: btnCompraCOD.topAnchor, constant: -16),
            btnCompraBF.widthAnchor.constraint(equalToConstant: btnJogoWidth),
            btnCompraBF.heightAnchor.constraint(equalToConstant: btnJogoHeight),
        ])
        
        NSLayoutConstraint.activate([
            btnCompraCOD.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btnCompraCOD.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            btnCompraCOD.widthAnchor.constraint(equalToConstant: btnJogoWidth),
            btnCompraCOD.heightAnchor.constraint(equalToConstant: btnJogoHeight),
        ])
        
        NSLayoutConstraint.activate([
            btnCompraMOH.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btnCompraMOH.topAnchor.constraint(equalTo: btnCompraCOD.bottomAnchor, constant: 16),
            btnCompraMOH.widthAnchor.constraint(equalToConstant: btnJogoWidth),
            btnCompraMOH.heightAnchor.constraint(equalToConstant: btnJogoHeight),
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
    
    private func generateLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func generateTf(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }
}

#Preview {
    LojaViewController()
}

