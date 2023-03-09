//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 09.03.23.
//

import SwiftUI



public struct ErrorLogView: View {
	public static var controller: UIViewController {
		UIHostingController(rootView: ErrorLogView())
	}
	
	@Environment(\.presentationMode) var presentationMode
	
	@State
	private var selectedDomain: String? = nil
	
	public var body: some View {
		NavigationView {
			List(items) { item in
				VStack(alignment: .leading, spacing: 4) {
					if selectedDomain == nil, let domain = item.domain {
						Text(domain)
							.font(.system(.subheadline, design: .rounded))
							.foregroundColor(.secondary)
							.frame(maxWidth: .infinity, alignment: .leading)
					}
					if let title = item.title {
						Text(title)
							.font(.system(.headline, design: .rounded))
							.foregroundColor(.primary)
							.frame(maxWidth: .infinity, alignment: .leading)
					}
					if let message = item.message {
						Text(message)
							.font(.subheadline)
							.foregroundColor(.primary)
							.frame(maxWidth: .infinity, alignment: .leading)
					}
				}
			}
			.navigationTitle(selectedDomain ?? "Alle Fehler")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItemGroup(placement: .navigationBarLeading) {
					if ErrorLog.shared.domains.count > 1 {
						Menu {
							Button {
								selectedDomain = nil
							} label: {
								Text("Alle Fehler")
							}
							Divider()
							ForEach(ErrorLog.shared.domains, id: \.self) { domain in
								Button {
									selectedDomain = domain
								} label: {
									Text(domain)
								}
							}
						} label: {
							Image(systemName: "square.on.square")
								.symbolRenderingMode(.hierarchical)
								.foregroundColor(.accentColor)
								.font(.headline.bold())
						}
					}
				}
				
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						presentationMode.wrappedValue.dismiss()
					} label: {
						Image(systemName: "xmark.circle.fill")
							.symbolRenderingMode(.hierarchical)
							.foregroundColor(.gray)
							.font(.title3.bold())
					}
				}
			}
		}
		.onAppear {
			let domains = ErrorLog.shared.domains
			if domains.count == 1, let domain = domains.first {
				selectedDomain = domain
			}
		}
	}
	
	var items: [ErrorLogItem] {
		let items = ErrorLog.shared.items.filter { $0.isEmpty == false }
		
		if let domain = selectedDomain {
			return items.filter { $0.domain == domain }
		} else {
			return items
		}
	}
}


struct ErrorLogView_Previews: PreviewProvider {
	static var previews: some View {
		ErrorLogView()
			.onAppear {
				previewData()
			}
	}
	
	static func previewData() {
		logError(title: "Fehler", message: "Dies ist ein Fehler")
	}
}


