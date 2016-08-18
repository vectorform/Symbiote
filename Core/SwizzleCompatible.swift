// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  SwizzleCompatible.swift
//
import UIKit

internal protocol SwizzleCompatible {
    static var SwizzleMethods: [Selector: Selector] { get }
}