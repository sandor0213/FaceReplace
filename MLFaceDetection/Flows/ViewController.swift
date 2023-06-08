//
//  ViewController.swift
//  MLFaceDetection
//

import UIKit
import Vision

final class ViewController: UIViewController {
    
    private struct Constants {
        static let imageName = "group"
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var imageOrientation = CGImagePropertyOrientation(.up)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let image = UIImage(named: Constants.imageName) {
            imageView.image = image
            imageOrientation = CGImagePropertyOrientation(image.imageOrientation)
        }
    }
    
    @IBAction func detectAction(_ sender: Any) {
        guard let cgImage = imageView.image?.cgImage else { return }
        self.setupVision(image: cgImage)
    }
}


// MARK: Extension for Vision
private extension ViewController {
    func setupVision(image: CGImage) {
        let faceDetectionRequest = VNDetectFaceRectanglesRequest(completionHandler: handleFaceDetectionRequest)
        let imageRequestHandler = VNImageRequestHandler(cgImage: image, orientation: imageOrientation, options: [:])
        do {
            try imageRequestHandler.perform([faceDetectionRequest])
        } catch let error as NSError {
            print(#function, error)
            return
        }
    }
    
    func handleFaceDetectionRequest(request: VNRequest?, error: Error?) {
        if let requestError = error as NSError? {
            print(requestError)
            return
        }
        
        guard let image = imageView.image, let cgImage = image.cgImage else { return }
        let imageRect = cgImage.determineScale(imageViewFrame: imageView.frame)
        self.imageView.layer.sublayers = nil
        
        if let results = request?.results as? [VNFaceObservation] {
            for observation in results {
                let faceRect = imageRect.convertUnitToPoint(targetRect: observation.boundingBox)
                let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.extraLight))
                blurEffectView.frame = faceRect
                blurEffectView.alpha = 0.85
                imageView.addSubview(blurEffectView)
            }
        }
    }
}
