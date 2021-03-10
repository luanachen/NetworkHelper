import Foundation

public protocol EndpointType {
    var base: String { get }
    var path: String { get }
    var parameters: [String : Any]? { get }
    var pathparam: String? { get }
}

public extension EndpointType {
    var components: URLComponents {
        if var components = URLComponents(string: base) {
            if let paramPath = pathparam {
                    components.path = path + "\(paramPath)"
                }
            if let parameters = parameters, !parameters.isEmpty {
                    components.queryItems = [URLQueryItem]()
                    for (key, value) in parameters {
                        let queryItem = URLQueryItem(name: key, value: "\(value)")
                        components.queryItems!.append(queryItem)
                    }
                }
            return components
        }
        fatalError("Fail to set components!")

    }

    var request: URLRequest {
        if let url = components.url {
            return URLRequest(url: url)
        }
        fatalError("Failed to set URL!")
    }

    func postRequest<T: Encodable>(parameters: T, headers: [HTTPHeader]) -> URLRequest? {
        var request = self.request
        request.httpMethod = HTTPMethod.post.rawValue
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch let error {
            print(APIError.encodeError(description: "\(error)").customDescription)
            return nil
        }
        headers.forEach { request.addValue($0.header.value, forHTTPHeaderField: $0.header.field) }
        return request
    }

}
