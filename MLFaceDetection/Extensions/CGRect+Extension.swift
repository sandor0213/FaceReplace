//
//  CGRect+Extension.swift
//  MLFaceDetection
//

import UIKit

extension CGRect {
     func convertUnitToPoint(targetRect: CGRect) -> CGRect {
        var pointRect = targetRect
        pointRect.origin.x = origin.x + (targetRect.origin.x * size.width)
        pointRect.origin.y = origin.y + (1 - targetRect.origin.y - targetRect.height) * size.height
        pointRect.size.width *= size.width
        pointRect.size.height *= size.height
        return pointRect
    }
}
