import Foundation

@MainActor
@Observable
final class TerminalTab: Identifiable {
    let id = UUID()
    var customTitle: String?
    var isPinned: Bool = false
    let pane: TerminalPaneState

    var title: String { customTitle ?? pane.title }

    init(pane: TerminalPaneState) {
        self.pane = pane
    }
}
