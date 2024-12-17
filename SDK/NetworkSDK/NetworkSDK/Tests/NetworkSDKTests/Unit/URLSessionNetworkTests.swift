
import XCTest
@testable import NetworkSDK

final class URLSessionNetworkTests: XCTestCase {

    override func setUp() {
        URLProtocolStub.startInterceptingRequests()
    }
    
    override func tearDown() {
        URLProtocolStub.stopInterceptingRequests()
    }
    
    func test_getFromURL_performsGETRequestWithURL_shouldSendSuccessData() async {
        await resultFor(data: anyData(), response: anyHTTPURLResponse(), expectedError: nil)
    }
    
    func test_getFromURL_performsGETwithHeaders_shouldSendSuccessData() async {
        let exp = expectation(description: "Wait for request")
        let exp2 = expectation(description: "Wait for response")
        
        URLProtocolStub.stub(url: anyURL(), data: anyData(), response: anyHTTPURLResponse(), error: nil)
        
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, self.anyURL())
            XCTAssertEqual(request.httpMethod, "GET")
            XCTAssertEqual(request.allHTTPHeaderFields, ["header": "header"])
            exp.fulfill()
        }
        
        let sut = sut()
        
        do {
            let object : Object = try await sut.get(from: anyURL(), headers: ["header": "header"])
            XCTAssertEqual(object.text, "any data")
            exp2.fulfill()
        } catch {}
        
        await fulfillment(of: [exp, exp2], timeout: 2)
    }
    
    func test_getFromURL_performsGETwithHeadersAndBody_shouldSendSuccessData() async {
        let exp = expectation(description: "Wait for request")
        let exp2 = expectation(description: "Wait for response")
        
        URLProtocolStub.stub(url: anyURL(), data: anyData(), response: anyHTTPURLResponse(), error: nil)
        
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, self.anyURL())
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertEqual(request.allHTTPHeaderFields, ["Content-Length": "9", "header": "header"])
            exp.fulfill()
        }
        
        let sut = sut()
        
        do {
            let object : Object = try await sut.get(from: anyURL(), httpMethod: .POST, headers: ["header": "header"], body: formatRequestBody(with: ["Body" : "Body"]))
            XCTAssertEqual(object.text, "any data")
            exp2.fulfill()
        } catch {}
        
        await fulfillment(of: [exp, exp2], timeout: 2)
    }
    
    func test_getFromURL_failsOnRequestError() async {
        
        let expectedError = NSError(domain: "any error", code: 1)
        
        await resultFor(data: nil, response: nil, expectedError: expectedError)
    }
    
    func test_getFromURL_failsOnResponseError() async {
        let error = NetworkError.serverError(statusCode: anyErrorHTTPURLResponse()?.statusCode ?? 0)
        await resultFor(data: nil, response: anyErrorHTTPURLResponse(), expectedError: error)
    }
    
    private func resultFor(
        data: Data?,
        response: URLResponse?,
        expectedError: Error?,
        file: StaticString = #file,
        line: UInt = #line) async
    {
        let exp = expectation(description: "Wait for request")
        let exp2 = expectation(description: "Wait for response")
        
        URLProtocolStub.stub(url: anyURL(), data: data, response: response, error: expectedError)
        
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, self.anyURL())
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
        }
        
        let sut = sut()
        
        do {
            let object : Object = try await sut.get(from: anyURL())
            XCTAssertEqual(object.text, "any data")
            exp2.fulfill()
        } catch {
            XCTAssertEqual(expectedError?.localizedDescription, error.localizedDescription)
            exp2.fulfill()
        }
        
        await fulfillment(of: [exp, exp2], timeout: 2)
    }
    
    // MARK: HELPERS
    func sut() -> URLSessionNetwork {
        let sut = URLSessionNetwork()
        trackForMemoryLeaks(sut)
        return sut
    }
    
    private func anyURL() -> URL {
        URL(string: "http://any-url.com")!
    }
    
    private func anyData() -> Data {
        let object = Object(text: "any data")
        
        let jsonData = try! JSONEncoder().encode(object)
        return jsonData
    }
    
    struct Object: Decodable, Encodable {
        var text: String
    }
    
    private func anyError() -> NSError {
        NSError(domain: "any error", code: 0)
    }
    
    private func anyHTTPURLResponse() -> HTTPURLResponse? {
        HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)
    }
    
    private func anyErrorHTTPURLResponse() -> HTTPURLResponse? {
        HTTPURLResponse(url: anyURL(), statusCode: -500, httpVersion: nil, headerFields: nil)
    }
    
    private func formatRequestBody(with bodyDict: [String: String]) -> Data? {
        var requestBodyComponents = URLComponents()
        requestBodyComponents.queryItems = []
        bodyDict.forEach {
            let item = URLQueryItem(name: $0.key, value: $0.value)
            requestBodyComponents.queryItems?.append(item)
        }
        return requestBodyComponents.query?.data(using: .utf8)
    }
    
    private class URLProtocolStub: URLProtocol {
        private static var stub: Stub?
        private static var requestObserver: ((URLRequest) -> Void)?
        
        private struct Stub {
            let data: Data?
            let response: URLResponse?
            let error: Error?
        }
        
        static func stub(
            url: URL,
            data: Data?,
            response: URLResponse?,
            error: Error?
        ) {
            stub = Stub(data: data, response: response, error: error)
        }
        
        static func observeRequests(observer: @escaping (URLRequest) -> Void) {
            requestObserver = observer
        }
        
        static func startInterceptingRequests() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }
        
        static func stopInterceptingRequests() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
            stub = nil
            requestObserver = nil
        }
        
        override class func canInit(with request: URLRequest) -> Bool {
            requestObserver?(request)
            return true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        
        override func startLoading() {
            guard let stub = URLProtocolStub.stub else {return}
            
            if let data = stub.data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            if let response = stub.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            if let error = stub.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
        
        override func stopLoading() {}
    }

}

public extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance,
                         "Instance should have been deallocatyed. Potential memory leak.",
                         file: file,
                         line: line)
        }
    }
}
