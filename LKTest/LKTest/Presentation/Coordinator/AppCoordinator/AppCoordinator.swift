//
//  AppCoordinator.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 13.06.2024.
//

import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published var path: NavigationPath

    init(path: NavigationPath) {
        self.path = path
    }

    @ViewBuilder
    func view() -> some View {
        MainView()
    }
}
