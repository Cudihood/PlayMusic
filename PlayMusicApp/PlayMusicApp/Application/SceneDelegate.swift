//
//  SceneDelegate.swift
//  PlayMusicApp
//
//  Created by Даниил Циркунов on 22.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = createNavBarController()
        window?.makeKeyAndVisible()
    }
    
    private func createNavBarController() -> UINavigationController {
        let filmCollectionView = MusicTableViewController()
        let navBar = UINavigationController(rootViewController: filmCollectionView)
        return navBar
    }
}

