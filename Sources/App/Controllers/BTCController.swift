import Vapor

class BTCController {
    var router:Router?
    let jsonEncoder = JSONEncoder()
    let client = APIClient()
    init(router:Router) {
        self.router = router
        let RCLRoute = router.grouped("BTC")
        RCLRoute.post("submit",String.parameter,use: submit)
    }

    func submit(req: Request) throws -> Future<Response> { 
        let blob = try req.parameters.next(String.self)
        let blockchain = BTC.submitBTC(blob:blob)
        let route = ClientRoute.submitBTC(blockchain:blockchain)
        let response = try client.send(req:req,clientRoute:route)
        return response
    }
}