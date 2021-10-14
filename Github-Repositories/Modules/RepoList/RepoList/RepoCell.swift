import SwiftUI

struct RepoCell: View {
    let repo: Repo
    
    var body: some View {
        VStack(spacing: 10) {
            VStack {
                Text(repo.name ?? "")
                    .leadingAlignment()
                    .foregroundColor(.black)
                
                if (repo.fork ?? false) {
                    Text("Forked from other repo")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .leadingAlignment()
                }
            }
            
            if let description = repo.description {
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .leadingAlignment()
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}
