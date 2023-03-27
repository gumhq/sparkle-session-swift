// Code from https://github.com/metaplex-foundation/Solana.Swift/blob/master/Tests/SolanaTests/InMemoryAccountStorage.swift

import Foundation
import Solana

enum TestsWallet {
    case mainnetBeta
    case devnet
    case getWallets

    var testAccount: String {
        switch self {
        case .mainnetBeta:
            return "promote ignore inmate coast excess candy vanish erosion palm oxygen build powder"
        case .devnet:
            return "siege amazing camp income refuse struggle feed kingdom lawn champion velvet crystal stomach trend hen uncover roast nasty until hidden crumble city bag minute"
        case .getWallets:
            return "hint begin crowd dolphin drive render finger above sponsor prize runway invest dizzy pony bitter trial ignore crop please industry hockey wire use side"
        }
    }
}

class InMemoryAccountStorage: SolanaAccountStorage {
    private var _signer: Account?
    func save(_ signer: Account) -> Result<Void, Error> {
        _signer = signer
        return .success(())
    }

    var account: Result<Account, Error> {
        if let account = _signer {
            return .success(account)
        }
        return .failure(SolanaError.unauthorized)
    }

    func clear() -> Result<Void, Error> {
        _signer = nil
        return .success(())
    }
}
