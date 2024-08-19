import Foundation

// MARK: URLService

enum URLService {
    
    case listAllLeagues
    case searchAllTeams(league: String)
    case searchTeam(team: String)
}

// MARK: - CustomStringConvertible Conformance

extension URLService: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .listAllLeagues:
            return basePath + "/all_leagues.php"
        case .searchAllTeams(let league):
            return basePath + "/search_all_teams.php?l=\(encode(league))"
        case .searchTeam(let team):
            return basePath + "/searchteams.php?t=\(encode(team))"
        }
    }
}

// MARK: - Public

extension URLService {
    
    // MARK: Methods
    
    public static func makeURL(for path: URLService) -> URL {
        guard let url = URL(string: path.description) else {
            preconditionFailure(URLServiceError.invalidURL.localizedDescription)
        }
        return url
    }
}


// MARK: - Private

extension URLService {
    
    // MARK: Computed Properties
    
    private var basePath: String {
        return [
            APIConstants.basePath,
            APIConstants.version,
            APIConstants.format,
            APIConstants.accessKey
        ].joined(separator: "/")
    }
    
    // MARK: Methods
    
    private func encode(_ text: String) -> String {
        guard let encodedText: String = text.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            preconditionFailure(URLServiceError.textEncoding.localizedDescription)
        }
        return encodedText
    }
}

// MARK: Private

private extension URLService {
    
    private enum APIConstants {
        static let accessKey: String  = "50130162"
        static let basePath:  String  = "https://www.thesportsdb.com/api"
        static let format:    String  = "json"
        static let version:   String  = "v1"
    }
}
