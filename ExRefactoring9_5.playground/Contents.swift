import UIKit

enum Beer {
    case hoganda
    case hite
    case heineken
}

let beer = Beer.hite
var price = 0
var taxFee = 0
var premium = false

protocol Beerable {
    var price: Int { get }
    var taxFee: Int { get }
    var premium: Bool { get }
    var total: Int { get }
    
    init?(beer: Beer)
    init?(beer: Beer, premium: Bool)
}

extension Beerable {
    var premium: Bool { false }
    var total: Int { price + taxFee }
    
    init?(beer: Beer) { nil }
    init?(beer: Beer, premium: Bool) { nil }
}

struct Hoganda: Beerable {
    let price = 1000
    let taxFee = 300
    
    init?(beer: Beer) {
        guard beer == .hoganda else { return nil }
        print("this is Hoganda")
    }
}

struct Hite: Beerable {
    let price = 500
    let taxFee = 0
    
    init?(beer: Beer) {
        guard beer == .hite else { return nil }
        print("this is Hite")
    }
}

struct Heineken: Beerable {
    let price = 2000
    let premium: Bool
    var taxFee: Int {
        premium ? 1000 : 500
    }
    
    init?(beer: Beer, premium: Bool) {
        guard beer == .heineken else { return nil }
        self.premium = premium
        print("this is Heineken")
    }
}

enum BeerBuilder {
    static func createBeer(beer: Beer, premium: Bool = false) -> Beerable? {
        switch beer {
        case .hoganda:
            return Hoganda(beer: beer)
        case .hite:
            return Hite(beer: beer)
        case .heineken:
            return Heineken(beer: beer, premium: premium)
        default:
            return nil
        }
    }
}

let resultBeer = BeerBuilder.createBeer(beer: beer, premium: premium)
print(resultBeer?.total) // 500
