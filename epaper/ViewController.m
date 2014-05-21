//
//  ViewController.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-12.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*mport "TapDetectingImageView.h"
 
 #define ZOOM_STEP 2.0
 @interface myView (UtilityMethods)
 - (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
 @end
 
 
 @implementation myView
 @synthesize imageScrollView, imageView;
 
 
 - (void)viewDidLoad
 {
 2014-03-28 15:57:17.840 epaper[1274:70b] get new data from http://epaper.pages.dushi.ca/pubissue.xml
 2014-03-28 15:57:18.083 epaper[1274:70b] File File 1: 0065_ccp
 2014-03-28 15:57:18.084 epaper[1274:70b] File File File 1: CPG20140206A01-PREVIEW.jpg
 2014-03-28 15:57:18.084 epaper[1274:70b] File File File 2: CPG20140213A01-PREVIEW.jpg
 2014-03-28 15:57:18.085 epaper[1274:70b] File File File 3: CPG20140220A01-PREVIEW.jpg
 2014-03-28 15:57:18.085 epaper[1274:70b] File File File 4: CPG20140227A01-PREVIEW.jpg
 2014-03-28 15:57:18.085 epaper[1274:70b] File File File 5: CPG20140306A01-PREVIEW.jpg
 2014-03-28 15:57:18.085 epaper[1274:70b] File File File 6: CPG20140313A01-PREVIEW.jpg
 2014-03-28 15:57:18.086 epaper[1274:70b] File File File 7: CPG20140320A01-PREVIEW.jpg
 2014-03-28 15:57:18.086 epaper[1274:70b] File File 2: 0082_ccr
 2014-03-28 15:57:18.086 epaper[1274:70b] File File File 1: CCP20140207A01-PREVIEW.jpg
 2014-03-28 15:57:18.087 epaper[1274:70b] File File File 2: CCP20140214A01-PREVIEW.jpg
 2014-03-28 15:57:18.087 epaper[1274:70b] File File File 3: CCP20140221A01-PREVIEW.jpg
 2014-03-28 15:57:18.087 epaper[1274:70b] File File File 4: CCP20140228A01-PREVIEW.jpg
 2014-03-28 15:57:18.087 epaper[1274:70b] File File File 5: CCP20140307A01-PREVIEW.jpg
 2014-03-28 15:57:18.088 epaper[1274:70b] File File File 6: CCP20140314A01-PREVIEW.jpg
 2014-03-28 15:57:18.088 epaper[1274:70b] File File File 7: CCP20140321A01-PREVIEW.jpg
 2014-03-28 15:57:18.088 epaper[1274:70b] File 1: 0065_ccp
 2014-03-28 15:57:18.089 epaper[1274:70b] File File 1: 20021104
 2014-03-28 15:57:18.089 epaper[1274:70b] File File 2: 20021105
 2014-03-28 15:57:18.089 epaper[1274:70b] File File 3: 20021107
 2014-03-28 15:57:18.090 epaper[1274:70b] File 2: 0082_ccr
 2014-03-28 15:57:18.090 epaper[1274:70b] File 3: pubissue.xml
 2014-03-28 15:57:18.090 epaper[1274:70b] File 4: thumbnail
 2014-03-28 15:57:18.091 epaper[1274:70b] pubNew {
 "0065_ccp/20021105" = new;
 "0065_ccp/20021107" = new;
 "0082_ccr/20000319" = new;
 "0082_ccr/20000320" = new;
 }
 2014-03-28 15:57:18.091 epaper[1274:70b] pubFavor {
 "0065_ccp/20021104" = favor;
 "0065_ccp/20021105" = favor;
 "0065_ccp/20021107" = favor;
 }
 2014-03-28 15:57:18.091 epaper[1274:70b] pubPre {
 "0065_ccp/20021107" = pre;
 }
 2014-03-28 15:57:19.714 epaper[1274:70b] downloadTask can get called
 2014-03-28 15:57:19.715 epaper[1274:70b] background downlaod begin,wait....
 2014-03-28 15:57:22.990 epaper[1274:70b] downloadTask can get called
 2014-03-28 15:57:22.990 epaper[1274:70b] background downlaod begin,wait....
 2014-03-28 15:57:22.998 epaper[1274:70b] father drawLayout
 2014-03-28 16:02:46.348 epaper[1274:1303] thumbnail/0065_ccp/0065_ccp_20021107.zip is finished in file:///Users/legogreen2/Library/Application%20Support/iPhone%20Simulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Library/Caches/com.apple.nsnetworkd/CFNetworkDownload_ppERCt.tmp
 2014-03-28 16:02:46.435 epaper[1274:1303] thumbnail/0065_ccp/0065_ccp_20021107.zip has been downloaded
 2014-03-28 16:02:46.436 epaper[1274:1303] There is no old file to delete
 2014-03-28 16:02:46.436 epaper[1274:1303] write zip to local from cache0
 2014-03-28 16:02:46.436 epaper[1274:1303] write zip to local from cache0 0 file:///Users/legogreen2/Library/Application               錼Ǝވ̀ƚupport/iPhone  걐ࣚ댶什ࣙ什ࣙⲸ뀉才什ࣙ댶걐ࣚimulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Library/Caches/com.apple.nsnetworkd/CFNetworkDownload_ppERCt.tmp 0 file:///Users/legogreen2/Library/Application              쒃帄썝Ἇupport/iPhone               錼Ǝވ̀ƚimulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Documents/thumbnail/0065_ccp/0065_ccp_20021107.zip
 2014-03-28 16:02:48.987 epaper[1274:1303] file copy success
 2014-03-28 16:02:48.987 epaper[1274:1303] write zip to local from cache
 2014-03-28 16:02:48.987 epaper[1274:1303] zip from0
 2014-03-28 16:02:48.988 epaper[1274:1303] zip from /Users/legogreen2/Library/Application Support/iPhone Simulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Documents/thumbnail/0065_ccp/0065_ccp_20021107.zip to /Users/legogreen2/Library/Application Support/iPhone Simulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Documents/0065_ccp/20021107
 2014-03-28 16:02:55.406 epaper[1274:1303] zip success
 2014-03-28 16:02:55.407 epaper[1274:1303] LISTING ALL FILES FOUND
 2014-03-28 16:02:55.407 epaper[1274:1303] File 1: 0065_ccp20021107-ad.xml
 2014-03-28 16:02:55.407 epaper[1274:1303] File 2: 0065_ccp20021107-news.xml
 2014-03-28 16:02:55.408 epaper[1274:1303] File 3: 0065_ccp20021107-paper.xml
 2014-03-28 16:02:55.408 epaper[1274:1303] File 4: CPG20140320A01-Preview.jpg
 2014-03-28 16:02:55.408 epaper[1274:1303] File 5: CPG20140320A01-Preview.png
 2014-03-28 16:02:55.409 epaper[1274:1303] File 6: CPG20140320A02-Preview.jpg
 2014-03-28 16:02:55.409 epaper[1274:1303] File 7: CPG20140320A02-Preview.png
 2014-03-28 16:02:55.409 epaper[1274:1303] File 8: CPG20140320A03-Preview.jpg
 2014-03-28 16:02:55.409 epaper[1274:1303] File 9: CPG20140320A03-Preview.png
 2014-03-28 16:02:55.410 epaper[1274:1303] File 10: CPG20140320A04-Preview.jpg
 2014-03-28 16:02:55.410 epaper[1274:1303] File 11: CPG20140320A04-Preview.png
 2014-03-28 16:02:55.410 epaper[1274:1303] File 12: CPG20140320A05-Preview.jpg
 2014-03-28 16:02:55.411 epaper[1274:1303] File 13: CPG20140320A05-Preview.png
 2014-03-28 16:02:55.411 epaper[1274:1303] File 14: CPG20140320A06-Preview.jpg
 2014-03-28 16:02:55.411 epaper[1274:1303] File 15: CPG20140320A06-Preview.png
 2014-03-28 16:02:55.411 epaper[1274:1303] File 16: CPG20140320A07-Preview.jpg
 2014-03-28 16:02:55.412 epaper[1274:1303] File 17: CPG20140320A07-Preview.png
 2014-03-28 16:02:55.412 epaper[1274:1303] File 18: CPG20140320A08-Preview.jpg
 2014-03-28 16:02:55.412 epaper[1274:1303] File 19: CPG20140320A08-Preview.png
 2014-03-28 16:02:55.413 epaper[1274:1303] File 20: CPG20140320A09-Preview.jpg
 2014-03-28 16:02:55.413 epaper[1274:1303] File 21: CPG20140320A09-Preview.png
 2014-03-28 16:02:55.413 epaper[1274:1303] File 22: CPG20140320A10-Preview.jpg
 2014-03-28 16:02:55.413 epaper[1274:1303] File 23: CPG20140320A10-Preview.png
 2014-03-28 16:02:55.414 epaper[1274:1303] File 24: CPG20140320A11-Preview.jpg
 2014-03-28 16:02:55.414 epaper[1274:1303] File 25: CPG20140320A11-Preview.png
 2014-03-28 16:02:55.414 epaper[1274:1303] File 26: CPG20140320A12-Preview.jpg
 2014-03-28 16:02:55.415 epaper[1274:1303] File 27: CPG20140320A12-Preview.png
 2014-03-28 16:02:55.415 epaper[1274:1303] File 28: CPG20140320A13-Preview.jpg
 2014-03-28 16:02:55.415 epaper[1274:1303] File 29: CPG20140320A13-Preview.png
 2014-03-28 16:02:55.415 epaper[1274:1303] File 30: CPG20140320A14-Preview.jpg
 2014-03-28 16:02:55.416 epaper[1274:1303] File 31: CPG20140320A14-Preview.png
 2014-03-28 16:02:55.416 epaper[1274:1303] File 32: CPG20140320A15-Preview.jpg
 2014-03-28 16:02:55.416 epaper[1274:1303] File 33: CPG20140320A15-Preview.png
 2014-03-28 16:02:55.417 epaper[1274:1303] File 34: CPG20140320A16-Preview.jpg
 2014-03-28 16:02:55.417 epaper[1274:1303] File 35: CPG20140320A16-Preview.png
 2014-03-28 16:02:55.417 epaper[1274:1303] File 36: CPG20140320A17-Preview.jpg
 2014-03-28 16:02:55.417 epaper[1274:1303] File 37: CPG20140320A17-Preview.png
 2014-03-28 16:02:55.418 epaper[1274:1303] File 38: CPG20140320A18-Preview.jpg
 2014-03-28 16:02:55.418 epaper[1274:1303] File 39: CPG20140320A18-Preview.png
 2014-03-28 16:02:55.418 epaper[1274:1303] File 40: CPG20140320A19-Preview.jpg
 2014-03-28 16:02:55.418 epaper[1274:1303] File 41: CPG20140320A19-Preview.png
 2014-03-28 16:02:55.419 epaper[1274:1303] File 42: CPG20140320A20-Preview.jpg
 2014-03-28 16:02:55.419 epaper[1274:1303] File 43: CPG20140320A20-Preview.png
 2014-03-28 16:02:55.419 epaper[1274:1303] File 44: CPG20140320A21-Preview.jpg
 2014-03-28 16:02:55.420 epaper[1274:1303] File 45: CPG20140320A21-Preview.png
 2014-03-28 16:02:55.420 epaper[1274:1303] File 46: CPG20140320A22-Preview.jpg
 2014-03-28 16:02:55.420 epaper[1274:1303] File 47: CPG20140320A22-Preview.png
 2014-03-28 16:02:55.421 epaper[1274:1303] File 48: CPG20140320A23-Preview.jpg
 2014-03-28 16:02:55.421 epaper[1274:1303] File 49: CPG20140320A23-Preview.png
 2014-03-28 16:02:55.421 epaper[1274:1303] File 50: CPG20140320A24-Preview.jpg
 2014-03-28 16:02:55.421 epaper[1274:1303] File 51: CPG20140320A24-Preview.png
 2014-03-28 16:02:55.422 epaper[1274:1303] File 52: CPG20140320A25-Preview.jpg
 2014-03-28 16:02:55.422 epaper[1274:1303] File 53: CPG20140320A25-Preview.png
 2014-03-28 16:02:55.422 epaper[1274:1303] File 54: CPG20140320A26-Preview.jpg
 2014-03-28 16:02:55.422 epaper[1274:1303] File 55: CPG20140320A26-Preview.png
 2014-03-28 16:02:55.423 epaper[1274:1303] File 56: CPG20140320A27-Preview.jpg
 2014-03-28 16:02:55.423 epaper[1274:1303] File 57: CPG20140320A27-Preview.png
 2014-03-28 16:02:55.423 epaper[1274:1303] File 58: CPG20140320A28-Preview.jpg
 2014-03-28 16:02:55.424 epaper[1274:1303] File 59: CPG20140320A28-Preview.png
 2014-03-28 16:02:55.424 epaper[1274:1303] File 60: CPG20140320A29-Preview.jpg
 2014-03-28 16:02:55.424 epaper[1274:1303] File 61: CPG20140320A29-Preview.png
 2014-03-28 16:02:55.424 epaper[1274:1303] File 62: CPG20140320A30-Preview.jpg
 2014-03-28 16:02:55.425 epaper[1274:1303] File 63: CPG20140320A30-Preview.png
 2014-03-28 16:02:55.425 epaper[1274:1303] File 64: CPG20140320A31-Preview.jpg
 2014-03-28 16:02:55.425 epaper[1274:1303] File 65: CPG20140320A31-Preview.png
 2014-03-28 16:02:55.426 epaper[1274:1303] File 66: CPG20140320A32-Preview.jpg
 2014-03-28 16:02:55.426 epaper[1274:1303] File 67: CPG20140320A32-Preview.png
 2014-03-28 16:02:55.426 epaper[1274:1303] File 68: CPG20140320A33-Preview.jpg
 2014-03-28 16:02:55.426 epaper[1274:1303] File 69: CPG20140320A33-Preview.png
 2014-03-28 16:02:55.427 epaper[1274:1303] File 70: CPG20140320A34-Preview.jpg
 2014-03-28 16:02:55.427 epaper[1274:1303] File 71: CPG20140320A34-Preview.png
 2014-03-28 16:02:55.427 epaper[1274:1303] File 72: CPG20140320A35-Preview.jpg
 2014-03-28 16:02:55.428 epaper[1274:1303] File 73: CPG20140320A35-Preview.png
 2014-03-28 16:02:55.428 epaper[1274:1303] File 74: CPG20140320A36-Preview.jpg
 2014-03-28 16:02:55.428 epaper[1274:1303] File 75: CPG20140320A36-Preview.png
 2014-03-28 16:02:55.428 epaper[1274:1303] File 76: CPG20140320A37-Preview.jpg
 2014-03-28 16:02:55.429 epaper[1274:1303] File 77: CPG20140320A37-Preview.png
 2014-03-28 16:02:55.429 epaper[1274:1303] File 78: CPG20140320A38-Preview.jpg
 2014-03-28 16:02:55.429 epaper[1274:1303] File 79: CPG20140320A38-Preview.png
 2014-03-28 16:02:55.430 epaper[1274:1303] File 80: CPG20140320A39-Preview.jpg
 2014-03-28 16:02:55.430 epaper[1274:1303] File 81: CPG20140320A39-Preview.png
 2014-03-28 16:02:55.430 epaper[1274:1303] File 82: CPG20140320A40-Preview.jpg
 2014-03-28 16:02:55.430 epaper[1274:1303] File 83: CPG20140320A40-Preview.png
 2014-03-28 16:02:55.431 epaper[1274:1303] File 84: CPG20140320A41-Preview.jpg
 2014-03-28 16:02:55.431 epaper[1274:1303] File 85: CPG20140320A41-Preview.png
 2014-03-28 16:02:55.431 epaper[1274:1303] File 86: CPG20140320A42-Preview.jpg
 2014-03-28 16:02:55.431 epaper[1274:1303] File 87: CPG20140320A42-Preview.png
 2014-03-28 16:02:55.432 epaper[1274:1303] File 88: CPG20140320A43-Preview.jpg
 2014-03-28 16:02:55.432 epaper[1274:1303] File 89: CPG20140320A43-Preview.png
 2014-03-28 16:02:55.432 epaper[1274:1303] File 90: CPG20140320A44-Preview.jpg
 2014-03-28 16:02:55.433 epaper[1274:1303] File 91: CPG20140320A44-Preview.png
 2014-03-28 16:02:55.433 epaper[1274:1303] File 92: CPG20140320A45-Preview.jpg
 2014-03-28 16:02:55.433 epaper[1274:1303] File 93: CPG20140320A45-Preview.png
 2014-03-28 16:02:55.434 epaper[1274:1303] File 94: CPG20140320A46-Preview.jpg
 2014-03-28 16:02:55.434 epaper[1274:1303] File 95: CPG20140320A46-Preview.png
 2014-03-28 16:02:55.434 epaper[1274:1303] File 96: CPG20140320A47-Preview.jpg
 2014-03-28 16:02:55.434 epaper[1274:1303] File 97: CPG20140320A47-Preview.png
 2014-03-28 16:02:55.435 epaper[1274:1303] File 98: CPG20140320A48-Preview.jpg
 2014-03-28 16:02:55.435 epaper[1274:1303] File 99: CPG20140320A48-Preview.png
 2014-03-28 16:02:55.435 epaper[1274:1303] File 100: CPG20140320A49-Preview.jpg
 2014-03-28 16:02:55.435 epaper[1274:1303] File 101: CPG20140320A49-Preview.png
 2014-03-28 16:02:55.436 epaper[1274:1303] File 102: CPG20140320A50-Preview.jpg
 2014-03-28 16:02:55.436 epaper[1274:1303] File 103: CPG20140320A50-Preview.png
 2014-03-28 16:02:55.436 epaper[1274:1303] File 104: CPG20140320A51-Preview.jpg
 2014-03-28 16:02:55.437 epaper[1274:1303] File 105: CPG20140320A51-Preview.png
 2014-03-28 16:02:55.437 epaper[1274:1303] File 106: CPG20140320A52-Preview.jpg
 2014-03-28 16:02:55.437 epaper[1274:1303] File 107: CPG20140320A52-Preview.png
 2014-03-28 16:02:55.437 epaper[1274:1303] File 108: CPG20140320A53-Preview.jpg
 2014-03-28 16:02:55.438 epaper[1274:1303] File 109: CPG20140320A53-Preview.png
 2014-03-28 16:02:55.438 epaper[1274:1303] File 110: CPG20140320A54-Preview.jpg
 2014-03-28 16:02:55.438 epaper[1274:1303] File 111: CPG20140320A54-Preview.png
 2014-03-28 16:02:55.439 epaper[1274:1303] File 112: CPG20140320A55-Preview.jpg
 2014-03-28 16:02:55.439 epaper[1274:1303] File 113: CPG20140320A55-Preview.png
 2014-03-28 16:02:55.439 epaper[1274:1303] File 114: CPG20140320A56-Preview.jpg
 2014-03-28 16:02:55.440 epaper[1274:1303] File 115: CPG20140320A56-Preview.png
 2014-03-28 16:02:55.440 epaper[1274:1303] File 116: CPG20140320A57-Preview.jpg
 2014-03-28 16:02:55.440 epaper[1274:1303] File 117: CPG20140320A57-Preview.png
 2014-03-28 16:02:55.440 epaper[1274:1303] File 118: CPG20140320A58-Preview.jpg
 2014-03-28 16:02:55.441 epaper[1274:1303] File 119: CPG20140320A58-Preview.png
 2014-03-28 16:02:55.441 epaper[1274:1303] File 120: CPG20140320A59-Preview.jpg
 2014-03-28 16:02:55.441 epaper[1274:1303] File 121: CPG20140320A59-Preview.png
 2014-03-28 16:02:55.441 epaper[1274:1303] File 122: CPG20140320A60-Preview.jpg
 2014-03-28 16:02:55.442 epaper[1274:1303] File 123: CPG20140320A60-Preview.png
 2014-03-28 16:02:55.442 epaper[1274:1303] File 124: CPG20140320A61-Preview.jpg
 2014-03-28 16:02:55.442 epaper[1274:1303] File 125: CPG20140320A61-Preview.png
 2014-03-28 16:02:55.443 epaper[1274:1303] File 126: CPG20140320A62-Preview.jpg
 2014-03-28 16:02:55.443 epaper[1274:1303] File 127: CPG20140320A62-Preview.png
 2014-03-28 16:02:55.443 epaper[1274:1303] File 128: CPG20140320A63-Preview.jpg
 2014-03-28 16:02:55.444 epaper[1274:1303] File 129: CPG20140320A63-Preview.png
 2014-03-28 16:02:55.444 epaper[1274:1303] File 130: CPG20140320A64-Preview.jpg
 2014-03-28 16:02:55.444 epaper[1274:1303] File 131: CPG20140320A64-Preview.png
 2014-03-28 16:02:55.444 epaper[1274:1303] File 132: CPG20140320A65-Preview.jpg
 2014-03-28 16:02:55.445 epaper[1274:1303] File 133: CPG20140320A65-Preview.png
 2014-03-28 16:02:55.445 epaper[1274:1303] File 134: CPG20140320A66-Preview.jpg
 2014-03-28 16:02:55.445 epaper[1274:1303] File 135: CPG20140320A66-Preview.png
 2014-03-28 16:02:55.446 epaper[1274:1303] File 136: CPG20140320A67-Preview.jpg
 2014-03-28 16:02:55.446 epaper[1274:1303] File 137: CPG20140320A67-Preview.png
 2014-03-28 16:02:55.446 epaper[1274:1303] File 138: CPG20140320A68-Preview.jpg
 2014-03-28 16:02:55.446 epaper[1274:1303] File 139: CPG20140320A68-Preview.png
 2014-03-28 16:02:55.447 epaper[1274:1303] File 140: CPG20140320A69-Preview.jpg
 2014-03-28 16:02:55.447 epaper[1274:1303] File 141: CPG20140320A69-Preview.png
 2014-03-28 16:02:55.447 epaper[1274:1303] File 142: CPG20140320A70-Preview.jpg
 2014-03-28 16:02:55.448 epaper[1274:1303] File 143: CPG20140320A70-Preview.png
 2014-03-28 16:02:55.448 epaper[1274:1303] File 144: CPG20140320A71-Preview.jpg
 2014-03-28 16:02:55.448 epaper[1274:1303] File 145: CPG20140320A71-Preview.png
 2014-03-28 16:02:55.448 epaper[1274:1303] File 146: CPG20140320A72-Preview.jpg
 2014-03-28 16:02:55.449 epaper[1274:1303] File 147: CPG20140320A72-Preview.png
 2014-03-28 16:02:55.449 epaper[1274:1303] File 148: Favor
 2014-03-28 16:02:55.449 epaper[1274:1303] File 149: HouseAd
 2014-03-28 16:02:55.450 epaper[1274:1303] File 150: pre
 2014-03-28 16:02:55.456 epaper[1274:1303] delete file success
 2014-03-28 16:02:55.456 epaper[1274:1303] delete zip file thumbnail/0065_ccp/0065_ccp_20021107.zip after unzip
 2014-03-28 16:03:10.731 epaper[1274:70b] father drawLayout
 2014-03-28 16:03:10.774 epaper[1274:70b] code 0065_ccp date 20021103
 2014-03-28 16:03:10.776 epaper[1274:70b] code 0065_ccp date 20021102
 2014-03-28 16:03:10.777 epaper[1274:70b] code 0065_ccp date 20021101
 2014-03-28 16:03:10.779 epaper[1274:70b] code 0065_ccp date 20021031
 2014-03-28 16:03:10.780 epaper[1274:70b] code 0065_ccp date 20021107
 2014-03-28 16:03:10.781 epaper[1274:70b] code 0065_ccp date 20021105
 2014-03-28 16:03:10.783 epaper[1274:70b] code 0065_ccp date 20021104
 2014-03-28 16:03:21.213 epaper[1274:70b] {
 height = "13.5";
 unit = inch;
 width = "10.3";
 }
 2014-03-28 16:03:21.233 epaper[1274:70b] father drawLayout
 2014-03-28 16:03:24.442 epaper[1274:70b] father drawLayout
 2014-03-28 16:03:24.962 epaper[1274:70b] thread got cancelled
 2014-03-28 16:03:25.363 epaper[1274:70b] {
 height = "13.5";
 unit = inch;
 width = "10.3";
 }
 2014-03-28 16:03:25.474 epaper[1274:70b] father drawLayout
 2014-03-28 16:03:25.589 epaper[1274:1303] get new data from http://epaper.pages.dushi.ca/0065_ccp/20021105/CPG20140313A05-PREVIEW.png
 2014-03-28 16:03:26.024 epaper[1274:1303] get new data from http://epaper.pages.dushi.ca/0065_ccp/20021105/CPG20140313A05-PREVIEW.jpg
 2014-03-28 16:03:30.034 epaper[1274:70b] father drawLayout
 2014-03-28 16:03:30.555 epaper[1274:70b] thread got cancelled
 2014-03-28 16:03:31.483 epaper[1274:70b] {
 height = "13.5";
 unit = inch;
 width = "10.3";
 }
 2014-03-28 16:03:31.542 epaper[1274:70b] father drawLayout
 2014-03-28 16:03:31.959 epaper[1274:5e03] get new data from http://epaper.pages.dushi.ca/0065_ccp/20021104/CPG20140306A12-PREVIEW.png
 2014-03-28 16:03:32.312 epaper[1274:5e03] get new data from http://epaper.pages.dushi.ca/0065_ccp/20021104/CPG20140306A12-PREVIEW.jpg
 2014-03-28 16:03:35.538 epaper[1274:70b] father drawLayout
 2014-03-28 16:03:36.061 epaper[1274:70b] thread got cancelled
 2014-03-28 16:03:36.218 epaper[1274:70b] father drawLayout
 2014-03-28 16:03:37.202 epaper[1274:70b] father drawLayout
 2014-03-28 16:03:37.205 epaper[1274:70b] code 0065_ccp date 20021103
 2014-03-28 16:03:37.206 epaper[1274:70b] code 0065_ccp date 20021102
 2014-03-28 16:03:37.207 epaper[1274:70b] code 0065_ccp date 20021101
 2014-03-28 16:03:37.209 epaper[1274:70b] code 0065_ccp date 20021031
 2014-03-28 16:03:37.212 epaper[1274:70b] code 0065_ccp date 20021107
 2014-03-28 16:03:37.213 epaper[1274:70b] code 0065_ccp date 20021105
 2014-03-28 16:03:37.214 epaper[1274:70b] code 0065_ccp date 20021104
 2014-03-28 16:04:40.306 epaper[1274:5e03] thumbnail/0065_ccp/0065_ccp_20021107.zip is finished in file:///Users/legogreen2/Library/Application%20Support/iPhone%20Simulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Library/Caches/com.apple.nsnetworkd/CFNetworkDownload_acMxIr.tmp
 2014-03-28 16:04:40.398 epaper[1274:5e03] thumbnail/0065_ccp/0065_ccp_20021107.zip has been downloaded
 2014-03-28 16:04:40.398 epaper[1274:5e03] There is no old file to delete
 2014-03-28 16:04:40.399 epaper[1274:5e03] write zip to local from cache0
 2014-03-28 16:04:40.399 epaper[1274:5e03] write zip to local from cache0 0 file:///Users/legogreen2/Library/Application               錼Ǝވ̀ƚupport/iPhone  ࣜ댶什ࣙ什ࣙﲸ뀺才什ࣙ댶ࣜimulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Library/Caches/com.apple.nsnetworkd/CFNetworkDownload_acMxIr.tmp 0 file:///Users/legogreen2/Library/Application              쒃帄썝Ἇupport/iPhone               錼Ǝވ̀ƚimulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Documents/thumbnail/0065_ccp/0065_ccp_20021107.zip
 2014-03-28 16:04:42.643 epaper[1274:5e03] file copy success
 2014-03-28 16:04:42.643 epaper[1274:5e03] write zip to local from cache
 2014-03-28 16:04:42.644 epaper[1274:5e03] zip from0
 2014-03-28 16:04:42.644 epaper[1274:5e03] zip from /Users/legogreen2/Library/Application Support/iPhone Simulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Documents/thumbnail/0065_ccp/0065_ccp_20021107.zip to /Users/legogreen2/Library/Application Support/iPhone Simulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Documents/0065_ccp/20021107
 2014-03-28 16:04:47.980 epaper[1274:5e03] zip success
 2014-03-28 16:04:47.981 epaper[1274:5e03] LISTING ALL FILES FOUND
 2014-03-28 16:04:47.981 epaper[1274:5e03] File 1: 0065_ccp20021107-ad.xml
 2014-03-28 16:04:47.982 epaper[1274:5e03] File 2: 0065_ccp20021107-news.xml
 2014-03-28 16:04:47.982 epaper[1274:5e03] File 3: 0065_ccp20021107-paper.xml
 2014-03-28 16:04:47.982 epaper[1274:5e03] File 4: CPG20140320A01-Preview.jpg
 2014-03-28 16:04:47.982 epaper[1274:5e03] File 5: CPG20140320A01-Preview.png
 2014-03-28 16:04:47.983 epaper[1274:5e03] File 6: CPG20140320A02-Preview.jpg
 2014-03-28 16:04:47.983 epaper[1274:5e03] File 7: CPG20140320A02-Preview.png
 2014-03-28 16:04:47.983 epaper[1274:5e03] File 8: CPG20140320A03-Preview.jpg
 2014-03-28 16:04:47.984 epaper[1274:5e03] File 9: CPG20140320A03-Preview.png
 2014-03-28 16:04:47.984 epaper[1274:5e03] File 10: CPG20140320A04-Preview.jpg
 2014-03-28 16:04:47.984 epaper[1274:5e03] File 11: CPG20140320A04-Preview.png
 2014-03-28 16:04:47.984 epaper[1274:5e03] File 12: CPG20140320A05-Preview.jpg
 2014-03-28 16:04:47.985 epaper[1274:5e03] File 13: CPG20140320A05-Preview.png
 2014-03-28 16:04:47.985 epaper[1274:5e03] File 14: CPG20140320A06-Preview.jpg
 2014-03-28 16:04:47.985 epaper[1274:5e03] File 15: CPG20140320A06-Preview.png
 2014-03-28 16:04:47.986 epaper[1274:5e03] File 16: CPG20140320A07-Preview.jpg
 2014-03-28 16:04:47.986 epaper[1274:5e03] File 17: CPG20140320A07-Preview.png
 2014-03-28 16:04:47.986 epaper[1274:5e03] File 18: CPG20140320A08-Preview.jpg
 2014-03-28 16:04:47.987 epaper[1274:5e03] File 19: CPG20140320A08-Preview.png
 2014-03-28 16:04:47.987 epaper[1274:5e03] File 20: CPG20140320A09-Preview.jpg
 2014-03-28 16:04:47.987 epaper[1274:5e03] File 21: CPG20140320A09-Preview.png
 2014-03-28 16:04:47.987 epaper[1274:5e03] File 22: CPG20140320A10-Preview.jpg
 2014-03-28 16:04:47.988 epaper[1274:5e03] File 23: CPG20140320A10-Preview.png
 2014-03-28 16:04:47.988 epaper[1274:5e03] File 24: CPG20140320A11-Preview.jpg
 2014-03-28 16:04:47.988 epaper[1274:5e03] File 25: CPG20140320A11-Preview.png
 2014-03-28 16:04:47.989 epaper[1274:5e03] File 26: CPG20140320A12-Preview.jpg
 2014-03-28 16:04:47.989 epaper[1274:5e03] File 27: CPG20140320A12-Preview.png
 2014-03-28 16:04:47.989 epaper[1274:5e03] File 28: CPG20140320A13-Preview.jpg
 2014-03-28 16:04:47.989 epaper[1274:5e03] File 29: CPG20140320A13-Preview.png
 2014-03-28 16:04:47.990 epaper[1274:5e03] File 30: CPG20140320A14-Preview.jpg
 2014-03-28 16:04:47.990 epaper[1274:5e03] File 31: CPG20140320A14-Preview.png
 2014-03-28 16:04:47.990 epaper[1274:5e03] File 32: CPG20140320A15-Preview.jpg
 2014-03-28 16:04:47.990 epaper[1274:5e03] File 33: CPG20140320A15-Preview.png
 2014-03-28 16:04:47.991 epaper[1274:5e03] File 34: CPG20140320A16-Preview.jpg
 2014-03-28 16:04:47.991 epaper[1274:5e03] File 35: CPG20140320A16-Preview.png
 2014-03-28 16:04:47.991 epaper[1274:5e03] File 36: CPG20140320A17-Preview.jpg
 2014-03-28 16:04:47.992 epaper[1274:5e03] File 37: CPG20140320A17-Preview.png
 2014-03-28 16:04:47.992 epaper[1274:5e03] File 38: CPG20140320A18-Preview.jpg
 2014-03-28 16:04:47.992 epaper[1274:5e03] File 39: CPG20140320A18-Preview.png
 2014-03-28 16:04:47.992 epaper[1274:5e03] File 40: CPG20140320A19-Preview.jpg
 2014-03-28 16:04:47.993 epaper[1274:5e03] File 41: CPG20140320A19-Preview.png
 2014-03-28 16:04:47.993 epaper[1274:5e03] File 42: CPG20140320A20-Preview.jpg
 2014-03-28 16:04:47.993 epaper[1274:5e03] File 43: CPG20140320A20-Preview.png
 2014-03-28 16:04:47.993 epaper[1274:5e03] File 44: CPG20140320A21-Preview.jpg
 2014-03-28 16:04:47.994 epaper[1274:5e03] File 45: CPG20140320A21-Preview.png
 2014-03-28 16:04:47.994 epaper[1274:5e03] File 46: CPG20140320A22-Preview.jpg
 2014-03-28 16:04:47.994 epaper[1274:5e03] File 47: CPG20140320A22-Preview.png
 2014-03-28 16:04:47.994 epaper[1274:5e03] File 48: CPG20140320A23-Preview.jpg
 2014-03-28 16:04:47.995 epaper[1274:5e03] File 49: CPG20140320A23-Preview.png
 2014-03-28 16:04:47.995 epaper[1274:5e03] File 50: CPG20140320A24-Preview.jpg
 2014-03-28 16:04:47.995 epaper[1274:5e03] File 51: CPG20140320A24-Preview.png
 2014-03-28 16:04:47.996 epaper[1274:5e03] File 52: CPG20140320A25-Preview.jpg
 2014-03-28 16:04:47.996 epaper[1274:5e03] File 53: CPG20140320A25-Preview.png
 2014-03-28 16:04:47.996 epaper[1274:5e03] File 54: CPG20140320A26-Preview.jpg
 2014-03-28 16:04:47.997 epaper[1274:5e03] File 55: CPG20140320A26-Preview.png
 2014-03-28 16:04:47.997 epaper[1274:5e03] File 56: CPG20140320A27-Preview.jpg
 2014-03-28 16:04:47.997 epaper[1274:5e03] File 57: CPG20140320A27-Preview.png
 2014-03-28 16:04:47.997 epaper[1274:5e03] File 58: CPG20140320A28-Preview.jpg
 2014-03-28 16:04:47.998 epaper[1274:5e03] File 59: CPG20140320A28-Preview.png
 2014-03-28 16:04:47.998 epaper[1274:5e03] File 60: CPG20140320A29-Preview.jpg
 2014-03-28 16:04:47.998 epaper[1274:5e03] File 61: CPG20140320A29-Preview.png
 2014-03-28 16:04:47.999 epaper[1274:5e03] File 62: CPG20140320A30-Preview.jpg
 2014-03-28 16:04:47.999 epaper[1274:5e03] File 63: CPG20140320A30-Preview.png
 2014-03-28 16:04:47.999 epaper[1274:5e03] File 64: CPG20140320A31-Preview.jpg
 2014-03-28 16:04:48.000 epaper[1274:5e03] File 65: CPG20140320A31-Preview.png
 2014-03-28 16:04:48.000 epaper[1274:5e03] File 66: CPG20140320A32-Preview.jpg
 2014-03-28 16:04:48.000 epaper[1274:5e03] File 67: CPG20140320A32-Preview.png
 2014-03-28 16:04:48.000 epaper[1274:5e03] File 68: CPG20140320A33-Preview.jpg
 2014-03-28 16:04:48.001 epaper[1274:5e03] File 69: CPG20140320A33-Preview.png
 2014-03-28 16:04:48.001 epaper[1274:5e03] File 70: CPG20140320A34-Preview.jpg
 2014-03-28 16:04:48.001 epaper[1274:5e03] File 71: CPG20140320A34-Preview.png
 2014-03-28 16:04:48.002 epaper[1274:5e03] File 72: CPG20140320A35-Preview.jpg
 2014-03-28 16:04:48.002 epaper[1274:5e03] File 73: CPG20140320A35-Preview.png
 2014-03-28 16:04:48.002 epaper[1274:5e03] File 74: CPG20140320A36-Preview.jpg
 2014-03-28 16:04:48.003 epaper[1274:5e03] File 75: CPG20140320A36-Preview.png
 2014-03-28 16:04:48.003 epaper[1274:5e03] File 76: CPG20140320A37-Preview.jpg
 2014-03-28 16:04:48.003 epaper[1274:5e03] File 77: CPG20140320A37-Preview.png
 2014-03-28 16:04:48.003 epaper[1274:5e03] File 78: CPG20140320A38-Preview.jpg
 2014-03-28 16:04:48.004 epaper[1274:5e03] File 79: CPG20140320A38-Preview.png
 2014-03-28 16:04:48.004 epaper[1274:5e03] File 80: CPG20140320A39-Preview.jpg
 2014-03-28 16:04:48.004 epaper[1274:5e03] File 81: CPG20140320A39-Preview.png
 2014-03-28 16:04:48.005 epaper[1274:5e03] File 82: CPG20140320A40-Preview.jpg
 2014-03-28 16:04:48.005 epaper[1274:5e03] File 83: CPG20140320A40-Preview.png
 2014-03-28 16:04:48.005 epaper[1274:5e03] File 84: CPG20140320A41-Preview.jpg
 2014-03-28 16:04:48.005 epaper[1274:5e03] File 85: CPG20140320A41-Preview.png
 2014-03-28 16:04:48.006 epaper[1274:5e03] File 86: CPG20140320A42-Preview.jpg
 2014-03-28 16:04:48.006 epaper[1274:5e03] File 87: CPG20140320A42-Preview.png
 2014-03-28 16:04:48.006 epaper[1274:5e03] File 88: CPG20140320A43-Preview.jpg
 2014-03-28 16:04:48.006 epaper[1274:5e03] File 89: CPG20140320A43-Preview.png
 2014-03-28 16:04:48.007 epaper[1274:5e03] File 90: CPG20140320A44-Preview.jpg
 2014-03-28 16:04:48.007 epaper[1274:5e03] File 91: CPG20140320A44-Preview.png
 2014-03-28 16:04:48.007 epaper[1274:5e03] File 92: CPG20140320A45-Preview.jpg
 2014-03-28 16:04:48.008 epaper[1274:5e03] File 93: CPG20140320A45-Preview.png
 2014-03-28 16:04:48.008 epaper[1274:5e03] File 94: CPG20140320A46-Preview.jpg
 2014-03-28 16:04:48.008 epaper[1274:5e03] File 95: CPG20140320A46-Preview.png
 2014-03-28 16:04:48.008 epaper[1274:5e03] File 96: CPG20140320A47-Preview.jpg
 2014-03-28 16:04:48.009 epaper[1274:5e03] File 97: CPG20140320A47-Preview.png
 2014-03-28 16:04:48.009 epaper[1274:5e03] File 98: CPG20140320A48-Preview.jpg
 2014-03-28 16:04:48.009 epaper[1274:5e03] File 99: CPG20140320A48-Preview.png
 2014-03-28 16:04:48.009 epaper[1274:5e03] File 100: CPG20140320A49-Preview.jpg
 2014-03-28 16:04:48.010 epaper[1274:5e03] File 101: CPG20140320A49-Preview.png
 2014-03-28 16:04:48.010 epaper[1274:5e03] File 102: CPG20140320A50-Preview.jpg
 2014-03-28 16:04:48.010 epaper[1274:5e03] File 103: CPG20140320A50-Preview.png
 2014-03-28 16:04:48.011 epaper[1274:5e03] File 104: CPG20140320A51-Preview.jpg
 2014-03-28 16:04:48.011 epaper[1274:5e03] File 105: CPG20140320A51-Preview.png
 2014-03-28 16:04:48.011 epaper[1274:5e03] File 106: CPG20140320A52-Preview.jpg
 2014-03-28 16:04:48.011 epaper[1274:5e03] File 107: CPG20140320A52-Preview.png
 2014-03-28 16:04:48.012 epaper[1274:5e03] File 108: CPG20140320A53-Preview.jpg
 2014-03-28 16:04:48.012 epaper[1274:5e03] File 109: CPG20140320A53-Preview.png
 2014-03-28 16:04:48.012 epaper[1274:5e03] File 110: CPG20140320A54-Preview.jpg
 2014-03-28 16:04:48.013 epaper[1274:5e03] File 111: CPG20140320A54-Preview.png
 2014-03-28 16:04:48.013 epaper[1274:5e03] File 112: CPG20140320A55-Preview.jpg
 2014-03-28 16:04:48.013 epaper[1274:5e03] File 113: CPG20140320A55-Preview.png
 2014-03-28 16:04:48.013 epaper[1274:5e03] File 114: CPG20140320A56-Preview.jpg
 2014-03-28 16:04:48.014 epaper[1274:5e03] File 115: CPG20140320A56-Preview.png
 2014-03-28 16:04:48.014 epaper[1274:5e03] File 116: CPG20140320A57-Preview.jpg
 2014-03-28 16:04:48.014 epaper[1274:5e03] File 117: CPG20140320A57-Preview.png
 2014-03-28 16:04:48.014 epaper[1274:5e03] File 118: CPG20140320A58-Preview.jpg
 2014-03-28 16:04:48.015 epaper[1274:5e03] File 119: CPG20140320A58-Preview.png
 2014-03-28 16:04:48.015 epaper[1274:5e03] File 120: CPG20140320A59-Preview.jpg
 2014-03-28 16:04:48.015 epaper[1274:5e03] File 121: CPG20140320A59-Preview.png
 2014-03-28 16:04:48.015 epaper[1274:5e03] File 122: CPG20140320A60-Preview.jpg
 2014-03-28 16:04:48.016 epaper[1274:5e03] File 123: CPG20140320A60-Preview.png
 2014-03-28 16:04:48.016 epaper[1274:5e03] File 124: CPG20140320A61-Preview.jpg
 2014-03-28 16:04:48.016 epaper[1274:5e03] File 125: CPG20140320A61-Preview.png
 2014-03-28 16:04:48.017 epaper[1274:5e03] File 126: CPG20140320A62-Preview.jpg
 2014-03-28 16:04:48.017 epaper[1274:5e03] File 127: CPG20140320A62-Preview.png
 2014-03-28 16:04:48.017 epaper[1274:5e03] File 128: CPG20140320A63-Preview.jpg
 2014-03-28 16:04:48.017 epaper[1274:5e03] File 129: CPG20140320A63-Preview.png
 2014-03-28 16:04:48.018 epaper[1274:5e03] File 130: CPG20140320A64-Preview.jpg
 2014-03-28 16:04:48.018 epaper[1274:5e03] File 131: CPG20140320A64-Preview.png
 2014-03-28 16:04:48.018 epaper[1274:5e03] File 132: CPG20140320A65-Preview.jpg
 2014-03-28 16:04:48.018 epaper[1274:5e03] File 133: CPG20140320A65-Preview.png
 2014-03-28 16:04:48.019 epaper[1274:5e03] File 134: CPG20140320A66-Preview.jpg
 2014-03-28 16:04:48.019 epaper[1274:5e03] File 135: CPG20140320A66-Preview.png
 2014-03-28 16:04:48.019 epaper[1274:5e03] File 136: CPG20140320A67-Preview.jpg
 2014-03-28 16:04:48.020 epaper[1274:5e03] File 137: CPG20140320A67-Preview.png
 2014-03-28 16:04:48.020 epaper[1274:5e03] File 138: CPG20140320A68-Preview.jpg
 2014-03-28 16:04:48.020 epaper[1274:5e03] File 139: CPG20140320A68-Preview.png
 2014-03-28 16:04:48.021 epaper[1274:5e03] File 140: CPG20140320A69-Preview.jpg
 2014-03-28 16:04:48.021 epaper[1274:5e03] File 141: CPG20140320A69-Preview.png
 2014-03-28 16:04:48.021 epaper[1274:5e03] File 142: CPG20140320A70-Preview.jpg
 2014-03-28 16:04:48.021 epaper[1274:5e03] File 143: CPG20140320A70-Preview.png
 2014-03-28 16:04:48.022 epaper[1274:5e03] File 144: CPG20140320A71-Preview.jpg
 2014-03-28 16:04:48.022 epaper[1274:5e03] File 145: CPG20140320A71-Preview.png
 2014-03-28 16:04:48.022 epaper[1274:5e03] File 146: CPG20140320A72-Preview.jpg
 2014-03-28 16:04:48.022 epaper[1274:5e03] File 147: CPG20140320A72-Preview.png
 2014-03-28 16:04:48.023 epaper[1274:5e03] File 148: HouseAd
 2014-03-28 16:04:48.023 epaper[1274:5e03] File 149: pre
 2014-03-28 16:04:48.029 epaper[1274:5e03] delete file success
 2014-03-28 16:04:48.029 epaper[1274:5e03] delete zip file thumbnail/0065_ccp/0065_ccp_20021107.zip after unzip
 2014-03-28 16:04:48.046 epaper[1274:5e03] thumbnail/0065_ccp/0065_ccp_20021107.zip is finished in file:///Users/legogreen2/Library/Application%20Support/iPhone%20Simulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Library/Caches/com.apple.nsnetworkd/CFNetworkDownload_pUDCAH.tmp
 2014-03-28 16:04:48.143 epaper[1274:5e03] thumbnail/0065_ccp/0065_ccp_20021107.zip has been downloaded
 2014-03-28 16:04:48.144 epaper[1274:5e03] There is no old file to delete
 2014-03-28 16:04:48.144 epaper[1274:5e03] write zip to local from cache0
 2014-03-28 16:04:48.144 epaper[1274:5e03] write zip to local from cache0 0 file:///Users/legogreen2/Library/Application               錼Ǝވ̀ƚupport/iPhone  褀ࢪ댶什ࣙ什ࣙﲸ뀺才什ࣙ댶褀ࢪimulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Library/Caches/com.apple.nsnetworkd/CFNetworkDownload_pUDCAH.tmp 0 file:///Users/legogreen2/Library/Application              쒃帄썝Ἇupport/iPhone               錼Ǝވ̀ƚimulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Documents/thumbnail/0065_ccp/0065_ccp_20021107.zip
 2014-03-28 16:04:50.187 epaper[1274:5e03] file copy success
 2014-03-28 16:04:50.187 epaper[1274:5e03] write zip to local from cache
 2014-03-28 16:04:50.188 epaper[1274:5e03] zip from0
 2014-03-28 16:04:50.188 epaper[1274:5e03] zip from /Users/legogreen2/Library/Application Support/iPhone Simulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Documents/thumbnail/0065_ccp/0065_ccp_20021107.zip to /Users/legogreen2/Library/Application Support/iPhone Simulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Documents/0065_ccp/20021107
 2014-03-28 16:04:55.603 epaper[1274:5e03] zip success
 2014-03-28 16:04:55.604 epaper[1274:5e03] LISTING ALL FILES FOUND
 2014-03-28 16:04:55.604 epaper[1274:5e03] File 1: 0065_ccp20021107-ad.xml
 2014-03-28 16:04:55.605 epaper[1274:5e03] File 2: 0065_ccp20021107-news.xml
 2014-03-28 16:04:55.605 epaper[1274:5e03] File 3: 0065_ccp20021107-paper.xml
 2014-03-28 16:04:55.605 epaper[1274:5e03] File 4: CPG20140320A01-Preview.jpg
 2014-03-28 16:04:55.606 epaper[1274:5e03] File 5: CPG20140320A01-Preview.png
 2014-03-28 16:04:55.606 epaper[1274:5e03] File 6: CPG20140320A02-Preview.jpg
 2014-03-28 16:04:55.606 epaper[1274:5e03] File 7: CPG20140320A02-Preview.png
 2014-03-28 16:04:55.607 epaper[1274:5e03] File 8: CPG20140320A03-Preview.jpg
 2014-03-28 16:04:55.607 epaper[1274:5e03] File 9: CPG20140320A03-Preview.png
 2014-03-28 16:04:55.607 epaper[1274:5e03] File 10: CPG20140320A04-Preview.jpg
 2014-03-28 16:04:55.607 epaper[1274:5e03] File 11: CPG20140320A04-Preview.png
 2014-03-28 16:04:55.608 epaper[1274:5e03] File 12: CPG20140320A05-Preview.jpg
 2014-03-28 16:04:55.608 epaper[1274:5e03] File 13: CPG20140320A05-Preview.png
 2014-03-28 16:04:55.608 epaper[1274:5e03] File 14: CPG20140320A06-Preview.jpg
 2014-03-28 16:04:55.609 epaper[1274:5e03] File 15: CPG20140320A06-Preview.png
 2014-03-28 16:04:55.609 epaper[1274:5e03] File 16: CPG20140320A07-Preview.jpg
 2014-03-28 16:04:55.609 epaper[1274:5e03] File 17: CPG20140320A07-Preview.png
 2014-03-28 16:04:55.610 epaper[1274:5e03] File 18: CPG20140320A08-Preview.jpg
 2014-03-28 16:04:55.610 epaper[1274:5e03] File 19: CPG20140320A08-Preview.png
 2014-03-28 16:04:55.610 epaper[1274:5e03] File 20: CPG20140320A09-Preview.jpg
 2014-03-28 16:04:55.610 epaper[1274:5e03] File 21: CPG20140320A09-Preview.png
 2014-03-28 16:04:55.611 epaper[1274:5e03] File 22: CPG20140320A10-Preview.jpg
 2014-03-28 16:04:55.611 epaper[1274:5e03] File 23: CPG20140320A10-Preview.png
 2014-03-28 16:04:55.611 epaper[1274:5e03] File 24: CPG20140320A11-Preview.jpg
 2014-03-28 16:04:55.611 epaper[1274:5e03] File 25: CPG20140320A11-Preview.png
 2014-03-28 16:04:55.612 epaper[1274:5e03] File 26: CPG20140320A12-Preview.jpg
 2014-03-28 16:04:55.612 epaper[1274:5e03] File 27: CPG20140320A12-Preview.png
 2014-03-28 16:04:55.612 epaper[1274:5e03] File 28: CPG20140320A13-Preview.jpg
 2014-03-28 16:04:55.613 epaper[1274:5e03] File 29: CPG20140320A13-Preview.png
 2014-03-28 16:04:55.613 epaper[1274:5e03] File 30: CPG20140320A14-Preview.jpg
 2014-03-28 16:04:55.613 epaper[1274:5e03] File 31: CPG20140320A14-Preview.png
 2014-03-28 16:04:55.613 epaper[1274:5e03] File 32: CPG20140320A15-Preview.jpg
 2014-03-28 16:04:55.614 epaper[1274:5e03] File 33: CPG20140320A15-Preview.png
 2014-03-28 16:04:55.614 epaper[1274:5e03] File 34: CPG20140320A16-Preview.jpg
 2014-03-28 16:04:55.614 epaper[1274:5e03] File 35: CPG20140320A16-Preview.png
 2014-03-28 16:04:55.615 epaper[1274:5e03] File 36: CPG20140320A17-Preview.jpg
 2014-03-28 16:04:55.615 epaper[1274:5e03] File 37: CPG20140320A17-Preview.png
 2014-03-28 16:04:55.615 epaper[1274:5e03] File 38: CPG20140320A18-Preview.jpg
 2014-03-28 16:04:55.615 epaper[1274:5e03] File 39: CPG20140320A18-Preview.png
 2014-03-28 16:04:55.616 epaper[1274:5e03] File 40: CPG20140320A19-Preview.jpg
 2014-03-28 16:04:55.616 epaper[1274:5e03] File 41: CPG20140320A19-Preview.png
 2014-03-28 16:04:55.616 epaper[1274:5e03] File 42: CPG20140320A20-Preview.jpg
 2014-03-28 16:04:55.617 epaper[1274:5e03] File 43: CPG20140320A20-Preview.png
 2014-03-28 16:04:55.617 epaper[1274:5e03] File 44: CPG20140320A21-Preview.jpg
 2014-03-28 16:04:55.617 epaper[1274:5e03] File 45: CPG20140320A21-Preview.png
 2014-03-28 16:04:55.617 epaper[1274:5e03] File 46: CPG20140320A22-Preview.jpg
 2014-03-28 16:04:55.618 epaper[1274:5e03] File 47: CPG20140320A22-Preview.png
 2014-03-28 16:04:55.618 epaper[1274:5e03] File 48: CPG20140320A23-Preview.jpg
 2014-03-28 16:04:55.618 epaper[1274:5e03] File 49: CPG20140320A23-Preview.png
 2014-03-28 16:04:55.619 epaper[1274:5e03] File 50: CPG20140320A24-Preview.jpg
 2014-03-28 16:04:55.619 epaper[1274:5e03] File 51: CPG20140320A24-Preview.png
 2014-03-28 16:04:55.619 epaper[1274:5e03] File 52: CPG20140320A25-Preview.jpg
 2014-03-28 16:04:55.619 epaper[1274:5e03] File 53: CPG20140320A25-Preview.png
 2014-03-28 16:04:55.620 epaper[1274:5e03] File 54: CPG20140320A26-Preview.jpg
 2014-03-28 16:04:55.620 epaper[1274:5e03] File 55: CPG20140320A26-Preview.png
 2014-03-28 16:04:55.620 epaper[1274:5e03] File 56: CPG20140320A27-Preview.jpg
 2014-03-28 16:04:55.620 epaper[1274:5e03] File 57: CPG20140320A27-Preview.png
 2014-03-28 16:04:55.621 epaper[1274:5e03] File 58: CPG20140320A28-Preview.jpg
 2014-03-28 16:04:55.621 epaper[1274:5e03] File 59: CPG20140320A28-Preview.png
 2014-03-28 16:04:55.621 epaper[1274:5e03] File 60: CPG20140320A29-Preview.jpg
 2014-03-28 16:04:55.622 epaper[1274:5e03] File 61: CPG20140320A29-Preview.png
 2014-03-28 16:04:55.622 epaper[1274:5e03] File 62: CPG20140320A30-Preview.jpg
 2014-03-28 16:04:55.622 epaper[1274:5e03] File 63: CPG20140320A30-Preview.png
 2014-03-28 16:04:55.622 epaper[1274:5e03] File 64: CPG20140320A31-Preview.jpg
 2014-03-28 16:04:55.623 epaper[1274:5e03] File 65: CPG20140320A31-Preview.png
 2014-03-28 16:04:55.623 epaper[1274:5e03] File 66: CPG20140320A32-Preview.jpg
 2014-03-28 16:04:55.623 epaper[1274:5e03] File 67: CPG20140320A32-Preview.png
 2014-03-28 16:04:55.624 epaper[1274:5e03] File 68: CPG20140320A33-Preview.jpg
 2014-03-28 16:04:55.624 epaper[1274:5e03] File 69: CPG20140320A33-Preview.png
 2014-03-28 16:04:55.624 epaper[1274:5e03] File 70: CPG20140320A34-Preview.jpg
 2014-03-28 16:04:55.624 epaper[1274:5e03] File 71: CPG20140320A34-Preview.png
 2014-03-28 16:04:55.625 epaper[1274:5e03] File 72: CPG20140320A35-Preview.jpg
 2014-03-28 16:04:55.625 epaper[1274:5e03] File 73: CPG20140320A35-Preview.png
 2014-03-28 16:04:55.625 epaper[1274:5e03] File 74: CPG20140320A36-Preview.jpg
 2014-03-28 16:04:55.626 epaper[1274:5e03] File 75: CPG20140320A36-Preview.png
 2014-03-28 16:04:55.626 epaper[1274:5e03] File 76: CPG20140320A37-Preview.jpg
 2014-03-28 16:04:55.626 epaper[1274:5e03] File 77: CPG20140320A37-Preview.png
 2014-03-28 16:04:55.626 epaper[1274:5e03] File 78: CPG20140320A38-Preview.jpg
 2014-03-28 16:04:55.627 epaper[1274:5e03] File 79: CPG20140320A38-Preview.png
 2014-03-28 16:04:55.627 epaper[1274:5e03] File 80: CPG20140320A39-Preview.jpg
 2014-03-28 16:04:55.627 epaper[1274:5e03] File 81: CPG20140320A39-Preview.png
 2014-03-28 16:04:55.628 epaper[1274:5e03] File 82: CPG20140320A40-Preview.jpg
 2014-03-28 16:04:55.628 epaper[1274:5e03] File 83: CPG20140320A40-Preview.png
 2014-03-28 16:04:55.628 epaper[1274:5e03] File 84: CPG20140320A41-Preview.jpg
 2014-03-28 16:04:55.628 epaper[1274:5e03] File 85: CPG20140320A41-Preview.png
 2014-03-28 16:04:55.629 epaper[1274:5e03] File 86: CPG20140320A42-Preview.jpg
 2014-03-28 16:04:55.629 epaper[1274:5e03] File 87: CPG20140320A42-Preview.png
 2014-03-28 16:04:55.629 epaper[1274:5e03] File 88: CPG20140320A43-Preview.jpg
 2014-03-28 16:04:55.629 epaper[1274:5e03] File 89: CPG20140320A43-Preview.png
 2014-03-28 16:04:55.630 epaper[1274:5e03] File 90: CPG20140320A44-Preview.jpg
 2014-03-28 16:04:55.630 epaper[1274:5e03] File 91: CPG20140320A44-Preview.png
 2014-03-28 16:04:55.630 epaper[1274:5e03] File 92: CPG20140320A45-Preview.jpg
 2014-03-28 16:04:55.631 epaper[1274:5e03] File 93: CPG20140320A45-Preview.png
 2014-03-28 16:04:55.631 epaper[1274:5e03] File 94: CPG20140320A46-Preview.jpg
 2014-03-28 16:04:55.631 epaper[1274:5e03] File 95: CPG20140320A46-Preview.png
 2014-03-28 16:04:55.631 epaper[1274:5e03] File 96: CPG20140320A47-Preview.jpg
 2014-03-28 16:04:55.632 epaper[1274:5e03] File 97: CPG20140320A47-Preview.png
 2014-03-28 16:04:55.632 epaper[1274:5e03] File 98: CPG20140320A48-Preview.jpg
 2014-03-28 16:04:55.632 epaper[1274:5e03] File 99: CPG20140320A48-Preview.png
 2014-03-28 16:04:55.633 epaper[1274:5e03] File 100: CPG20140320A49-Preview.jpg
 2014-03-28 16:04:55.633 epaper[1274:5e03] File 101: CPG20140320A49-Preview.png
 2014-03-28 16:04:55.633 epaper[1274:5e03] File 102: CPG20140320A50-Preview.jpg
 2014-03-28 16:04:55.633 epaper[1274:5e03] File 103: CPG20140320A50-Preview.png
 2014-03-28 16:04:55.634 epaper[1274:5e03] File 104: CPG20140320A51-Preview.jpg
 2014-03-28 16:04:55.634 epaper[1274:5e03] File 105: CPG20140320A51-Preview.png
 2014-03-28 16:04:55.634 epaper[1274:5e03] File 106: CPG20140320A52-Preview.jpg
 2014-03-28 16:04:55.634 epaper[1274:5e03] File 107: CPG20140320A52-Preview.png
 2014-03-28 16:04:55.635 epaper[1274:5e03] File 108: CPG20140320A53-Preview.jpg
 2014-03-28 16:04:55.635 epaper[1274:5e03] File 109: CPG20140320A53-Preview.png
 2014-03-28 16:04:55.635 epaper[1274:5e03] File 110: CPG20140320A54-Preview.jpg
 2014-03-28 16:04:55.636 epaper[1274:5e03] File 111: CPG20140320A54-Preview.png
 2014-03-28 16:04:55.636 epaper[1274:5e03] File 112: CPG20140320A55-Preview.jpg
 2014-03-28 16:04:55.636 epaper[1274:5e03] File 113: CPG20140320A55-Preview.png
 2014-03-28 16:04:55.636 epaper[1274:5e03] File 114: CPG20140320A56-Preview.jpg
 2014-03-28 16:04:55.637 epaper[1274:5e03] File 115: CPG20140320A56-Preview.png
 2014-03-28 16:04:55.637 epaper[1274:5e03] File 116: CPG20140320A57-Preview.jpg
 2014-03-28 16:04:55.637 epaper[1274:5e03] File 117: CPG20140320A57-Preview.png
 2014-03-28 16:04:55.638 epaper[1274:5e03] File 118: CPG20140320A58-Preview.jpg
 2014-03-28 16:04:55.638 epaper[1274:5e03] File 119: CPG20140320A58-Preview.png
 2014-03-28 16:04:55.638 epaper[1274:5e03] File 120: CPG20140320A59-Preview.jpg
 2014-03-28 16:04:55.638 epaper[1274:5e03] File 121: CPG20140320A59-Preview.png
 2014-03-28 16:04:55.639 epaper[1274:5e03] File 122: CPG20140320A60-Preview.jpg
 2014-03-28 16:04:55.639 epaper[1274:5e03] File 123: CPG20140320A60-Preview.png
 2014-03-28 16:04:55.639 epaper[1274:5e03] File 124: CPG20140320A61-Preview.jpg
 2014-03-28 16:04:55.640 epaper[1274:5e03] File 125: CPG20140320A61-Preview.png
 2014-03-28 16:04:55.640 epaper[1274:5e03] File 126: CPG20140320A62-Preview.jpg
 2014-03-28 16:04:55.640 epaper[1274:5e03] File 127: CPG20140320A62-Preview.png
 2014-03-28 16:04:55.640 epaper[1274:5e03] File 128: CPG20140320A63-Preview.jpg
 2014-03-28 16:04:55.641 epaper[1274:5e03] File 129: CPG20140320A63-Preview.png
 2014-03-28 16:04:55.641 epaper[1274:5e03] File 130: CPG20140320A64-Preview.jpg
 2014-03-28 16:04:55.641 epaper[1274:5e03] File 131: CPG20140320A64-Preview.png
 2014-03-28 16:04:55.642 epaper[1274:5e03] File 132: CPG20140320A65-Preview.jpg
 2014-03-28 16:04:55.642 epaper[1274:5e03] File 133: CPG20140320A65-Preview.png
 2014-03-28 16:04:55.642 epaper[1274:5e03] File 134: CPG20140320A66-Preview.jpg
 2014-03-28 16:04:55.642 epaper[1274:5e03] File 135: CPG20140320A66-Preview.png
 2014-03-28 16:04:55.643 epaper[1274:5e03] File 136: CPG20140320A67-Preview.jpg
 2014-03-28 16:04:55.643 epaper[1274:5e03] File 137: CPG20140320A67-Preview.png
 2014-03-28 16:04:55.643 epaper[1274:5e03] File 138: CPG20140320A68-Preview.jpg
 2014-03-28 16:04:55.643 epaper[1274:5e03] File 139: CPG20140320A68-Preview.png
 2014-03-28 16:04:55.644 epaper[1274:5e03] File 140: CPG20140320A69-Preview.jpg
 2014-03-28 16:04:55.644 epaper[1274:5e03] File 141: CPG20140320A69-Preview.png
 2014-03-28 16:04:55.644 epaper[1274:5e03] File 142: CPG20140320A70-Preview.jpg
 2014-03-28 16:04:55.644 epaper[1274:5e03] File 143: CPG20140320A70-Preview.png
 2014-03-28 16:04:55.645 epaper[1274:5e03] File 144: CPG20140320A71-Preview.jpg
 2014-03-28 16:04:55.645 epaper[1274:5e03] File 145: CPG20140320A71-Preview.png
 2014-03-28 16:04:55.645 epaper[1274:5e03] File 146: CPG20140320A72-Preview.jpg
 2014-03-28 16:04:55.646 epaper[1274:5e03] File 147: CPG20140320A72-Preview.png
 2014-03-28 16:04:55.646 epaper[1274:5e03] File 148: HouseAd
 2014-03-28 16:04:55.646 epaper[1274:5e03] File 149: pre
 2014-03-28 16:04:55.653 epaper[1274:5e03] delete file success
 2014-03-28 16:04:55.653 epaper[1274:5e03] delete zip file thumbnail/0065_ccp/0065_ccp_20021107.zip after unzip
 2014-03-28 16:05:52.852 epaper[1274:5e03] thumbnail/0065_ccp/0065_ccp_20021105.zip is finished in file:///Users/legogreen2/Library/Application%20Support/iPhone%20Simulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Library/Caches/com.apple.nsnetworkd/CFNetworkDownload_D19kk0.tmp
 2014-03-28 16:05:52.976 epaper[1274:5e03] thumbnail/0065_ccp/0065_ccp_20021105.zip has been downloaded
 2014-03-28 16:05:52.976 epaper[1274:5e03] There is no old file to delete
 2014-03-28 16:05:52.977 epaper[1274:5e03] write zip to local from cache0
 2014-03-28 16:05:52.977 epaper[1274:5e03] write zip to local from cache0 0 file:///Users/legogreen2/Library/Application               錼Ǝވ̀ƚupport/iPhone  ｰࣜ댶什ࣙ什ࣙﲸ뀺才什ࣙ댶ｰࣜimulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Library/Caches/com.apple.nsnetworkd/CFNetworkDownload_D19kk0.tmp 0 file:///Users/legogreen2/Library/Application              쒃帄썝Ἇupport/iPhone               錼Ǝވ̀ƚimulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Documents/thumbnail/0065_ccp/0065_ccp_20021105.zip
 2014-03-28 16:05:54.480 epaper[1274:5e03] file copy success
 2014-03-28 16:05:54.481 epaper[1274:5e03] write zip to local from cache
 2014-03-28 16:05:54.481 epaper[1274:5e03] zip from0
 2014-03-28 16:05:54.482 epaper[1274:5e03] zip from /Users/legogreen2/Library/Application Support/iPhone Simulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Documents/thumbnail/0065_ccp/0065_ccp_20021105.zip to /Users/legogreen2/Library/Application Support/iPhone Simulator/7.0.3/Applications/B7E3C262-DDA9-4F70-A83C-358CB2239F2F/Documents/0065_ccp/20021105
 2014-03-28 16:05:58.176 epaper[1274:5e03] zip success
 2014-03-28 16:05:58.177 epaper[1274:5e03] LISTING ALL FILES FOUND
 2014-03-28 16:05:58.177 epaper[1274:5e03] File 1: 0065_ccp20021105-ad.xml
 2014-03-28 16:05:58.178 epaper[1274:5e03] File 2: 0065_ccp20021105-news.xml
 
 2014-03-28 16:05:58.211 epaper[1274:5e03] File 119: CPG20140313A58-Preview.png
 2014-03-28 16:05:58.211 epaper[1274:5e03] File 120: CPG20140313A59-Preview.jpg
 2014-03-28 16:05:58.212 epaper[1274:5e03] File 121: CPG20140313A59-Preview.png
 2014-03-28 16:05:58.212 epaper[1274:5e03] File 122: CPG20140313A60-Preview.jpg
 2014-03-28 16:05:58.212 epaper[1274:5e03] File 123: CPG20140313A60-Preview.png
 2014-03-28 16:05:58.212 epaper[1274:5e03] File 124: CPG20140313A61-Preview.jpg
 2014-03-28 16:05:58.213 epaper[1274:5e03] File 125: CPG20140313A61-Preview.png
 2014-03-28 16:05:58.213 epaper[1274:5e03] File 126: CPG20140313A62-Preview.jpg
 2014-03-28 16:05:58.213 epaper[1274:5e03] File 127: CPG20140313A62-Preview.png
 2014-03-28 16:05:58.213 epaper[1274:5e03] File 128: CPG20140313A63-Preview.jpg
 2014-03-28 16:05:58.214 epaper[1274:5e03] File 129: CPG20140313A63-Preview.png
 2014-03-28 16:05:58.214 epaper[1274:5e03] File 130: CPG20140313A64-Preview.jpg
 2014-03-28 16:05:58.214 epaper[1274:5e03] File 131: CPG20140313A64-Preview.png
 2014-03-28 16:05:58.215 epaper[1274:5e03] File 132: CPG20140313A65-Preview.jpg
 2014-03-28 16:05:58.215 epaper[1274:5e03] File 133: CPG20140313A65-Preview.png
 2014-03-28 16:05:58.215 epaper[1274:5e03] File 134: CPG20140313A66-Preview.jpg
 2014-03-28 16:05:58.215 epaper[1274:5e03] File 135: CPG20140313A66-Preview.png
 2014-03-28 16:05:58.216 epaper[1274:5e03] File 136: CPG20140313A67-Preview.jpg
 2014-03-28 16:05:58.216 epaper[1274:5e03] File 137: CPG20140313A67-Preview.png
 2014-03-28 16:05:58.216 epaper[1274:5e03] File 138: CPG20140313A68-Preview.jpg
 2014-03-28 16:05:58.216 epaper[1274:5e03] File 139: CPG20140313A68-Preview.png
 2014-03-28 16:05:58.217 epaper[1274:5e03] File 140: CPG20140313A69-Preview.jpg
 2014-03-28 16:05:58.217 epaper[1274:5e03] File 141: CPG20140313A69-Preview.png
 2014-03-28 16:05:58.217 epaper[1274:5e03] File 142: CPG20140313A70-Preview.jpg
 2014-03-28 16:05:58.218 epaper[1274:5e03] File 143: CPG20140313A70-Preview.png
 2014-03-28 16:05:58.218 epaper[1274:5e03] File 144: CPG20140313A71-Preview.jpg
 2014-03-28 16:05:58.218 epaper[1274:5e03] File 145: CPG20140313A71-Preview.png
 2014-03-28 16:05:58.218 epaper[1274:5e03] File 146: CPG20140313A72-Preview.jpg
 2014-03-28 16:05:58.219 epaper[1274:5e03] File 147: CPG20140313A72-Preview.png
 2014-03-28 16:05:58.219 epaper[1274:5e03] File 148: HouseAd
 2014-03-28 16:05:58.219 epaper[1274:5e03] File 149: Pre
 2014-03-28 16:05:58.225 epaper[1274:5e03] delete file success 
 2014-03-28 16:05:58.225 epaper[1274:5e03] delete zip file thumbnail/0065_ccp/0065_ccp_20021105.zip after unzip
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */

@end
