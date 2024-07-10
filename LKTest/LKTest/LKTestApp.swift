//
//  LKTestApp.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 10.06.2024.
//

import SwiftUI

@main
struct LKTestApp: App {
    @StateObject private var appCoordinator = AppCoordinator(path: NavigationPath())

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.path) {
                appCoordinator.view()
                    .navigationDestination(
                        for: ImagesCoordinator.self
                    ) { coordinator in
                        coordinator.view()
                    }
            }
            .environmentObject(appCoordinator)
        }
    }
}
