//
//  AppDelegate.swift
//  Aware
//
//  Created by Andrzej Spiess on 07/02/16.
//  Copyright © 2016 Andrzej Spiess. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    struct Consts {
        static let JetBrainsFnScriptName = "jetBrainsFn"
        static let NormalFnScriptName = "normalFn"
        static let AppleScriptExtenstion = "scpt"
        static let JetBrainsRunningApplicationPartId = "jetbrains"
        static let SystemPrefsApplicationBundleId = "com.apple.systempreferences"
    }
    
    @IBOutlet weak var window: NSWindow!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.setupAppActivityObserver()
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        self.removeAppActivityObserver()
    }
    
    func appActivated(not: NSNotification) -> Void {
        
        // Checking state in applescripts before setting fn state becasue it could be set to the same state as of now so it would be
        // a waste of time, cpu cycles and memory.
        
        if isActiveApplication(not, bundleId: Consts.SystemPrefsApplicationBundleId) {
            return
        } else if isActiveApplication(not, bundleId: Consts.JetBrainsRunningApplicationPartId) {
            // Execute script for jetbrains case.
            self.executeAppleScript(Consts.JetBrainsFnScriptName)
        } else {
            
            // Execute script for normal case which for me is using f keys as media keys.
            self.executeAppleScript(Consts.NormalFnScriptName)
        }
    }
    
    func isActiveApplication(not: NSNotification, bundleId: String) -> Bool {
        
        if let activeApplicationBundleId = not.userInfo?[NSWorkspaceApplicationKey] as? NSRunningApplication where (activeApplicationBundleId.bundleIdentifier!.rangeOfString(bundleId) != nil) {
                return true
        } else {
            return false
        }
    }
}

// MARK: Observing app activity

extension AppDelegate {
    
    func setupAppActivityObserver() -> Void {
        NSWorkspace.sharedWorkspace().notificationCenter.addObserver(self, selector: Selector("appActivated:"), name: NSWorkspaceDidActivateApplicationNotification, object: nil)
    }
    
    func removeAppActivityObserver() -> Void {
        NSWorkspace.sharedWorkspace().notificationCenter.removeObserver(self)
    }
}

// MARK: AppleScript

extension AppDelegate {
    
    func executeAppleScript(scriptName: String) -> Void {
        
        if let path = NSBundle.mainBundle().pathForResource(scriptName, ofType: Consts.AppleScriptExtenstion),
            let scriptURL = Optional.Some(NSURL(fileURLWithPath: path)),
            let script = NSAppleScript(contentsOfURL: scriptURL, error: nil) {
                script.executeAndReturnError(nil)
        }
    }
}

// Does not work but should
//CFPreferencesSetAppValue("fnState", kCFBooleanTrue, "com.apple.keyboard");
//CFPreferencesAppSynchronize("com.apple.keyboard");

