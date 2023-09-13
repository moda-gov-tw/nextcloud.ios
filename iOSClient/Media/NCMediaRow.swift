//
//  NCMediaRow.swift
//  Nextcloud
//
//  Created by Milen on 05.09.23.
//  Copyright © 2023 Marino Faggiana. All rights reserved.
//

import SwiftUI
import PreviewSnapshots
import VisibilityTrackingScrollView

struct NCMediaRow: View {
    let metadatas: [tableMetadata]
    let geometryProxy: GeometryProxy

    @StateObject private var viewModel = NCMediaRowViewModel()
    private let spacing: CGFloat = 2

    var body: some View {
        HStack(spacing: spacing) {
            if viewModel.rowData.scaledThumbnails.isEmpty {
                let randomHeight = CGFloat.random(in: 150...300)

                ForEach(metadatas, id: \.self) { metadata in
                    NCMediaLoadingCell(height: randomHeight, itemsInRow: metadatas.count, metadata: metadata)
                }
            } else {
                ForEach(viewModel.rowData.scaledThumbnails, id: \.self) { thumbnail in
                    NCMediaCell(thumbnail: thumbnail, shrinkRatio: viewModel.rowData.shrinkRatio)
                }
            }
        }
        .onAppear {
            viewModel.configure(metadatas: metadatas)
            viewModel.downloadThumbnails(rowWidth: geometryProxy.size.width, spacing: spacing)
        }
    }
}
