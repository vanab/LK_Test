//
//  ImagesCoordinator.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 13.06.2024.
//

import Foundation
import SwiftUI

enum ImagesPage {
    case list, detail(id: Int)
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
            case .detail(let id):
                detailView(id: id)
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
            output: .init(goToDetail: { id in
                self.push(ImagesCoordinator(
                    page: .detail(id: id),
                    navigationPath: self.$navigationPath
                ))
            })
        )
        return ImagesListView(presenter: listViewPresenter)
    }
    
    private func detailView(id: Int) -> some View {
        let detailPresenter = ImageDetailPresenter(photoId: id)
        return ImageDetailView(presenter: detailPresenter)
    }

    func push<V>(_ value: V) where V : Hashable {
        navigationPath.append(value)
    }
}
