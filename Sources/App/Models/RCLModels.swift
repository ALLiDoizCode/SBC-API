import Vapor

struct TX:Content {
    var method = "submit"
    var params:[Blob] = []
    init(tx_blob:String) {
        let blob = Blob(tx_blob:tx_blob)
        params.append(blob)
    }
}

struct Blob:Content {
    var tx_blob = ""
    init(tx_blob:String) {
        self.tx_blob = tx_blob
    }
} 

struct Account_Info:Content {
    var method = "account_info"
    var params:[Account] = []

    init(address:String) {
        let account = Account(address:address)
        params.append(account)
    }
}

struct Account:Content {
    var account = ""
    var ledger_index = "validated"

    init(address:String) {
        self.account = address
    }
}


