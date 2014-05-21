//
//  CollectionPub.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-12.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "CollectionPub.h"
#import "IssueController.h"

@implementation CollectionPub

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.toNo intValue]-[self.fromNo intValue]+1;
}

-(NSMutableDictionary *)getPub:(int) idx {
    
    
    int indexFix = [self.fromNo intValue];
    
    NSMutableDictionary *pub = [self.controller.app.params.pubArray objectAtIndex:(indexFix+idx )];
    
    return pub;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    //cell.backgroundColor=[UIColor greenColor];
    
    NSMutableDictionary *pub = [self getPub: indexPath.item];
    
    NSMutableArray *issueArray = [pub objectForKey:@"children"];
    NSString *fullname = @"";
    if ( issueArray.count>0 ) {
        fullname = [issueArray[0] objectForKey:@"icon"];
    }
    
    NSData *data  = [self.controller loadFileLocal:fullname];
    UIImage *image = [[UIImage alloc] initWithData:data];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    imageView.image = image;
    //http://my.oschina.net/plumsoft/blog/76128
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [cell addSubview:imageView];
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(132, 132);
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
    [self setBackgroundColor:[UIColor redColor]];
    
    return self;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *pub = [self getPub: indexPath.item];
    
    IssueController *nextController = [[IssueController alloc] init];
    nextController.pub = pub;
    //[self.navigationController pushViewController:easyView1 animated:YES];
    [self.controller presentModalViewController:nextController animated:YES];
    
    
}

@end
