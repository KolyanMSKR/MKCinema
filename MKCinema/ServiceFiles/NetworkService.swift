//
//  NetworkService.swift
//  MKCinema
//
//  Created by Admin on 1/11/21.
//

import Foundation

class NetworkService {
    
    private func createDataTask(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let httpStatusCode = (response as? HTTPURLResponse)?.statusCode else {
                completion(nil, error)
                
                return
            }
            
            if (200...299).contains(httpStatusCode) == false {
                return completion(nil, error)
            }
            
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
        
        task.resume()
    }
    
    func fetchJSONData<DataModel>(request: URLRequest,
                                  modelType: DataModel.Type,
                                  completion: @escaping (DataModel?) -> ())
    where DataModel: Decodable {
        
        createDataTask(request: request) { data, error in
            guard let data = data else {
                return completion(nil)
            }
            
            do {
                let jsonData = try JSONDecoder().decode(DataModel.self, from: data)
                completion(jsonData)
            } catch {
                completion(nil)
            }
        }
    }
    
}
