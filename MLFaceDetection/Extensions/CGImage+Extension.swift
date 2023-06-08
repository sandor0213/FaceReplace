//
//  CGImage+Extension.swift
//  MLFaceDetection
//

import UIKit

extension CGImage {
    func determineScale(imageViewFrame: CGRect) -> CGRect {
        let originalWidth = CGFloat(width)
        let originalHeight = CGFloat(height)
        
        let imageFrame = imageViewFrame
        let widthRatio = originalWidth / imageFrame.width
        let heightRation = originalHeight / imageFrame.height
        
        let scaleRatio = max(widthRatio, heightRation)
        
        let scaledImageWidth = originalWidth / scaleRatio
        let scaledImageHeight = originalHeight / scaleRatio
        
        let scaledImageX = (imageFrame.width - scaledImageWidth) / 2
        let scaledImageY = (imageFrame.height - scaledImageHeight) / 2
        
        return CGRect(x: scaledImageX, y: scaledImageY, width: scaledImageWidth, height: scaledImageHeight)
    }
}
