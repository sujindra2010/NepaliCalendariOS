#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SHBaseView.h"
#import "SHViewPager.h"
#import "SHViewPagerController.h"
#import "SHViewPagerDataSource.h"
#import "SHViewPagerDelegate.h"
#import "SHViewPagerModule.h"

FOUNDATION_EXPORT double SHViewPagerVersionNumber;
FOUNDATION_EXPORT const unsigned char SHViewPagerVersionString[];

