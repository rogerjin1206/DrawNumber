//
//  ViewController.swift
//  DrawNumber
//
//  Created by Euijae Hong on 2018. 8. 20..
//  Copyright © 2018년 JAEJIN. All rights reserved.
//

import UIKit
import RJExtension

class DrawViewController: UIViewController {

    let numberButton : UIButton = {
        let b = UIButton()
        b.setTitle("Write Number !", for:.normal)
        b.setTitleColor(UIColor.black, for: .normal)
        b.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        b.backgroundColor = .white
        
        return b
    }()
    
    let drawView : DrawView = {
        
        let dv = DrawView()
        dv.backgroundColor = .black
        
        return dv
        
    }()
    
    let eraseButton : UIButton = {
        let b = UIButton()
        b.setTitle("ERASE", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = UIColor.lightGray
        b.addTarget(self, action: #selector(tappedEraseButton(_:)), for: .touchUpInside)
        
        
        return b
        
    }()
    
    let redButton : UIButton = {
        
        let b = UIButton()
        b.backgroundColor = .red
        b.setTitle("RED", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(tappedColorButton(_:)), for: .touchUpInside)
        
        return b
        
    }()
    
    let blueButton : UIButton = {
        
        let b = UIButton()
        b.backgroundColor = .blue
        b.setTitle("BLUE", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(tappedColorButton(_:)), for: .touchUpInside)
        
        return b
        
    }()
    
    let greenButton : UIButton = {
        
        let b = UIButton()
        b.backgroundColor = .green
        b.setTitle("GREEN", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(tappedColorButton(_:)), for: .touchUpInside)
        
        return b
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupViews()
        drawView.delegate = self
        
    }

}

//MARK- SetupViews
extension DrawViewController {
    
    private func setupViews() {
        
        [
            
            drawView,
            numberButton,
            eraseButton,
            redButton,
            blueButton,
            greenButton
            
        ].forEach({view.addSubview($0)})
        
        drawView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: numberButton.topAnchor, trailing: view.trailingAnchor)
        
        numberButton.anchor(top: nil, leading: view.leadingAnchor, bottom: eraseButton.topAnchor, trailing: view.trailingAnchor, size:.init(width: 0, height: 50))
        eraseButton.anchor(top: nil, leading: view.leadingAnchor, bottom: redButton.topAnchor, trailing: view.trailingAnchor,size:.init(width: 0, height: 50))
        redButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,trailing: nil, size:.init(width:view.frame.width/3, height: 50))
        blueButton.anchor(top: nil, leading: redButton.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,trailing: nil, size:.init(width:view.frame.width/3, height: 50))
        greenButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor,trailing: view.trailingAnchor, size:.init(width:view.frame.width/3, height: 50))
        
    }
    
}




//MARK: Action
extension DrawViewController {
    
    // erase view
    @objc private func tappedEraseButton(_ sender:UIButton) {
        
        self.numberButton.setTitle(self.drawView.resultNumber, for: .normal)
        drawView.erase()
                
    }
    
    
    // change Line Color
    @objc private func tappedColorButton(_ sender:UIButton) {
        
        var lineColor = UIColor.red.cgColor
        
        switch sender.self {
        case redButton:
            lineColor = UIColor.red.cgColor
        case blueButton:
            lineColor = UIColor.blue.cgColor
        case greenButton:
            lineColor = UIColor.green.cgColor
        default:()
            
        }
        
        drawView.lineColor = lineColor
        
    }
    
}

//MARK:- DrawViewDelegate
extension DrawViewController : DrawViewDelegate {
    
    func resultString(_ result: String) {
        self.numberButton.setTitle(result, for: .normal)
    }
    
}





