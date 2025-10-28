import Foundation
import Playgrounds

struct Film: Codable, Identifiable, Equatable {
    
    let id: String
    let title: String
    let image: String
    let description: String
    let director: String
    let producer: String
    let people: [String]
    
    let bannerImage: String
    let releaseYear: String
    let duration: String
    let score: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, description, director, producer, people
        
        case bannerImage = "movie_banner"
        case releaseYear = "release_date"
        case duration = "running_time"
        case score = "rt_score"
    }
}

#Playground {
    let url = URL(string: "https://ghibliapi.vercel.app/films")!
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        try
        JSONDecoder().decode([Film].self, from: data)
    } catch {
        print(error)
        
    }
}
