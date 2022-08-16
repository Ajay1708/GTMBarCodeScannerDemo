//
//  ViewController.swift
//  GTMBarCodeScannerDemo
//
//  Created by Venkata Ajay Sai (Paras) on 16/08/22.
//

import UIKit

import GTMBarcodeScanner

class ViewController: UIViewController, GTMBarcodeCoreDelegate {
    @IBOutlet weak var scannerView: UIView!
    @IBOutlet weak var flashLightButton: PositionableButton!

    var scanner: BarcodeScanner!
    var uiType: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
       
        flashLightButton.isHidden = true
        self.view.backgroundColor = .black
        
        let scanner = BarcodeScanner.create(view: self.view)
        
        // 风格设置
        scanner.makeStyle { (make) in
            if uiType == "wechat" {
                make.wechat()
                self.title = "微信风格"
            }
            if uiType == "alipay" {
                make.alipay()
                self.title = "支付宝风格"
            }
            //custom
            if uiType == "custom" {
                make.custom()
                self.title = "自定义风格"
            }
            
            make.soundSource(forName: "VoiceSearchOn", andType: "wav")
        }
        
        // 配置
//        scanner.config { (make) in
//            make.autoCloser(true)       // 自动拉近镜头
//            make.caputureImage(true)    // 记录扫码的源图片
//            make.printLog(true)         // 调试信息打印控制
//        }
        
        scanner.delegate = self
        scanner.start()
        self.scanner = scanner
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func onFlashLight(_ sender: UIButton) {
        scanner.toggleFlashLight()
        if scanner.isFlashOn {
            sender.setTitle("轻触关闭", for: .normal)
            sender.setImage(UIImage(named: "flash_on"), for: .normal)
        } else {
            sender.setTitle("轻触打开", for: .normal)
            sender.setImage(UIImage(named: "flash_off"), for: .normal)
        }
    }
    @IBAction func onPhotoAlbarm(_ sender: Any) {
        scanner.openPhotoAlbum(fromController: self)
    }
    
    // MARK: - GTMBarcodeCoreDelegate
    
    func lightnessChange(needFlashButton: Bool) {
//        print("----------> needFlash = \(needFlashButton)")
        flashLightButton.isShow = needFlashButton
    }
    
    func barcodeRecognized(result: BarcodeResult) {
        print("----------> result = \(result.barcode)")
    }
    
    func barcodeForPhoto(result: BarcodeResult?) {
        if let re = result {
            print("----------> result = \(re.barcode)")
        } else {
            print("无法识别图片中的条码")
        }
    }

}

extension StyleMaker {
    
    func wechat() {
        positionUpVal(44)
        anglePosition(ScanViewStyle.AnglePosition.inner)
        angleLineWeight(3)
        angleLineLength(18)
        isShowRetangleBorder(true)
        animateType(ScanViewStyle.Animation.lineMove)
        retangleLineWeight(1/UIScreen.main.scale)
        colorOfRetangleLine(.lightGray)
        colorOfAngleLine(UIColor(red: 0.0/255, green: 200.0/255.0, blue: 20.0/255.0, alpha: 1.0))
    }
    
    func alipay() {
        let color = UIColor.init(red: 90/255, green: 170/255, blue: 253/255, alpha: 1)
        positionUpVal(44)
        anglePosition(ScanViewStyle.AnglePosition.inner)
        angleLineWeight(4)
        angleLineLength(18)
        isShowRetangleBorder(true)
        retangleLineWeight(1)
        animateType(ScanViewStyle.Animation.gridGrow)
        colorOfAngleLine(color)
        colorOfRetangleLine(color)
    }
    
    func custom() {
        let color = UIColor.init(red: 255/255, green: 157/255, blue: 0/255, alpha: 1)
        positionUpVal(44)
        anglePosition(ScanViewStyle.AnglePosition.inner)
        angleLineWeight(5)
        angleLineLength(18)
        isShowRetangleBorder(true)
        width(280)
        height(180)
        retangleLineWeight(1/UIScreen.main.scale)
        animateType(ScanViewStyle.Animation.lineMove)
        colorOfAngleLine(color)
        colorOfRetangleLine(color)
        let c = UIColor(red: 255/255, green: 157/255, blue: 0/255, alpha: 0.5)
        colorOutside(c)
    }

    
}

