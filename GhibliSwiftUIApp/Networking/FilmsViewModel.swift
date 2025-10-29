import Foundation
import Observation



@Observable
class FilmsViewModel {
    enum State: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }
    
    var films: [Film] = []
    var state: State = .idle
    
    private let service: GhibliService
        
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
        
    }
    
    
    func fetch() async {
        guard state == .idle else { return }
        
        state = .loading
        do {
            let films = try await service.fetchFilms()
            self.films = films
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.localizedDescription)
        } catch {
            self.state = .error("Unknown error")
        }
    }
}
