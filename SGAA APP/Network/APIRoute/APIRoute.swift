//
//  APIRoute.swift
//  Project
//
//  Created by Monica Girgis Kamel on 05/12/2021.
//

import Foundation

class APIRoute{
    
    static let shared:APIRoute = APIRoute()
    private var timer:Timer?
    private var sessionTask:URLSessionDataTask?
    private init(){}
    
    private func initRequest(_ clientRequest:SAGAA)->URLRequest? {
        var request:URLRequest = clientRequest.request
        
        request.httpMethod = clientRequest.method.rawValue
        if clientRequest.body != nil{
            let jsonData = try? JSONSerialization.data(withJSONObject: clientRequest.body as Any, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        
        request.addHeaders(clientRequest.headers)
        
        print("=======================================")
        print(request)
        print(clientRequest.body ?? [:])
        print(clientRequest.queryItems)
        print(request.allHTTPHeaderFields ?? [:])
        print("=======================================")
        return request
    }
    
    private func JSONTask<T:Decodable>(with request: URLRequest, decodingModel: T.Type,clientRequest: SAGAA, completion: @escaping (Result<T, APIError>)-> Void) -> URLSessionDataTask {
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            //            print("request url:\(String(describing: request.url)) with status code \(httpResponse.statusCode)")
            switch httpResponse.statusCode {
            case 200...204:
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                
                if let res = try? JSONDecoder().decode(FlagMessageResponse.self, from: data)  {
//                    guard res.errors?.first?.value?.lowercased() != "unauthenticated" else{
//                        completion(.failure(.unauthenticated))
//                        return
//                    }
                    
                    var responseModel:T!
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        guard JSONSerialization.isValidJSONObject(json) else {
                            completion(.failure(.invalidData))
                            return
                        }
                        responseModel = try JSONDecoder().decode(T.self, from: data)
                    } catch let err {
                        print("request url:\(String(describing: request.url)) with serialization error \(err)")
                        
                        completion(.failure(.jsonConversionFailure))
                        return
                    }
                    completion(.success(responseModel))
                }
            case 401:
//                switch clientRequest{
//                case .login:
//                    break
//                default:
//                    guard UserManager.shared.isUserLoggedIn() else { return}
//                    NotificationCenter.default.post(name: Notification.Name("unauthenticated"), object: nil)
//                }
//                break
                completion(.failure(.unauthenticated))
           
            case 400...504:
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                var responseModel:FlagMessageResponse!
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    guard JSONSerialization.isValidJSONObject(json) else {
                        completion(.failure(.invalidData))
                        return
                    }
                    responseModel = try JSONDecoder().decode(FlagMessageResponse.self, from: data)
                } catch let err {
                    print("request url:\(String(describing: request.url)) with serialization error \(err)")
                    
                    completion(.failure(.jsonConversionFailure))
                    return
                }
                completion(.failure(.FlagFound(error: responseModel.errors.map({ $0.values.map({ $0.joined(separator: "\n") }).joined(separator: "\n") }) ?? "Flag Found with no error message")))
                
            default:
                completion(.failure(.responseUnsuccessful))
            }
        }
        return task
    }
    
    func fetchRequest<T: Decodable>(has loading: Bool = true, clientRequest: SAGAA, decodingModel: T.Type, completion: @escaping (Result<T, APIError>) -> ()){
        
        if loading {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.showspinner), userInfo: nil, repeats: false)
        }
        
        guard let urlRequest:URLRequest = self.initRequest(clientRequest) else {return}
        
        let dataTask = self.JSONTask(with: urlRequest, decodingModel: decodingModel.self, clientRequest: clientRequest) { [weak self] (result) in
            self?.timer?.invalidate()
            self?.timer = nil
            
            DispatchQueue.main.async {
//                switch result{
//                case .failure(let error):
//                    if error == APIError.unauthenticated{
//                        UserManager.shared.clearData()
//                        let vc = Router.storyboardLogin.instantiateViewController(withIdentifier: LoginVC.identifier)
//
//                        completion(result)
//                    }else{
//                        completion(result)
//                    }
//                case .success(_):
//                    completion(result)
//                }
                completion(result)
            }
        }
        dataTask.resume()
    }
    
    @objc func showspinner(){
        //        Helper.showSpinner()
    }
    
    private func handleResponse<T: Decodable>(_ task:URLSessionTask, _ response: Result<T,APIError>)->Result<T,APIError>? {
        return response
    }
}

