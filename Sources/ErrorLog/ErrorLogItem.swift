//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 09.03.23.
//

import Foundation


struct ErrorLogItem: Identifiable {
	let id: UUID
	let title: String?
	let message: String?
	let domain: String?
	
	var isEmpty: Bool {
		title == nil && message == nil
	}
}
