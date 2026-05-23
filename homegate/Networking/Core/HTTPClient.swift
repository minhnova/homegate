//
//  HTTPClient.swift
//  homegate
//
//  Created by Phai Hoang on 21/5/26.
//

import Foundation

protocol HTTPClientProtocol {
    func send<R: APIRequest>(_ request: R) async throws -> R.Response
}

final class HTTPClient: HTTPClientProtocol {
    private let configuration: APIConfiguration
    private let session: URLSession
    private let decoder: JSONDecoder
    private let tokenProvider: (() -> String?)?

    init(
        configuration: APIConfiguration,
        session: URLSession = .shared,
        decoder: JSONDecoder = {
            let d = JSONDecoder()
            d.keyDecodingStrategy = .convertFromSnakeCase
            d.dateDecodingStrategy = .iso8601
            return d
        }(),
        tokenProvider: (() -> String?)? = nil
    ) {
        self.configuration = configuration
        self.session = session
        self.decoder = decoder
        self.tokenProvider = tokenProvider
    }

    func send<R: APIRequest>(_ request: R) async throws -> R.Response {
        var urlRequest = try request.buildURLRequest(
            baseURL: configuration.baseURL,
            defaultHeaders: configuration.defaultHeaders,
            defaultTimeout: configuration.defaultTimeoutInterval
        )

        if request.requiresAuth, let token = tokenProvider?() {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, _) = try await perform(urlRequest)

        return try decode(R.Response.self, from: data)
    }

    private func perform(_ urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        do {
            let (data, response) = try await session.data(for: urlRequest)
            if let error = validate(response: response, data: data) {
                throw error
            }
            return (data, response)
        } catch let error as NetworkError {
            throw error
        } catch let urlError as URLError {
            throw map(urlError: urlError)
        } catch {
            throw NetworkError.unknown(error)
        }
    }

    private func validate(response: URLResponse, data: Data) -> NetworkError? {
        guard let http = response as? HTTPURLResponse else { return .unknown(URLError(.badServerResponse)) }
        switch http.statusCode {
        case 200...299:
            return nil
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 400...499:
            return .clientError(statusCode: http.statusCode, data: data)
        case 500...599:
            return .serverError(statusCode: http.statusCode, data: data)
        default:
            return .unknown(URLError(.badServerResponse))
        }
    }

    private func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        do { return try decoder.decode(type, from: data) }
        catch let e as DecodingError { throw NetworkError.decodingFailed(e) }
    }

    private func map(urlError: URLError) -> NetworkError {
        switch urlError.code {
        case .notConnectedToInternet, .networkConnectionLost:
            return .noInternetConnection
        case .timedOut:
            return .timeout
        case .cancelled:
            return .cancelled
        default:
            return .unknown(urlError)
        }
    }
}
