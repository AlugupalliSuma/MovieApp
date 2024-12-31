//
//  CustomNavigationView.swift
//  MVVMexample
//
//  Created by Suma on 25/12/24.
//

import UIKit

protocol CustomNavigationBarDelegate: AnyObject {
    func didTapLeftButton()
}
class CustomNavigationView: UIView {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: CustomNavigationBarDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        // Load the XIB
        Bundle.main.loadNibNamed("CustomNavigationView", owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        setupLayout()
    }
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: topAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
            ]
        )
    }
    // Configure the title
    func configure(_ title: String) {
        titleLabel?.text = title
        
    }
    @IBAction func leftButtonTapped(_ sender: UIButton){
        delegate?.didTapLeftButton()
    }
}
