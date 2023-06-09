/**
 * This code was GENERATED using the solita package.
 * Please DO NOT EDIT THIS FILE, instead rerun solita to update it or write a wrapper to add functionality.
 *
 * See: https://github.com/metaplex-foundation/solita-swift
 */
import Foundation

public enum gpl_sessionError: String, Error {
    /**
 * ValidityTooLong: '0x1770'
 *
 * @category Errors
 * @category generated
 */
    case validityTooLongError = "0x1770"

    public var code: String? { self.rawValue }
}

extension gpl_sessionError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            /**
 * ValidityTooLong: 'Requested validity is too long'
 *
 * @category Errors
 * @category generated
 */
    case .validityTooLongError: return "Requested validity is too long"
        }
    }
}