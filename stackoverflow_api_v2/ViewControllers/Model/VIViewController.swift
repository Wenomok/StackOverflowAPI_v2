//
//  HWViewController.swift
//  hudway-drive-client-ios
//
//  Created by Vladislav on 1/23/19.
//  Copyright © 2019 HUDWAY. All rights reserved.
//

import UIKit

class VIViewController: UIViewController {

//    var pageCoordinator: RTPageCoordinator!
//    var commonDataContext: NSMutableDictionary! {
//        get {
//            return self.pageCoordinator.commonDataContext
//        }
//    }
    
    var currentChildController: UIViewController?
    
    // MARK: Override properties
    
    override var classForCoder: AnyClass {
        return self.classForCoder
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    var hasSafeArea: Bool {
        guard #available(iOS 11.0, *), let topPadding = self.view.window?.safeAreaInsets.top, topPadding > 24 else {
            return false
        }
        
        return true
    }
    
    // MARK: Init
    
    deinit {
        print("\(String.init(describing: type(of: self))) DEINITED")
    }
    
    init() {
        let nibName: String? = String(describing: type(of: self))
        super.init(nibName: nibName, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    public convenience init(pageCoordinator: RTPageCoordinator!, nibName: String?) {
//        self.init(nibName: nibName, bundle: nil)
//
//        self.pageCoordinator = pageCoordinator
//    }
//
//    public convenience init(pageCoordinator: RTPageCoordinator!) {
//        let nibName = String.init(describing: type(of: self))
//
//        self.init(nibName: nibName, bundle: nil)
//        self.pageCoordinator = pageCoordinator
//    }
    
    func free() {
        
    }
    
    // MARK: Public
    
    func addChild(viewController: VIViewController, toView: UIView) {
        if self.currentChildController != nil {
            self.currentChildController?.view.removeFromSuperview()
            self.currentChildController?.removeFromParent()
        }
        
        self.currentChildController = viewController
        self.addChild(viewController)
        toView.addSubview(viewController.view)
        viewController.view.addConstraintsMatchSuperview()
    }
    
//    func addChild(viewController: HWNavigationController!, toView: UIView!) {
//        self.addChild(viewController)
//        toView.addSubview(viewController.view)
//        viewController.view.addConstraintsMatchSuperview()
//    }
    
    func rotate(contentView: UIView, toDeviceOrientation orientation: UIDeviceOrientation, animated: Bool) {
        var transform: CGAffineTransform = CGAffineTransform.init(rotationAngle: 0)
        var frame: CGRect = self.view.frame
        
        // 44 - высота NavBar, 51 - высота нижнего TabBar
        if orientation == UIDeviceOrientation.landscapeLeft {
            transform = CGAffineTransform.init(rotationAngle: .pi / 2)
            frame = CGRect.init(x: 0.0, y: 44.0, width: self.view.frame.size.width, height: self.view.frame.size.height - 44.0)
        } else if orientation == UIDeviceOrientation.landscapeRight {
            transform = CGAffineTransform.init(rotationAngle: -(.pi / 2))
            frame = CGRect.init(x: 0.0, y: 51.0, width: self.view.frame.size.width, height: self.view.frame.size.height - 49.0)
        }
        
        OperationQueue.main.addOperation({
            if animated {
                UIView.animate(withDuration: 0.5, animations: {
                    contentView.transform = transform
                    contentView.frame = frame
                })
            } else {
                contentView.transform = transform
                contentView.frame = frame
            }
        })
    }
    
    func created(view: UIView?) -> Bool {
        return view != nil
    }
    
    // MARK: Alerts
    
    func showOkAlert(withMessage message: String!) {
        OperationQueue.main.addOperation {
            let alertController = UIAlertController.init(title: "Ошибка", message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: { (alertAction) in
                alertController.dismiss(animated: true, completion: nil)
            })
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true) {
                
            }
        }
    }
    
    // completion returns OK button pressed or not
    func showOkCancelAlert(withMessage message: String, title: String, completion: @escaping ((Bool) -> ())) {
        OperationQueue.main.addOperation {
            let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (alertAction) in
                alertController.dismiss(animated: true, completion: nil)
                completion(true)
            })
            
            let cancelAction = UIAlertAction.init(title: "Отмена", style: UIAlertAction.Style.cancel, handler: { (alertAction) in
                alertController.dismiss(animated: true, completion: nil)
                completion(false)
            })
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true) {
                
            }
        }
    }
    
    func showSettingsCancelAlert(withTitle title: String? = nil, message: String?) {
        OperationQueue.main.addOperation {
            let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction.init(title: "Отмена",
                                              style: .default, handler: nil)
            let settingsAction = UIAlertAction.init(title: "Настройки",
                                                    style: .cancel, handler: { (alertAction) in
                UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            })
            
            alertController.addAction(okAction)
            alertController.addAction(settingsAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: Share content
    
    func share(content: Any, completion: ((Bool) -> ())?) {
        OperationQueue.main.addOperation {
            let shareController = UIActivityViewController.init(activityItems: [content], applicationActivities: nil)
            
            self.present(shareController, animated: true) {
                completion?(true)
            }
        }
    }
    
    func setupNavigationMultilineTitle() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        for sview in navigationBar.subviews {
            for ssview in sview.subviews {
                guard let label = ssview as? UILabel else { break }
                if label.text == self.title {
                    label.numberOfLines = 0
                    label.lineBreakMode = .byWordWrapping
                    label.sizeToFit()
                    UIView.animate(withDuration: 0.3, animations: {
                        navigationBar.frame.size.height = 57 + label.frame.height
                    })
                }
            }
        }
    }
}
