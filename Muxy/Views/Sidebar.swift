import SwiftUI

struct Sidebar: View {
    @Environment(AppState.self) private var appState
    @Environment(ProjectStore.self) private var projectStore

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 2) {
                ForEach(projectStore.projects) { project in
                    ProjectItem(
                        project: project,
                        selected: project.id == appState.activeProjectID,
                        onSelect: {
                            appState.activeProjectID = project.id
                            appState.ensureTabExists(for: project)
                        },
                        onRemove: {
                            appState.removeProject(project.id)
                            projectStore.remove(id: project.id)
                        }
                    )
                }
            }
            .padding(6)
        }
        .frame(width: 160)
        .background(MuxyTheme.bg)
    }
}

private struct ProjectItem: View {
    let project: Project
    let selected: Bool
    let onSelect: () -> Void
    let onRemove: () -> Void
    @State private var hovered = false

    var body: some View {
        Text(project.name)
            .font(.system(size: 12, weight: selected ? .semibold : .regular))
            .foregroundStyle(selected ? .white : MuxyTheme.textMuted)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(background, in: RoundedRectangle(cornerRadius: 6))
            .contentShape(RoundedRectangle(cornerRadius: 6))
            .onTapGesture(perform: onSelect)
            .onHover { hovered = $0 }
            .contextMenu {
                Button("Remove Project", role: .destructive, action: onRemove)
            }
    }

    private var background: some ShapeStyle {
        if selected { return AnyShapeStyle(MuxyTheme.accent) }
        if hovered { return AnyShapeStyle(MuxyTheme.hover) }
        return AnyShapeStyle(.clear)
    }
}
