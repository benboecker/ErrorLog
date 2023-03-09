import Foundation



public class ErrorLog {
	
	internal static let shared = ErrorLog()
	internal var items: [ErrorLogItem] = []
    
    private init() { }
	
	public static var hasContent: Bool {
		!ErrorLog.shared.items.isEmpty
	}
}

public func logError(title: String? = nil, message: String? = nil, domain: String? = nil) {
	ErrorLog.shared.logError(title: title, message: message, domain: domain)
}

private extension ErrorLog {
	func logError(title: String?, message: String?, domain: String?) {
		items.append(
			ErrorLogItem(
				id: UUID(),
				title: title,
				message: message,
				domain: domain
			)
		)
	}
}

internal extension ErrorLog {
	var domains: [String] {
		let domains = items.compactMap(\.domain)
		return domains
			.removingDuplicates()
			.sorted()
	}
}

extension Sequence where Element: Hashable {
	func removingDuplicates() -> [Element] {
		var seen: Set<Iterator.Element> = []
		return filter { seen.insert($0).inserted }
	}
}
