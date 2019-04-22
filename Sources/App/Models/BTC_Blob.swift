import Vapor

struct BTC_Blob:Content {
    var tx:String

    init(tx:String){
        self.tx = tx
    }
}