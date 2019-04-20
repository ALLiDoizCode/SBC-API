import Vapor
import Crypto
import Foundation
enum ClientRoute {
    
    case submitRCL(tx:TX)
    case submitETH(blockchain:ETH)
    case submitBTC(tx:String)
    func request() throws -> HTTPRequest {
        var httpReq = HTTPRequest()
        let encoder = JSONEncoder()
        switch self {
            
            case .submitRCL(let tx):
                httpReq = HTTPRequest(method: .POST, url: RCL_URL_TEST)
                let data = try encoder.encode(tx)
                httpReq.body = HTTPBody(data: data)
                return httpReq
            case .submitETH(let blockchain):
                httpReq = HTTPRequest(method: .POST, url: "ETH_URL_Test\(blockchain.endpoint)") 
                return httpReq       
            case .submitBTC(let tx):
                httpReq = HTTPRequest(method: .POST, url: BTC_URL_TEST)
                return httpReq    
        }
        
    }
}

enum ETH {
    case submitETH(blob:String)
    case balance(address:String)
    case transactionCount(address:String)

    func endpoint() throws -> String {
        switch self {
        case .submitETH(let blob):
            return "module=proxy&action=eth_sendRawTransaction&hex=\(blob)&apikey=\(ETH_API_TOKEN)"
        case .balance(let address):
            return "module=account&action=balance&address=\(address)&tag=latest&apikey=\(ETH_API_TOKEN)"
        case .transactionCount(let address):
            return "module=proxy&action=eth_getTransactionCount&address=\(address)&tag=latest&apikey=\(ETH_API_TOKEN)"  
    }
    }
}

