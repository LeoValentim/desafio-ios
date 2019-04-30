//
//  LoadingView.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import Foundation
import JGProgressHUD

class LoadingView {
    
    let hud: JGProgressHUD
    
    static let shared: LoadingView = LoadingView()
    
    init() {
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Carregando"
    }
    
}
