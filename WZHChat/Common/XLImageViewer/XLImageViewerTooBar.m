//
//  XLImageViewerTooBar.m
//  XLImageViewerDemo
//
//  Created by MengXianLiang on 2017/4/20.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "XLImageViewerTooBar.h"

@implementation XLImageViewerTooBar{
    
    UILabel *_pageLabel;
    
    UIButton *_saveButton;
    
    VoidBlock _saveBlock;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    //显示分页的label
    CGFloat viewWidth = 50.0f;
    CGFloat viewHeignt = 28.0f;
    CGFloat viewMargin = 5.0f;
    _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewMargin, 0, viewWidth, viewHeignt)];
    _pageLabel.center = CGPointMake(_pageLabel.center.x, viewHeignt/2.0f);
//    _pageLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    _pageLabel.layer.cornerRadius = 5.0f;
    _pageLabel.layer.masksToBounds = true;
    _pageLabel.textColor = [UIColor whiteColor];
    _pageLabel.font = [UIFont systemFontOfSize:16];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_pageLabel];
    
    //保存按钮
    _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveButton.frame = CGRectMake(self.bounds.size.width - viewWidth - viewMargin - 20, 0, viewWidth + 20, viewHeignt);
    _saveButton.center = CGPointMake(_saveButton.center.x, viewHeignt/2.0f);
    _saveButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    _saveButton.layer.cornerRadius = 5.0f;
    _saveButton.layer.masksToBounds = true;
    _saveButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_saveButton setTitle:@"保存图片" forState:UIControlStateNormal];
    _saveButton.titleLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    [_saveButton addTarget:self action:@selector(saveImageMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_saveButton];

    self.alpha = 0;
}

-(void)saveImageMethod{
    _saveBlock();
}

-(void)addSaveBlock:(VoidBlock)saveBlock{
    _saveBlock = saveBlock;
}

-(void)setText:(NSString *)text{
    _pageLabel.text = text;
}

-(void)show{
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1;
    }];
}

-(void)hide{
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0;
    }];
}

@end
