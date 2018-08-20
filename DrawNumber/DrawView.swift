//
//  DrawView.swift
//  DrawNumber
//
//  Created by Euijae Hong on 2018. 8. 20..
//  Copyright © 2018년 JAEJIN. All rights reserved.
//

import Foundation
import UIKit


protocol DrawViewDelegate : class {
    
    func resultString(_ result:String)
}



class DrawView : UIView {
    
    weak var delegate : DrawViewDelegate?
    
    var isDrawing = false
    var lastPoint : CGPoint!
    var lineColor : CGColor = UIColor.white.cgColor
    var lines = [Line]()
    var image : UIImage!
    var resultNumber : String?
    
    
    // 터치가 시작했을때
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isDrawing else { return }
        isDrawing = true
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self)
        lastPoint = currentPoint
        
    }
    
    // 터치이이이이이이잉
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self)
        let line = Line(startPoint: lastPoint, endPoint: currentPoint, color: lineColor)
        lastPoint = currentPoint
        lines.append(line)
        setNeedsDisplay()
        
    }
    
    // 터치가 끝났을때
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        isDrawing = false
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self)
        let line = Line(startPoint: lastPoint, endPoint: currentPoint, color: lineColor)
        self.lines.append(line)
        lastPoint = nil
        setNeedsDisplay()
        
        self.image = self.asImage()
        guard let newImage = image?.resizeImage().pixelBuffer() else { return }
        guard let result = try? MNIST().prediction(image: newImage) else { return }
        let strNumber = result.classLabel.description
        
        self.delegate?.resultString(strNumber)
    
    }
    
    // 그림그리자 ~
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(10)
        context?.setLineCap(.round)
        lines.forEach({
            
            context?.beginPath()
            context?.move(to: $0.startPoint)
            context?.addLine(to: $0.endPoint)
            context?.setStrokeColor($0.color)
            context?.strokePath()
            
        })
    
    }
    
    
    // 지우자 ~
    public func erase() {
        
        self.lines = []
        setNeedsDisplay()
        
    }
    

    
}




