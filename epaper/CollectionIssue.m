//
//  CollectionIssue.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-13.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "CollectionIssue.h"
#import "ArticleController.h"
#import "IssueController.h"

@implementation CollectionIssue


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.toNo intValue]-[self.fromNo intValue]+1;
}

-(NSMutableDictionary *)getIssue:(int) idx {
    int indexFix = [self.fromNo intValue];
    
    NSMutableDictionary *issue = [[((IssueController *)self.controller).pub objectForKey:@"children"] objectAtIndex:(indexFix+idx)];
    
    return issue;
}

-(NSMutableDictionary *)getPub {
    return ((IssueController *)self.controller).pub;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    //cell.backgroundColor=[UIColor greenColor];
    
    NSMutableDictionary *issue = [self getIssue: indexPath.item];
    
    NSString *fullname = @"";
    fullname = [issue objectForKey:@"icon"];
    
    NSData *data  = [self.controller loadFileLocal:fullname];
    UIImage *image = [[UIImage alloc] initWithData:data];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 132)];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [cell addSubview:imageView];
    
    NSMutableDictionary *pub = [self getPub];
    NSString * code = [pub objectForKey:@"code"];
    NSString * date = [issue objectForKey:@"date"];
    NSLog(@"code %@ date %@",code,date);
    NSString* dicName = [NSString stringWithFormat:@"%@/%@/Favor",code,date];
    NSString* dataPath = [self.controller.app.local stringByAppendingPathComponent:dicName];
    NSString* pre= @"";
    if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        pre = @"(已收藏)";
    } else {
        dicName = [NSString stringWithFormat:@"%@/%@/Pre",code,date];
        dataPath = [self.controller.app.local stringByAppendingPathComponent:dicName];
        if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
            pre = @"(已下载)";
        }
    }
    
    
    UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-20, cell.frame.size.width, 20)];
    testLabel.text = [NSString stringWithFormat:@"%@%@",[issue objectForKey:@"display"],pre];
    [testLabel setFont:[UIFont systemFontOfSize:12]];
    testLabel.clipsToBounds = YES;
    testLabel.backgroundColor = [UIColor clearColor];
    testLabel.textColor = [UIColor whiteColor];
    testLabel.textAlignment = NSTextAlignmentCenter;
    
    [cell addSubview:testLabel];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(132, 152);
}

- (id)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout * layout=[[UICollectionViewFlowLayout alloc] init];
    //layout.itemSize = CGSizeMake(450, 450);
    layout.minimumLineSpacing = 88;
    layout.sectionInset = UIEdgeInsetsMake(88, 0, 0, 0);
    
    //必须带layout
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if( !self ) return nil;
    
    //self.collectionViewLayout = layout;
    [self setDataSource:self];
    [self setDelegate:self];
    
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    //[self setBackgroundColor:[UIColor redColor]];
    
    return self;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *issue = [self getIssue: indexPath.item];
    NSMutableDictionary *pub = [self getPub];
    
    ArticleController *nextController = [[ArticleController alloc] init];
    NSString * code = [pub objectForKey:@"code"];
    NSString * date = [issue objectForKey:@"date"];
    NSString *fullname = [NSString stringWithFormat:@"%@/%@/%@%@-paper.xml",code,date,code,date];
    
    nextController.pubDic = pub;
    nextController.issueDic = issue;
    nextController.fullname = fullname;//@"0065_ccp/20021103/0065_ccp20021103-paper.xml";
    //[self.navigationController pushViewController:easyView1 animated:YES];
    [self.controller presentModalViewController:nextController animated:YES];
}


@end
