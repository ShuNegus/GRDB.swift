/// An instance of WALSnapshot records the state of a WAL mode database for some
/// specific point in history.
///
/// We use `WALSnapshot` to help `ValueObservation` check for changes
/// that would happen between the initial fetch, and the start of the
/// actual observation. This class has no other purpose, and is not intended to
/// become public.
///
/// It does not work with SQLCipher, because SQLCipher does not support
/// `SQLITE_ENABLE_SNAPSHOT` correctly: we have linker errors.
/// See <https://github.com/ericsink/SQLitePCL.raw/issues/452>.
///
/// With custom SQLite builds, it only works if `SQLITE_ENABLE_SNAPSHOT`
/// is defined.
///
/// With system SQLite, it can only work when the SDK exposes the C apis and
/// their availability, which means XCode 14 (identified with Swift 5.7).
///
/// Yes, this is an awfully complex logic.
///
/// See <https://www.sqlite.org/c3ref/snapshot.html>.
final class WALSnapshot: Sendable {
    // Xcode 14 (Swift 5.7) ships with a macOS SDK that misses snapshot support.
    // Xcode 14.1 (Swift 5.7.1) ships with a macOS SDK that has snapshot support.
    // This is the meaning of (compiler(>=5.7.1) || !(os(macOS) || targetEnvironment(macCatalyst)))
    // swiftlint:disable:next line_length
    static let available = false

    init(_ db: Database) throws {
        throw DatabaseError(resultCode: .SQLITE_MISUSE, message: "snapshots are not available")
    }

    func compare(_ other: WALSnapshot) -> CInt {
        preconditionFailure("snapshots are not available")
    }
}
