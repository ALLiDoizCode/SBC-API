import Vapor 
class APIClient {
    
    func send(req: Request,clientRoute:ClientRoute) throws -> EventLoopFuture<Response> {
        let client = try req.make(Client.self)
        let container = req.sharedContainer
        let httpReq = client.send(Request(http: try clientRoute.request(), using: container))
        return httpReq.map({ object in
            let response = req.response()
            response.http.status = object.http.status
            response.http.body = object.http.body
            return response
        })
    }
    
}