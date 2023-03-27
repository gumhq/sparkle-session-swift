import Foundation
@testable import GplSession
import Solana
import TweetNacl
import XCTest

extension HotAccount {
    static func generate() -> HotAccount {
        let keypair = try? NaclSign.KeyPair.keyPair()

        // TODO: Rewrite in such a that it doesn't crash if keypair is nil
        return HotAccount(
            secretKey: keypair!.secretKey
        )!
    }
}

class SessionsInitTest: XCTestCase {
    /* var endpoint = RPCEndpoint.devnetSolana */
    var endpoint = RPCEndpoint(url: URL(string: "http://127.0.0.1:8899")!, urlWebSocket: URL(string: "ws://127.0.0.1:8900")!, network: Network.devnet)

    var solana: Solana!

    var signer: Account!

    override func setUpWithError() throws {
        solana = Solana(router: NetworkingRouter(endpoint: endpoint))
        signer = HotAccount.generate()
    }

    func testInit() async {
        /* let session = Session() */
        print("Publickey: \(signer.publicKey)")

        let airdropSig = try? await solana.api.requestAirdrop(account: signer.publicKey.base58EncodedString, lamports: 1_000_000_000, commitment: .processed)

        print("AirdropSig: \(airdropSig!)")

        // Get the balance and verify that the airdrop actually worked

        /* let balance = try? await solana.api.getBalance(account: signer.publicKey.base58EncodedString, commitment: .processed) */

        /* print("Balance: \(balance!)") */

        /*  CreateSessionInstructionArgs */
        let sessionArgs = CreateSessionInstructionArgs(
            topUp: true,
            /*      1 hour */
            validUntil: Int64(Date().timeIntervalSince1970) + 60 * 60
        )

        let sessionTokenPrefix = "session"

        let sessionSigner = signer.publicKey

        let authority = signer.publicKey

        let targetProgram = PublicKey(string: "3ao63wcSRNa76bncC2M3KupNtXBFiDyNbgK52VG7dLaE")!

        /*  Derive sessionToken PDA */
        let sessionToken = try? PublicKey.findProgramAddress(
            seeds: [sessionTokenPrefix.data(using: .utf8)!, targetProgram.data, sessionSigner.data, authority.data],
            programId: PROGRAM_ID!
        ).map { $0.0 }.get()

        print("SessionToken: \(sessionToken!)")

        let sessionAccounts = CreateSessionInstructionAccounts(
            sessionToken: sessionToken!,
            sessionSigner: sessionSigner,
            authority: authority,
            targetProgram: targetProgram
        )

        print("CreateSessionInstructionAccounts: \(sessionAccounts)")

        let createSessionInstruction = createCreateSessionInstruction(accounts: sessionAccounts, args: sessionArgs)

        print("CreateSessionInstruction: \(createSessionInstruction)")

        var transaction = Transaction(
            feePayer: signer.publicKey,
            instructions: [createSessionInstruction],
            recentBlockhash: try! await solana.api.getRecentBlockhash()
        )

        print("Transaction: \(transaction)")

        /*  sign and send transaction */
        switch transaction.sign(signers: [signer]) {
        case .success:
            print("Transaction signed")
            if case let .success(serializedTransaction) = try? transaction.serialize() {
                print("Transaction serialized")
                print("SerializedTransaction: \(serializedTransaction)")
                let signature = try! await solana.api.sendTransaction(serializedTransaction: serializedTransaction.base64EncodedString())
                print("Signature: \(signature)")
            }
        case let .failure(error):
            print("Transaction signing failed: \(error)")
        }

        XCTAssertNotNil("")
    }
}
