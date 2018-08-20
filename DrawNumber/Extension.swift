//
//  Extension.swift
//  DrawNumber
//
//  Created by Euijae Hong on 2018. 8. 20..
//  Copyright © 2018년 JAEJIN. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // 랜더링 뷰 -> 이미지
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension UIImage {
    
    // 모델에서 요구하는 이미지 사이즈로 변환 시켜야함 28x28
    func resizeImage() -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 28, height: 28)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 28, height: 28), false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    
    }
    
    
    
    func pixelBuffer() -> CVPixelBuffer? {
        var pixelBuffer: CVPixelBuffer? = nil
        
        let width = Int(self.size.width)
        let height = Int(self.size.height)
        
        CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_OneComponent8, nil, &pixelBuffer)
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue:0))
        
        let colorspace = CGColorSpaceCreateDeviceGray()
        let bitmapContext = CGContext(data: CVPixelBufferGetBaseAddress(pixelBuffer!), width: width, height: height, bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: colorspace, bitmapInfo: 0)!
        
        guard let cg = self.cgImage else {
            return nil
        }
        
        bitmapContext.draw(cg, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        return pixelBuffer
    }
    
    
    
}
