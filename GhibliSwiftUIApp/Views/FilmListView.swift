import SwiftUI

struct FilmListView: View {
    
//    @State private var filmsViewModel = FilmsViewModel()
    var filmsViewModel = FilmsViewModel()
    
    var body: some View {
        NavigationStack {
            switch filmsViewModel.state {
                
            case .idle:
                Text("Empty, No film yet")
//                    .task {
//                        await filmsViewModel.fetch()
//                    } -> remove and move to bottom
            case .loading:
                ProgressView {
                    Text("Loading...")
                }
            case .loaded(let films):
                List(filmsViewModel.films) {
                    Text($0.title)
                }
            case .error(let error):
                Text(error)
                    .foregroundStyle(.pink)
            }
        }
        .task{
            await filmsViewModel.fetch()
        }
    }
}

#Preview {
    FilmListView()
//    FilmListView(filmsViewModel: <#T##FilmsViewModel#>(service: MockGhibliService))
}
