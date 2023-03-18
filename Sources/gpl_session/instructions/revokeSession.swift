/**
 * This code was GENERATED using the solita package.
 * Please DO NOT EDIT THIS FILE, instead rerun solita to update it or write a wrapper to add functionality.
 *
 * See: https://github.com/metaplex-foundation/solita-swift
 */
import Foundation
import Beet
import Solana

/**
 * @category Instructions
 * @category RevokeSession
 * @category generated
 */
public struct RevokeSessionInstructionArgs{
    let instructionDiscriminator: [UInt8] /* size: 8 */
    

    public init(
        instructionDiscriminator: [UInt8] /* size: 8 */ = revokeSessionInstructionDiscriminator
    ) {
        self.instructionDiscriminator = instructionDiscriminator
    }
}
/**
 * @category Instructions
 * @category RevokeSession
 * @category generated
 */
public let revokeSessionStruct = FixableBeetArgsStruct<RevokeSessionInstructionArgs>(
    fields: [
        ("instructionDiscriminator", Beet.fixedBeet(.init(value: .collection(UniformFixedSizeArray<UInt8>(element: .init(value: .scalar(u8())), len: 8))))),
        
    ],
    description: "RevokeSessionInstructionArgs"
)
/**
* Accounts required by the _revokeSession_ instruction
*
* @property [_writable_] sessionToken  
* @property [_writable_] authority   
* @category Instructions
* @category RevokeSession
* @category generated
*/
public struct RevokeSessionInstructionAccounts {
    let sessionToken: PublicKey
    let authority: PublicKey
    let systemProgram: PublicKey?

    public init(
        sessionToken: PublicKey,
        authority: PublicKey,
        systemProgram: PublicKey? = nil
    ) {
        self.sessionToken = sessionToken
        self.authority = authority
        self.systemProgram = systemProgram
    }
}

public let revokeSessionInstructionDiscriminator = [86, 92, 198, 120, 144, 2, 7, 194] as [UInt8]

/**
* Creates a _RevokeSession_ instruction.
*
* @param accounts that will be accessed while the instruction is processed
* @category Instructions
* @category RevokeSession
* @category generated
*/
public func createRevokeSessionInstruction(accounts: RevokeSessionInstructionAccounts, 
programId: PublicKey=PublicKey(string: "3ao63wcSRNa76bncC2M3KupNtXBFiDyNbgK52VG7dLaE")!) -> TransactionInstruction {

    let data = revokeSessionStruct.serialize(
            instance: ["instructionDiscriminator": revokeSessionInstructionDiscriminator ])

    let keys: [AccountMeta] = [
        AccountMeta(
            publicKey: accounts.sessionToken,
            isSigner: false,
            isWritable: true
        ),
        AccountMeta(
            publicKey: accounts.authority,
            isSigner: false,
            isWritable: true
        ),
        AccountMeta(
            publicKey: accounts.systemProgram ?? PublicKey.systemProgramId,
            isSigner: false,
            isWritable: false
        )
    ]

    let ix = TransactionInstruction(
                keys: keys,
                programId: programId,
                data: data.0.bytes
            )
    return ix
}