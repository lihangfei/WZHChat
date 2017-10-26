//
//  WZHPictureTableViewCell.h
//  WebPageMaster
//
//  Created by 吳梓杭 on 2017/10/22.
//  Copyright © 2017年 Guangzhou Ankai Information Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WZHPictureOriginalDelegate <NSObject>

-(void)PictureOriginalClicked:(UIButton *)pictureBtn;
-(void)ChatMessageClicked:(UILongPressGestureRecognizer *)longBtn;


@end

@interface WZHPictureTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel * lab_time;
@property(nonatomic,strong)UILabel * lab_name;
@property(nonatomic,strong)UIImageView * headerView;
@property(nonatomic,strong)NSString * messageWidth;
@property(nonatomic,strong)NSString * messageHight;
@property(nonatomic,strong)UIImageView * conversationView;
@property(nonatomic,strong)NSDate *timeDate;
@property(nonatomic,strong)UIImageView * thumbnailView;
@property(nonatomic,strong)UIButton * btn_picture;

@property(assign,nonatomic) id <WZHPictureOriginalDelegate> delegate;


-(void)initWithTime:(NSString *)timeStr HeaderStr:(NSString *)headerStr Name:(NSString *)nameStr Guest:(NSString *)guestStr thumbnailStr:(NSString *)thumbnailStr thumbnailImage:(UIImage *)thumbnailImage pictureBool:(NSString *)pictureBool PictureTag:(NSInteger)pictureTag;
@end
