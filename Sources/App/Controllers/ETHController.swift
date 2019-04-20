import Vapor

class ETHController {
    var router:Router?
    let jsonEncoder = JSONEncoder()
    let client = APIClient()
    init(router:Router) {
        self.router = router
        let RCLRoute = router.grouped("ETH")
        RCLRoute.post("submit",String.parameter,use: submit)
        RCLRoute.post("balance",String.parameter,use: balance)
        RCLRoute.post("transactionCount",String.parameter,use: transactionCount)
    }

    func submit(req: Request) throws -> Future<Response> { 
        let blob = try req.parameters.next(String.self)
        let blockchain = ETH.submitETH(blob:blob)
        let route = ClientRoute.submitETH(blockchain:blockchain)
        let response = try client.send(req:req,clientRoute:route)
        return response
    }

    func balance(req: Request) throws -> Future<Response> { 
        let address = try req.parameters.next(String.self)
        let blockchain = ETH.balance(address:address)
        let route = ClientRoute.submitETH(blockchain:blockchain)
        let response = try client.send(req:req,clientRoute:route)
        return response
    }

    func transactionCount(req: Request) throws -> Future<Response> { 
        let address = try req.parameters.next(String.self)
        let blockchain = ETH.transactionCount(address:address)
        let route = ClientRoute.submitETH(blockchain:blockchain)
        let response = try client.send(req:req,clientRoute:route)
        return response
    }
}