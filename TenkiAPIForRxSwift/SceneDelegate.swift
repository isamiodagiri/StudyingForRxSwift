//
//  SceneDelegate.swift
//  TenkiAPIForRxSwift
//
//  Created by Isami Odagiri on 2020/12/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        self.window = window
        window.makeKeyAndVisible()

        let vc = AreaListViewController.instantiate()
        let nvc = UINavigationController(rootViewController: vc)
        window.rootViewController = nvc
    }
}

