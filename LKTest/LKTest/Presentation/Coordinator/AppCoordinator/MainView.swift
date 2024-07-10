//
//  MainView.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 10.07.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        Group {
            ImagesCoordinator(
                page: .list,
                navigationPath: $appCoordinator.path
            ).view()
        }
    }
}

#Preview {
    MainView()
}
