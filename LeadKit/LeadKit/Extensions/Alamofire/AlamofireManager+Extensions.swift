//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Alamofire
import RxSwift
import RxAlamofire
import ObjectMapper

public extension Reactive where Base: Alamofire.SessionManager {

    /// Method which executes request with given api parameters
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Returns: Observable with request
    func apiRequest(requestParameters: ApiRequestParameters) -> Observable<DataRequest> {
        return RxAlamofire.request(requestParameters.method,
                                   requestParameters.url,
                                   parameters: requestParameters.parameters,
                                   encoding: requestParameters.encoding,
                                   headers: requestParameters.headers)
    }

    /// Method which executes request and serializes response into target object
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and target object
    func responseModel<T: ImmutableMappable>(requestParameters: ApiRequestParameters,
                       mappingQueue: DispatchQueue = DispatchQueue.global())
        -> Observable<(response: HTTPURLResponse, model: T)> {

        return apiRequest(requestParameters: requestParameters)
            .flatMap { $0.rx.apiResponse(mappingQueue: mappingQueue) }
    }

    /// Method which executes request and serializes response into target object
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and target object
    func responseObservableModel<T: ObservableMappable>(requestParameters: ApiRequestParameters,
                                 mappingQueue: DispatchQueue = DispatchQueue.global())
        -> Observable<(response: HTTPURLResponse, model: T)> where T.ModelType == T {

        return apiRequest(requestParameters: requestParameters)
            .flatMap { $0.rx.apiResponse(mappingQueue: mappingQueue) }
    }

}
