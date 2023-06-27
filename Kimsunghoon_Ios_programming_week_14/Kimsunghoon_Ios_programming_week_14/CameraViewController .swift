//
//  ViewController.swift
//  Kimsunghoon_Ios_programming_week_14
//
//  Created by Capstone on 2023/06/05.
//

import UIKit
import AVKit
import Vision

class CameraViewController: UIViewController {

    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var previewView: UIView!
    var captureSession: AVCaptureSession?
    var count = 0
    var vnCoreMLRequest: VNCoreMLRequest!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        vnCoreMLRequest = createCoreML(modelName: "SqueezeNet", modelExt: "mlmodelc", completionHandler: handleImageClassifier)
        captureSession = AVCaptureSession()

        
        captureSession = AVCaptureSession()
        captureSession!.beginConfiguration()
    
        captureSession!.sessionPreset = .high
    
        guard let videoInput = createVideoInput() else{ return }
        captureSession!.addInput(videoInput)    // (1) VideoInput 디바이스 부착
    
        attachPreviewer(captureSession: captureSession!)
    
        guard let videoOutput = createVideoOutput() else{ return }
        captureSession!.addOutput(videoOutput) // (2) VideoOutput 디바이스 부착
    
        captureSession!.commitConfiguration()   // (3) Previewer 설정
        captureSession!.startRunning()
    
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(startStop))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func startStop(sender: UITapGestureRecognizer){
        guard let captureSession = captureSession else{ return}
        if captureSession.isRunning{
            captureSession.stopRunning()
        }else{
            captureSession.startRunning()
        }
    }
    
}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate{
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
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        count += 1
        print("여기서 이미지가 담겨져 온 sampleBuffer에 대한 처리를 하면된다.\(count)")
        // 여기서 이미지가 담겨져 온 sampleBuffer에 대한 처리를 하면된다.
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        let ciImage = CIImage(cvImageBuffer: imageBuffer)
        let handler = VNImageRequestHandler(ciImage: ciImage)
        try! handler.perform([vnCoreMLRequest])

    }
    
    }
    func attachPreviewer(captureSession: AVCaptureSession){
    // 앞 슬라이드 코트 복사
        let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        avCaptureVideoPreviewLayer.frame = previewView.layer.bounds
        avCaptureVideoPreviewLayer.videoGravity = .resize
        previewView.layer.addSublayer(avCaptureVideoPreviewLayer)

    }
    @objc func takePicture2(sender: UITapGestureRecognizer){
    // 앞 슬라이드 코트 복사
    }
    
    func handleResults(request: VNRequest, error: Error?){
        guard let results = request.results as? [VNClassificationObservation] else{ return }
        // 여기서 results(분류등의 결과)의 내용을 사용자에게 알린다.
    }
}

extension CameraViewController{
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

extension CameraViewController{
    func handleImageClassifier(request: VNRequest, error: Error?){
        guard let results = request.results as? [VNClassificationObservation] else{ return }
        if let topResult = results.first{
            DispatchQueue.main.async {
                self.messageLabel.text = "\(topResult.identifier)입니다."
            }
        }
    }
}



