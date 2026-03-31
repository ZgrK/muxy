import Foundation

final class Project: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var path: String
    var sortOrder: Int
    var createdAt: Date
    var icon: String?

    init(name: String, path: String, sortOrder: Int = 0) {
        self.id = UUID()
        self.name = name
        self.path = path
        self.sortOrder = sortOrder
        self.createdAt = Date()
        self.icon = nil
    }

    var pathExists: Bool {
        FileManager.default.fileExists(atPath: path)
    }

    static func == (lhs: Project, rhs: Project) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
