
import Foundation

struct MockGhibliService: GhibliService {
    func fetchPerson(from URLString: String) async throws -> Person {
        let data = try loadSampleData()
        guard let person = data.people.first else {
            throw APIError.notFound("No people found in sample data.")
        }
        return person
    }
    
//    func fetchPerson(from url: URL) async throws -> Person {
//        let data = try loadSampleData()
//        guard let person = data.people.first else {
//            throw APIError.notFound("No people found in sample data.")
//        }
//        return person
//    }
    
    
    //MARK: - Protocol conformance
    func fetchFilms() async throws -> [Film] {
        let data = try loadSampleData()
        return data.films
    }
    
    private struct SampleData: Decodable {
        let films: [Film]
        let people: [Person]
    }
    private func loadSampleData() throws -> SampleData {
        guard let url = Bundle.main.url(forResource: "SampleJson", withExtension: "json") else {
            throw APIError.invalidURL
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(SampleData.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    //MARK: - preview/testing only
    
    func fetchFilm() -> Film {
        let data = try! loadSampleData()
        return data.films.first!
    }
    
    

}
