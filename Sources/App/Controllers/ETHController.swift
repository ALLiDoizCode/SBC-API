import Vapor

class ETHController {
    var router:Router?
    let jsonEncoder = JSONEncoder()
    let client = APIClient()
    init(router:Router) {
        self.router = router
        let RCLRoute = router.grouped("ETH")
        RCLRoute.post("submit",String.parameter,use: submit)
        RCLRoute.get("balance",String.parameter,use: balance)
        RCLRoute.get("transactionCount",String.parameter,use: transactionCount)
        RCLRoute.get("transaction",String.parameter,use: transaction)
        RCLRoute.get("history",String.parameter,Int.parameter,Int.parameter,use: history)
        RCLRoute.get("currentBlock",use: currentBlock)
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

    func transaction(req: Request) throws -> Future<Response> { 
        let hash = try req.parameters.next(String.self)
        let blockchain = ETH.transaction(hash:hash)
        let route = ClientRoute.submitETH(blockchain:blockchain)
        let response = try client.send(req:req,clientRoute:route)
        return response
    }

    func history(req: Request) throws -> Future<Response> { 
        let address = try req.parameters.next(String.self)
        let start = try req.parameters.next(Int.self)
        let end = try req.parameters.next(Int.self)
        let blockchain = ETH.history(address:address,start:start,end:end)
        let route = ClientRoute.submitETH(blockchain:blockchain)
        let response = try client.send(req:req,clientRoute:route)
        return response
    }

    func currentBlock(req: Request) throws -> Future<Response> { 
        let blockchain = ETH.currentBlock
        let route = ClientRoute.submitETH(blockchain:blockchain)
        let response = try client.send(req:req,clientRoute:route)
        return response
    }
}
