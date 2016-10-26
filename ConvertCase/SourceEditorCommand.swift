//
//  SourceEditorCommand.swift
//  ConvertCase
//
//  Created by Tuan Truong on 10/26/16.
//  Copyright © 2016 Tuan Truong. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        guard let textRange = invocation.buffer.selections.firstObject as? XCSourceTextRange,
            invocation.buffer.lines.count > 0 else {
                completionHandler(nil)
                return
        }
        
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            completionHandler(nil)
            return
        }
        
        let upperCaseIdentifier = bundleIdentifier + ".UpperCase"
        let lowerCaseIdentifier = bundleIdentifier + ".LowerCase"
        
        // Switch all different commands id based which defined in Info.plist
        switch invocation.commandIdentifier {
        case upperCaseIdentifier:
            for lineIndex in textRange.start.line...textRange.end.line {
                let line = invocation.buffer.lines[lineIndex] as! NSString
                invocation.buffer.lines[lineIndex] = line.uppercased
            }
        case lowerCaseIdentifier:
            for lineIndex in textRange.start.line...textRange.end.line {
                let line = invocation.buffer.lines[lineIndex] as! NSString
                invocation.buffer.lines[lineIndex] = line.lowercased
            }
        default:
            break
        }
        
        completionHandler(nil)
    }
}
