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
}

private extension SceneDelegate {
    func createNavBarController() -> UINavigationController {
        let modelMeneger = ModelMeneger()
        let tracks = modelMeneger.loadMusicData()
        let filmCollectionView = MusicTableViewController(tracks: tracks)
        let navBar = UINavigationController(rootViewController: filmCollectionView)
        return navBar
    }
}

