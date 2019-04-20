import Vapor
import Crypto
import Foundation
enum ClientRoute {
    
    case submitRCL(blockchain:XRP)
    case submitETH(blockchain:ETH)
    case submitBTC(tx:String)

    func request() throws -> HTTPRequest {
        var httpReq = HTTPRequest()
        switch self {
            
            case .submitRCL(let blockchain):
                httpReq = HTTPRequest(method: .POST, url: RCL_URL_TEST)
                httpReq.body = HTTPBody(data: try blockchain.data())
                return httpReq
            case .submitETH(let blockchain):
                httpReq = HTTPRequest(method: .POST, url: "ETH_URL_Test\(try blockchain.endpoint())") 
                return httpReq       
            case .submitBTC(let tx):
                httpReq = HTTPRequest(method: .POST, url: BTC_URL_TEST)
                return httpReq    
        }
        
    }
}

enum XRP {
    case submitXRP(blob:String)
    case accountInfo(address:String)

    func data() throws -> Data {
        let encoder = JSONEncoder()
        switch self {
            case .submitXRP(let blob):
                let tx_blob = TX(tx_blob:blob)
                let data = try encoder.encode(tx_blob)
                return data
            case .accountInfo(let address):
                let account_info = Account_Info(address:address)
                let data = try encoder.encode(account_info)
                return data
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

