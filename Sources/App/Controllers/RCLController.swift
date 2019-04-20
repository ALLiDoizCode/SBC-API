import Vapor

class RCLController {
    var router:Router?
    let jsonEncoder = JSONEncoder()
    let client = APIClient()
    init(router:Router) {
        self.router = router
        let RCLRoute = router.grouped("RCL")
        RCLRoute.post("submit",String.parameter,use: submit)
        RCLRoute.post("accountInfo",String.parameter,use: accountInfo)
    }

    func submit(req: Request) throws -> Future<Response> { 
        let blob = try req.parameters.next(String.self)
        let blockchain = XRP.submitXRP(blob:blob)
        let route = ClientRoute.submitRCL(blockchain:blockchain)
        let response = try client.send(req:req,clientRoute:route)
        return response
    }

    func accountInfo(req: Request) throws -> Future<Response> { 
        let address = try req.parameters.next(String.self)
        let blockchain = XRP.accountInfo(address:address)
        let route = ClientRoute.submitRCL(blockchain:blockchain)
        let response = try client.send(req:req,clientRoute:route)
        return response
    }
}