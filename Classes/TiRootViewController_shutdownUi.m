//
//  TiRootViewController_shutdownUi.m
//  tiapprestart
//
//  Created by Dan Tamas on 15/03/2014.
//
//

#import "TiRootViewController_shutdownUi.h"

@implementation TiRootViewController (ShutdownUI)


-(void)shutdownUi:(id)arg
{
    //FIRST DISMISS ALL MODAL WINDOWS
    UIViewController* topVC = [self topPresentedController];
    if (topVC != self) {
        UIViewController* presenter = [topVC presentingViewController];
        [presenter dismissViewControllerAnimated:NO completion:^{
            [self shutdownUi:arg];
        }];
        return;
    }
    //At this point all modal stuff is done. Go ahead and clean up proxies.
    NSArray* modalCopy = [modalWindows copy];
    NSArray* windowCopy = [containedWindows copy];
    
    if(modalCopy != nil) {
        for (TiViewProxy* theWindow in [modalCopy reverseObjectEnumerator]) {
            [theWindow windowWillClose];
            [theWindow windowDidClose];
        }
        [modalCopy release];
    }
    if (windowCopy != nil) {
        for (TiViewProxy* theWindow in [windowCopy reverseObjectEnumerator]) {
            [theWindow windowWillClose];
            [theWindow windowDidClose];
        }
        [windowCopy release];
    }
    
    DebugLog(@"[INFO] UI SHUTDOWN COMPLETE. TRYING TO RESUME RESTART");
    if ([arg respondsToSelector:@selector(_resumeRestart:)]) {
        [arg performSelector:@selector(_resumeRestart:) withObject:nil];
    } else {
        DebugLog(@"[WARN] Could not resume. No selector _resumeRestart: found for arg");
    }
}

@end
