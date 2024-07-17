//
//  ImagesCoordinator.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 13.06.2024.
//

import Foundation
import SwiftUI

enum ImagesPage {
    case list, detail(imageModel: ImageModel)
}


final class ImagesCoordinator: Hashable {
    @Binding var navigationPath: NavigationPath

    private var id: UUID
    private var page: ImagesPage

    init(
        page: ImagesPage,
        navigationPath: Binding<NavigationPath>
    ) {
        id = UUID()
        self.page = page
        self._navigationPath = navigationPath
    }

    @ViewBuilder
    func view() -> some View {
        switch self.page {
            case .list:
                listView()
            case .detail(let imageModel):
                detailView(imageModel: imageModel)
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (
        lhs: ImagesCoordinator,
        rhs: ImagesCoordinator
    ) -> Bool {
        lhs.id == rhs.id
    }
    
    private func listView() -> some View {
        let listViewPresenter = ImageListPresenter(
            output: .init(goToDetail: { imageModel in
                self.push(ImagesCoordinator(
                    page: .detail(imageModel: imageModel),
                    navigationPath: self.$navigationPath
                ))
            })
        )
        return ImagesListView(presenter: listViewPresenter)
    }
    
    private func detailView(imageModel: ImageModel) -> some View {
        let detailPresenter = ImageDetailPresenter(imageModel: imageModel)
        return ImageDetailView(presenter: detailPresenter)
    }

    func push<V>(_ value: V) where V : Hashable {
        navigationPath.append(value)
    }
}
