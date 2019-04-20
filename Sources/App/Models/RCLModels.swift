import Vapor

struct TX:Content {
    var method = "submit"
    var params:[Blob]
}

struct Blob:Content {
    var tx_blob = ""
} 

struct Account_Info:Content {
    var method = "submit"
    var params:[Account]
}

struct Account:Content {
    var account = ""
    var ledger_index = "validated"
}


