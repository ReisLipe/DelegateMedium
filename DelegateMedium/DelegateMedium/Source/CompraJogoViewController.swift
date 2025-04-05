//
//  CompraJogoViewController.swift
//  DelegateMedium
//
//  Created by Joao Filipe Reis Justo da Silva on 05/04/25.
//

import UIKit

//MARK: - Delegate:
protocol CompraJogoDelegate: AnyObject {
    func comprouJogo(_ jogo: Jogo) -> Void
}


// MARK: - Patrão: ordena que o funcionário faça algo.
class CompraJogoViewController: UIViewController {
    // Delegate
    weak var delegate: CompraJogoDelegate?
    
    // Campo de assinatura do nome do comprador.
    private var lblNomeComprador: UILabel!
    private var tfNomeComprador: UITextField!
    private var btnConfirmar: UIButton!
    private var nomeDoComprador: String = ""
    
    /// Botões de escolha do jogo.
    private var btnBF: UIButton!
    private var btnCOD: UIButton!
    private var btnMOH: UIButton!
    
    
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
        btnBF.addTarget(self, action: #selector(apertouBotãoComprarBattlefield), for: .touchUpInside)
        btnCOD.addTarget(self, action: #selector(apertouBotãoComprarCallOfDuty), for: .touchUpInside)
        btnMOH.addTarget(self, action: #selector(apertouBotãoComprarMedalOfHonor), for: .touchUpInside)
    }
    
    @objc private func confirmouNome() {
        // Esconde os objetos anteriores
        lblNomeComprador.isHidden = true
        tfNomeComprador.isHidden = true
        btnConfirmar.isHidden = true
        
        // Mostra os novos objetos
        btnBF.isHidden = false
        btnCOD.isHidden = false
        btnMOH.isHidden = false
    }
    
    @objc private func onNameEditingChanged(_ sender: UITextField) {
        self.nomeDoComprador = sender.text ?? ""
    }
    
    @objc private func apertouBotãoComprarBattlefield() {
        let bf = Jogo(
            nome: "Battlefield 2",
            desenvovledora: "DICE",
            ano: "2005",
            dono: nomeDoComprador,
            image: "BF"
        )
        delegate?.comprouJogo(bf)
        dismiss(animated: true)
    }
    @objc private func apertouBotãoComprarCallOfDuty() {
        let cod = Jogo(
            nome: "Call Of Duty 2",
            desenvovledora: "Infinity Ward",
            ano: "2005",
            dono: nomeDoComprador,
            image: "COD"
        )
        delegate?.comprouJogo(cod)
        dismiss(animated: true)
    }
    @objc private func apertouBotãoComprarMedalOfHonor() {
        let bf = Jogo(
            nome: "Medal Of Honor: Allied Assault",
            desenvovledora: "2015",
            ano: "2002",
            dono: nomeDoComprador,
            image: "MOH"
        )
        delegate?.comprouJogo(bf)
        dismiss(animated: true)
    }
}

// MARK: UI
extension CompraJogoViewController {
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.lblNomeComprador = generateLabel(text: "Assine seu nome:")
        self.tfNomeComprador = generateTf(placeholder: "Seu nome")
        self.btnConfirmar = generateBtn(btnName: "Confirmar")
        
        self.btnBF = generateBtn(btnName: "Battlefield 2")
        self.btnCOD = generateBtn(btnName: "Call Of Duty 2")
        self.btnMOH = generateBtn(btnName: "Medal Of Honor: Allied Assault")
        
        self.view.addSubview(lblNomeComprador)
        self.view.addSubview(tfNomeComprador)
        self.view.addSubview(btnConfirmar)
        self.view.addSubview(btnBF)
        self.view.addSubview(btnCOD)
        self.view.addSubview(btnMOH)
        
        btnBF.isHidden = true
        btnCOD.isHidden = true
        btnMOH.isHidden = true
        
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
            btnBF.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btnBF.bottomAnchor.constraint(equalTo: btnCOD.topAnchor, constant: -16),
            btnBF.widthAnchor.constraint(equalToConstant: btnJogoWidth),
            btnBF.heightAnchor.constraint(equalToConstant: btnJogoHeight),
        ])
        
        NSLayoutConstraint.activate([
            btnCOD.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btnCOD.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            btnCOD.widthAnchor.constraint(equalToConstant: btnJogoWidth),
            btnCOD.heightAnchor.constraint(equalToConstant: btnJogoHeight),
        ])
        
        NSLayoutConstraint.activate([
            btnMOH.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btnMOH.topAnchor.constraint(equalTo: btnCOD.bottomAnchor, constant: 16),
            btnMOH.widthAnchor.constraint(equalToConstant: btnJogoWidth),
            btnMOH.heightAnchor.constraint(equalToConstant: btnJogoHeight),
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
    CompraJogoViewController()
}

