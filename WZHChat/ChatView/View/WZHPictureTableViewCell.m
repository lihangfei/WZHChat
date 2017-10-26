//
//  WZHPictureTableViewCell.m
//  WebPageMaster
//
//  Created by 吳梓杭 on 2017/10/22.
//  Copyright © 2017年 Guangzhou Ankai Information Technology Co., Ltd. All rights reserved.
//

#import "WZHPictureTableViewCell.h"

@implementation WZHPictureTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.lab_time = [[UILabel alloc] init];
        _lab_time.text = @"2017-08-20 11:30:21";
        _lab_time.frame = CGRectMake((IPHONE_WIDTH - [NSString getSizeByString:_lab_time.text AndFontSize:12 size:CGSizeMake(IPHONE_WIDTH / 3, 12 * ScaleY_Num)].width) / 2, 5 * ScaleY_Num, [NSString getSizeByString:_lab_time.text AndFontSize:12 size:CGSizeMake(IPHONE_WIDTH / 3, 12 * ScaleY_Num)].width + 10 * ScaleX_Num, 12 * ScaleY_Num);
        _lab_time.textColor = FFFFFF;
        _lab_time.backgroundColor = C999999;
        _lab_time.font = UIFONT_SYS(12);
        _lab_time.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lab_time];
        
        self.headerView = [[UIImageView alloc] init];
        _headerView.backgroundColor = C666666;
        _headerView.image = [UIImage imageNamed:@""];
        [self addSubview:_headerView];
        
        self.conversationView = [[UIImageView alloc] init];
        [self addSubview:_conversationView];
        self.messageWidth = @"10";
        _headerView.frame = CGRectMake(10 * ScaleX_Num,CGRectGetMaxY(self.lab_time.frame) + 20 * ScaleY_Num / 2, 30 * ScaleX_Num, 30 * ScaleX_Num);
        self.lab_name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headerView.frame) + 5 * ScaleX_Num, CGRectGetMaxY(self.lab_time.frame) + 6 * ScaleY_Num, IPHONE_WIDTH / 2, 12 * ScaleY_Num)];
        _lab_name.text = @"吴梓杭1111";
        _lab_name.textColor = C999999;
        _lab_name.font = UIFONT_SYS(10);
        [self addSubview:_lab_name];
        self.thumbnailView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerView.frame) + 3 * ScaleX_Num, CGRectGetMaxY(_lab_name.frame) + 1* ScaleY_Num, 100 * ScaleX_Num, 100 * ScaleY_Num)];
        self.thumbnailView.backgroundColor = C666666;
        [self addSubview:_thumbnailView];
        
        self.btn_picture = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_picture.frame = CGRectMake(CGRectGetMaxX(self.headerView.frame) + 3 * ScaleX_Num, CGRectGetMaxY(_lab_name.frame) + 1* ScaleY_Num, 100 * ScaleX_Num, 100 * ScaleY_Num);
        [self addSubview:_btn_picture];
        
        //button长按事件
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickChatMessageLongBtn:)];
        longPress.minimumPressDuration = 1.0; //定义按的时间
        [_btn_picture addGestureRecognizer:longPress];
        [self addSubview:_btn_picture];
        
        
    }
    return self;
}
-(void)initWithTime:(NSString *)timeStr HeaderStr:(NSString *)headerStr Name:(NSString *)nameStr Guest:(NSString *)guestStr thumbnailStr:(NSString *)thumbnailStr thumbnailImage:(UIImage *)thumbnailImage pictureBool:(NSString *)pictureBool PictureTag:(NSInteger)pictureTag{
    if ([timeStr isEqualToString:@" "]) {
        _lab_time.frame = CGRectMake(0, 5 * ScaleY_Num, 0, 0);
    }else{
        self.timeDate = [NSDate timeStringToDate:timeStr];
        NSString *requiredString = [_timeDate dateToRequiredString1];
        _lab_time.text = requiredString;
        _lab_time.frame = CGRectMake((IPHONE_WIDTH - [NSString getSizeByString:_lab_time.text AndFontSize:12 size:CGSizeMake(IPHONE_WIDTH / 3, 12 * ScaleY_Num)].width) / 2, 5 * ScaleY_Num, [NSString getSizeByString:_lab_time.text AndFontSize:12 size:CGSizeMake(IPHONE_WIDTH / 3, 12 * ScaleY_Num)].width + 10 * ScaleX_Num, 12 * ScaleY_Num);
    }
    
    NSString * imageStr = headerStr;
    if ([imageStr isKindOfClass:[NSNull class]] || imageStr.length == 0) {
        self.headerView.image = [UIImage imageNamed:@"default_head"];
    }else{
        NSURL * headerUrl = [NSURL URLWithString:imageStr];
        UIImage * headerImage = [UIImage imageNamed:@"default_head"];
        [_headerView sd_setImageWithURL:headerUrl placeholderImage:headerImage options:SDWebImageRefreshCached];
    }
    if ([guestStr intValue] == 1) {
        _lab_name.text = nameStr;
        _headerView.frame = CGRectMake(10 * ScaleX_Num,CGRectGetMaxY(self.lab_time.frame) + 10 * ScaleY_Num, 30 * ScaleX_Num, 30 * ScaleX_Num);

        _thumbnailView.frame = CGRectMake(CGRectGetMaxX(self.headerView.frame) + 3 * ScaleX_Num, CGRectGetMaxY(_lab_name.frame) + 1* ScaleY_Num, 100 * ScaleX_Num, 100 * ScaleY_Num);
        _btn_picture.frame = CGRectMake(CGRectGetMaxX(self.headerView.frame) + 3 * ScaleX_Num, CGRectGetMaxY(_lab_name.frame) + 1* ScaleY_Num, 100 * ScaleX_Num, 100 * ScaleY_Num);
        _thumbnailView.layer.cornerRadius = 5.0f;
        _thumbnailView.layer.masksToBounds = YES;
        if ([pictureBool isEqualToString:@"2"]) {
            _thumbnailView.image = thumbnailImage;
        }else if ([pictureBool isEqualToString:@"1"]) {
            if ([thumbnailStr isKindOfClass:[NSNull class]] || thumbnailStr.length == 0) {
                self.thumbnailView.image = [UIImage imageNamed:@"no_image"];
            }else{
                NSURL * headerUrl = [NSURL URLWithString:thumbnailStr];
                UIImage * headerImage = [UIImage imageNamed:@"image_loading"];
                [_thumbnailView sd_setImageWithURL:headerUrl placeholderImage:headerImage options:SDWebImageRefreshCached];
            }
        }
        
    }else{
        _lab_name.text = @"";
        _thumbnailView.frame = CGRectMake(IPHONE_WIDTH - 145 * ScaleX_Num, CGRectGetMaxY(self.lab_time.frame) + 10 * ScaleY_Num, 100 * ScaleX_Num, 100 * ScaleY_Num);
        _btn_picture.frame = CGRectMake(IPHONE_WIDTH - 145 * ScaleX_Num, CGRectGetMaxY(self.lab_time.frame) + 10 * ScaleY_Num, 100 * ScaleX_Num, 100 * ScaleY_Num);
        _thumbnailView.layer.cornerRadius = 5.0f;
        _thumbnailView.layer.masksToBounds = YES;
        if ([pictureBool isEqualToString:@"2"]) {
            _thumbnailView.image = thumbnailImage;
        }else if ([pictureBool isEqualToString:@"1"]) {
            if ([thumbnailStr isKindOfClass:[NSNull class]] || thumbnailStr.length == 0) {
                self.thumbnailView.image = [UIImage imageNamed:@"no_image"];
            }else{
                NSURL * headerUrl = [NSURL URLWithString:thumbnailStr];
                UIImage * headerImage = [UIImage imageNamed:@"image_loading"];
                [_thumbnailView sd_setImageWithURL:headerUrl placeholderImage:headerImage options:SDWebImageRefreshCached];
            }
        }
        _headerView.frame = CGRectMake(IPHONE_WIDTH - 40 * ScaleX_Num,CGRectGetMaxY(self.lab_time.frame) + 10 * ScaleY_Num, 30 * ScaleX_Num, 30 * ScaleX_Num);
    }
    _btn_picture.tag = 501 + pictureTag;
    [_btn_picture addTarget:self action:@selector(clickPictureBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.tag = 601 + pictureTag;
}

-(void)clickPictureBtn:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(PictureOriginalClicked:)]) {
        [self.delegate PictureOriginalClicked:sender];
    }
}
-(void)clickChatMessageLongBtn:(UILongPressGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(ChatMessageClicked:)]) {
            [self.delegate ChatMessageClicked:gestureRecognizer];
        }
    }
}

@end
