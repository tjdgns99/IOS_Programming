//
//  ViewController.swift
//  Kimsunghoon_Ios_programming_week_14_HW
//
//  Created by Capstone on 2023/06/11.
//

import UIKit
import Vision
import AVFoundation
import AVKit
import CoreML

class CameraAlbumViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var vnCoreMLRequest: VNCoreMLRequest!
    var captureSession: AVCaptureSession?
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vnCoreMLRequest = createCoreML(modelName: "SqueezeNet", modelExt: "mlmodelc", completionHandler: handleImageClassifier)

        captureSession = AVCaptureSession()
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(startStop))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func startStop(sender: UITapGestureRecognizer){
        guard let captureSession = captureSession else{ return}
        if captureSession.isRunning{
            captureSession.stopRunning()
        }else{
            captureSession.startRunning()
        }
    }


    @IBAction func takePicture(_ sender: UIButton) {
        // 컨트로러를 생성한다
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self // 이 딜리게이터를 설정하면 사진을 찍은후 호출된다
        
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
            }else{
                imagePickerController.sourceType = .photoLibrary
            }
        
            // UIImagePickerController이 활성화 된다, 11장을 보라
            present(imagePickerController, animated: true, completion: nil)
    }
    
}

extension CameraAlbumViewController: AVCaptureVideoDataOutputSampleBufferDelegate{
    func createVideoInput() -> AVCaptureDeviceInput? {
    // 앞 슬라이드 코트 복사
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else{
            print("Not found input Device")
            return nil
        }
        return try? AVCaptureDeviceInput(device: device)
    }
    func createVideoOutput() -> AVCaptureVideoDataOutput? {
        // 앞 슬라이드 코트 복사
        let videoOutput = AVCaptureVideoDataOutput()
        let settings: [String: Any] = [kCVPixelBufferPixelFormatTypeKey as String: NSNumber(value: kCVPixelFormatType_32BGRA)]
        
        videoOutput.videoSettings = settings
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global())
        videoOutput.connection(with: .video)?.videoOrientation = .portrait
        return videoOutput
    }
    
    func attachPreviewer(captureSession: AVCaptureSession){
    // 앞 슬라이드 코트 복사
        let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        avCaptureVideoPreviewLayer.frame = imageView.layer.bounds
        avCaptureVideoPreviewLayer.videoGravity = .resize
        imageView.layer.addSublayer(avCaptureVideoPreviewLayer)

    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // 여기서 이미지가 담겨져 온 sampleBuffer에 대한 처리를 하면된다.
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        let ciImage = CIImage(cvImageBuffer: imageBuffer)
        let handler = VNImageRequestHandler(ciImage: ciImage)
        try! handler.perform([vnCoreMLRequest])

    }
}

extension CameraAlbumViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    // 사진을 찍은 경우 호출되는 함수
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    
        // 여기서 이미지에 대한 추가적인 작업을 한다
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
        
        let handler = VNImageRequestHandler(ciImage: CIImage(image: image)!)
        try! handler.perform([ vnCoreMLRequest ])
    }
    
    // 사진 캡쳐를 취소하는 경우 호출 함수
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // imagePickerController을 죽인다
        picker.dismiss(animated: true, completion: nil)
    }
}

extension CameraAlbumViewController{
    func createCoreML(modelName: String, modelExt: String, completionHandler: @escaping (VNRequest, Error?) -> Void) -> VNCoreMLRequest?{
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: modelExt) else {
            return nil
        }
        guard let vnCoreMLModel = try? VNCoreMLModel(for: MLModel(contentsOf: modelURL)) else{
            return nil
        }
        return VNCoreMLRequest(model: vnCoreMLModel, completionHandler: completionHandler)
    }
    

}


extension CameraAlbumViewController{
    func handleImageClassifier(request: VNRequest, error: Error?){
        guard let results = request.results as? [VNClassificationObservation] else{ return }
        if let topResult = results.first{
            DispatchQueue.main.async {
                self.messageLabel.text = "\(topResult.confidence)확률로 \(topResult.identifier)입니다."

            }
        }
    }
}
