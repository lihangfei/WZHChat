//
//  WZHChtaDetailViewController.m
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import "WZHChtaDetailViewController.h"
#import "WZHToolbarView.h"
#import "WZHEmotionView.h"
#import "WZHChatMessage.h"
#import "WZHCellFrame.h"
#import "WZHChatViewCell.h"
#import "WZHMoreView.h"
#import "WZHChatService.h"
#import "WZHVoiceMessage.h"
#import "WZHLocalPictureMessage.h"
#import "WZHWebPictureMessage.h"
#import "WZHVoiceTableViewCell.h"
#import "WZHPictureTableViewCell.h"
#import "WZHInformationModel.h"


@interface WZHChtaDetailViewController () <UITextViewDelegate,WZHToolBarDelegate,WZHEmotionViewdelegate,WZHMoreWayDelegate,WZHChatMessageDelegate,WZHPictureOriginalDelegate,WZHVoiceDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property(nonatomic ,strong)UITextView *textView;
@property(nonatomic ,strong)UIButton *emotionBtn;
@property(nonatomic,strong)WZHEmotionView *emotionview;
@property(nonatomic,strong)WZHToolbarView *toolBarView;
@property(nonatomic,strong)WZHMoreView * moreView;
@property(assign,nonatomic)CGFloat keyBoardH;
@property(strong,nonatomic)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray * informationArray;   //个人信息
@property(strong,nonatomic)NSMutableArray *dataSourceArray;        //文本
@property(strong,nonatomic)NSMutableArray * voiceArray;
@property(nonatomic,strong)NSMutableArray * localPictureArray;     //本地图片
@property(nonatomic,strong)NSMutableArray * webPictureArray;    //网络图片
@property(nonatomic,strong)UIView * pressView;
@property(nonatomic,strong)UIButton * btn_press;
@property(nonatomic,strong)UIView * voiceView;
@property(nonatomic,strong)NSMutableArray * albumSelectArr;     //相册已选相片数组
@property(nonatomic,strong)UIImage * cameraSelectImage;          //相机拍照相片
@property(nonatomic,strong)NSMutableArray * chatTypeArray;     //@"text"      @"voice"      @"picture"
@property(nonatomic,assign)float voiceFloat;
@property(nonatomic,strong)UIButton * btn_conversation;
@property(nonatomic,strong)NSMutableArray * pictureBoolArray;       //网络图片：1   本地图片：2    其他：0
@property(nonatomic,assign)CGFloat firstCellHeight;

@property(nonatomic,strong)UIAlertView * alert;
@property(nonatomic,strong)UITapGestureRecognizer * recognizerTap;

@end

@implementation WZHChtaDetailViewController

//懒加载创建表情键盘
-(WZHEmotionView *)emotionview
{
    if (!_emotionview) {
        _emotionview = [[WZHEmotionView alloc]initWithFrame:emotionDownFrame];
        self.emotionview.IputView = self.toolBarView.textView;
        self.emotionview.delegate = self;
        [self.view addSubview:self.emotionview];
    }
    return _emotionview;
}

-(WZHMoreView *)moreView{
    if (!_moreView) {
        self.moreView = [[WZHMoreView alloc] initWithFrame:emotionDownFrame];
        _moreView.userInteractionEnabled = YES;
        _moreView.delegate = self;
        [self.view addSubview:_moreView];
        
    }
    return _moreView;
}
-(NSMutableArray *)informationArray{
    if (!_informationArray) {
        _informationArray = [[NSMutableArray alloc] init];
    }
    return _informationArray;
}

-(NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc] init];
    }
    return _dataSourceArray;
}
-(NSMutableArray *)localPictureArray{
    if (!_localPictureArray) {
        _localPictureArray = [[NSMutableArray alloc] init];
    }
    return _localPictureArray;
}
-(NSMutableArray *)chatTypeArray{
    if (!_chatTypeArray) {
        _chatTypeArray = [[NSMutableArray alloc] init];
    }
    return _chatTypeArray;
}
-(NSMutableArray *)voiceArray{
    if (!_voiceArray) {
        _voiceArray = [[NSMutableArray alloc] init];
    }
    return _voiceArray;
}

-(NSMutableArray *)webPictureArray{
    if (!_webPictureArray) {
        _webPictureArray = [[NSMutableArray alloc] init];
    }
    return _webPictureArray;
}
-(NSMutableArray *)pictureBoolArray{
    if (!_pictureBoolArray) {
        _pictureBoolArray = [[NSMutableArray alloc] init];
    }
    return _pictureBoolArray;
}

- (void)viewDidLoad {
    [WZHChatService sharedInstance].compareTimeStr = @"";
    [super viewDidLoad];
    [self setNoti];
    [self creatTableView];
    [self creatToolBar];
    self.view.backgroundColor = EEEEEE;
    NSInteger a = self.informationArray.count + self.dataSourceArray.count  + self.localPictureArray.count  + self.chatTypeArray.count  + self.voiceArray.count  + self.webPictureArray.count  + self.pictureBoolArray.count;            //解决不执行懒加载
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //录音视图
    self.voiceView = [[UIView alloc] init];
    self.voiceView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.voiceView];
    
}
-(void)viewDidUnload{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.emotionview.IputView = self.toolBarView.textView;
}

-(void)creatTableView
{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT - NAV_HEIGHT -toobarH)];
    self.tableView = tableview;
    tableview.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.delegate = self;
    tableview.backgroundColor = EEEEEE;
    
    [self.view addSubview:tableview];
    // 单击手势用于退出键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTable)];
    tap.delegate = self;
    [tableview addGestureRecognizer:tap];
    
}

-(void)tapTable
{
    [self.textView resignFirstResponder];
    self.toolBarView.toolBarEmotionBtn.selected = NO;
    if (self.textView.text.length == 0) {
        [UIView animateWithDuration:0 animations:^{
            self.emotionview.frame = emotionDownFrame;
            self.toolBarView.frame = toolBarFrameDown;
            self.moreView.frame = emotionDownFrame;
        }];
    }else{
        self.emotionview.frame = emotionDownFrame;
        self.moreView.frame = emotionDownFrame;
        self.toolBarView.frame = CGRectMake(0, IPHONE_HEIGHT - NAV_HEIGHT  - self.toolBarView.height, IPHONE_WIDTH, self.toolBarView.height);
    }
    [UIView animateWithDuration:0 animations:^{
        self.tableView.height = IPHONE_HEIGHT - self.toolBarView.height - NAV_HEIGHT;
    }];
}

-(void)setNoti
{
    // 键盘frame将要改变就会接受到通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // 键盘将要收起时候发出通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

//键盘弹出
-(void)keyboardWillChangeFrame:(NSNotification *)noti
{
    NSValue* aValue = [(NSDictionary *)noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyBoardFrame = [aValue CGRectValue];
    keyBoardFrame = [self.view convertRect:keyBoardFrame fromView:nil];
    
    CGFloat keyboardTop = keyBoardFrame.origin.y;
    CGRect newTextViewFrame = self.view.bounds;
    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [(NSDictionary *)noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    self.tableView.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT - CGRectGetMinY(keyBoardFrame) + 15 * ScaleY_Num);
    //    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height -  self.tableView.frame.size.height) animated:NO];
    
    [UIView commitAnimations];
    
    CGFloat height = keyBoardFrame.origin.y + keyBoardFrame.size.height;
    if (height > IPHONE_HEIGHT) {
        self.toolBarView.toolBarEmotionBtn.selected = YES;
        [UIView animateWithDuration:0 animations:^{
            self.moreView.frame = emotionDownFrame;
            self.emotionview.frame = emotionDownFrame;
            self.toolBarView.frame = CGRectMake(0, IPHONE_HEIGHT - NAV_HEIGHT  - self.toolBarView.height - self.emotionview.height, IPHONE_WIDTH, self.toolBarView.height);
        }];
    }else{
        [UIView animateWithDuration:0 animations:^{
            self.moreView.frame = emotionDownFrame;
            self.toolBarView.frame = CGRectMake(0, IPHONE_HEIGHT - NAV_HEIGHT  - self.toolBarView.height - keyBoardFrame.size.height, IPHONE_WIDTH, self.toolBarView.height);
        }];
    }
    self.keyBoardH = keyBoardFrame.size.height;
}

//键盘弹回
-(void)keyboardWillHide:(NSNotification *)noti
{
    //    self.keyBoardH = 0;
    
    NSValue *animationDurationValue = [(NSDictionary *)noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    self.tableView.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT - NAV_HEIGHT -toobarH);
    
    [UIView commitAnimations];
}

//创建toolbar
-(void)creatToolBar
{
    WZHToolbarView *toolBarView = [[WZHToolbarView alloc]init];
    self.toolBarView = toolBarView;
    toolBarView.textView.delegate = self;
    toolBarView.delegate = self;
    self.textView = toolBarView.textView;
    [self.view addSubview:toolBarView];
    
    //录音
    _btn_press = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_press.layer.cornerRadius = 8;
    _btn_press.layer.borderWidth = 0.5f;
    _btn_press.layer.borderColor = C707070.CGColor;
    _btn_press.backgroundColor = EEEEEE;
    _btn_press.clipsToBounds = YES;
    [_btn_press setTitle:@"按住 说话" forState:UIControlStateNormal];
    [_btn_press setTitle:@"松开 结束" forState:UIControlStateHighlighted];
    [_btn_press setTitleColor:C999999 forState:UIControlStateNormal];
    [_btn_press addTarget:self action:@selector(voiceBtnClickDown:) forControlEvents:UIControlEventTouchDown];
    [_btn_press addTarget:self action:@selector(voiceBtnClickCancel:) forControlEvents:UIControlEventTouchCancel];
    [_btn_press addTarget:self action:@selector(voiceBtnClickUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_btn_press addTarget:self action:@selector(voiceBtnClickDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [_btn_press addTarget:self action:@selector(voiceBtnClickUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    [_btn_press addTarget:self action:@selector(voiceBtnClickDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    [_toolBarView addSubview:_btn_press];
    
}

-(void)clickPressBtton:(UIButton *)sender{
    
}
#pragma mark - textView代理方法
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.toolBarView.toolBarEmotionBtn.selected = NO;
    [UIView animateWithDuration:0 animations:^{
        self.btn_press.frame = emotionDownFrame;
        self.moreView.frame = CGRectMake(0, IPHONE_HEIGHT, 0, 0);
        self.tableView.height = IPHONE_HEIGHT - self.keyBoardH - self.toolBarView.height - NAV_HEIGHT ;
        if (self.tableView.contentSize.height > self.tableView.height) {
            [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height + 3) animated:NO];
        }
    }];
    
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (self.toolBarView.textView.contentSize.height <= TextViewH) {
        self.toolBarView.textView.height = TextViewH;
    }else if (self.toolBarView.textView.contentSize.height >= 90){
        self.toolBarView.textView.height = 90;
    }else{
        self.toolBarView.textView.height = self.toolBarView.textView.contentSize.height;
    }
    self.toolBarView.height = IPHONE_WIDTH * 10 / 320 + self.toolBarView.textView.height;
    if (self.keyBoardH < self.emotionview.height) {
        self.toolBarView.y = IPHONE_HEIGHT - NAV_HEIGHT  - self.toolBarView.height - self.emotionview.height;
    }else{
        self.toolBarView.y = IPHONE_HEIGHT - NAV_HEIGHT  - self.toolBarView.height - self.keyBoardH;
    }
    if (textView.text.length > 0) {
        self.emotionview.sendBtn.selected = YES;
    }else{
        self.emotionview.sendBtn.selected = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        NSString *messageText = [[_textView.textStorage getPlainString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [self sendMessageWithText:messageText TimeStr:@"2017-08-23 23:23:12" NameStr:@"WOHANGO" HeaderStr:@"http://img3.redocn.com/tupian/20150430/mantenghuawenmodianshiliangbeijing_3924704.jpg" GuestStr:[NSString stringWithFormat:@"%d",random_Num] MemberId:@"110"];
        return NO;
    }
    return YES;
}


#pragma mark - ToolBar代理方法
-(void)ToolbarEmotionBtnDidClicked:(UIButton *)emotionBtn
{
    if (emotionBtn.selected) {
        self.toolBarView.toolBarVoiceBtn.selected = YES;
        self.toolBarView.toolBarVoiceBtn.selected = NO;
        self.btn_press.frame = emotionDownFrame;
        emotionBtn.selected = NO;
        [self.textView becomeFirstResponder];
        [UIView animateWithDuration:0 animations:^{
            self.moreView.frame = emotionDownFrame;
            self.tableView.height = IPHONE_HEIGHT - self.keyBoardH - self.toolBarView.height - NAV_HEIGHT;
        }];
        
    }else
    {
        [self.textView resignFirstResponder];
        emotionBtn.selected = YES;
        self.toolBarView.toolBarVoiceBtn.selected = NO;
        self.btn_press.frame = emotionDownFrame;
        [UIView animateWithDuration:0 animations:^{
            self.emotionview.frame = emotionUpFrame;
            self.moreView.frame = emotionDownFrame;
            self.toolBarView.frame = CGRectMake(0, IPHONE_HEIGHT - NAV_HEIGHT  - self.toolBarView.height - self.emotionview.height, IPHONE_WIDTH, self.toolBarView.height);
            self.tableView.height = IPHONE_HEIGHT - self.emotionview.height - self.toolBarView.height - NAV_HEIGHT;
            if (self.tableView.contentSize.height > self.tableView.height) {
                [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height + 3) animated:NO];
            }
        }];
    }
}

-(void)ToolbarVoiceBtnDidClicked:(UIButton *)voiceBtn{
    if (voiceBtn.selected == YES) {
        voiceBtn.selected = NO;
        self.toolBarView.toolBarEmotionBtn.selected = NO;
        self.tableView.height = IPHONE_HEIGHT - self.toolBarView.height - NAV_HEIGHT;
        [self.textView resignFirstResponder];
        [UIView animateWithDuration:0 animations:^{
            self.emotionview.frame = CGRectMake(0, IPHONE_HEIGHT, 0, 0);
            self.moreView.frame = CGRectMake(0, IPHONE_HEIGHT, 0, 0);
            self.toolBarView.frame = CGRectMake(0, IPHONE_HEIGHT - NAV_HEIGHT  - self.toolBarView.height, IPHONE_WIDTH, self.toolBarView.height);
            self.tableView.height = IPHONE_HEIGHT - self.toolBarView.height - NAV_HEIGHT;
            self.btn_press.frame = CGRectMake(0, IPHONE_WIDTH,0, 0);
            if (self.tableView.contentSize.height > self.tableView.height) {
                [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height + 3) animated:NO];
            }
        }];
    }else{
        voiceBtn.selected = YES;
        self.toolBarView.toolBarEmotionBtn.selected = NO;
        [self.textView resignFirstResponder];
        self.tableView.height = IPHONE_HEIGHT - self.toolBarView.height - NAV_HEIGHT;
        [UIView animateWithDuration:0 animations:^{
            self.emotionview.frame = CGRectMake(0, IPHONE_HEIGHT, 0, 0);
            self.moreView.frame = CGRectMake(0, IPHONE_HEIGHT, 0, 0);
            self.toolBarView.frame = CGRectMake(0, IPHONE_HEIGHT - NAV_HEIGHT  - self.toolBarView.height, IPHONE_WIDTH, self.toolBarView.height);
            self.tableView.height = IPHONE_HEIGHT - self.toolBarView.height - NAV_HEIGHT;
            self.btn_press.frame = CGRectMake(30 * ScaleX_Num, IPHONE_WIDTH * 5 / 320, IPHONE_WIDTH - 85 * ScaleX_Num, _textView.size.height);
            if (self.tableView.contentSize.height > self.tableView.height) {
                [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height + 3) animated:NO];
            }
        }];
    }
}
-(void)ToolbarMoreBtnDidClicked:(UIButton *)moreBtn{
    if (moreBtn.selected == YES) {
        moreBtn.selected = NO;
        self.toolBarView.toolBarVoiceBtn.selected = NO;
        self.toolBarView.toolBarEmotionBtn.selected = NO;
        [self.textView resignFirstResponder];
        self.tableView.height = IPHONE_HEIGHT - self.toolBarView.height - NAV_HEIGHT;
        [UIView animateWithDuration:0 animations:^{
            self.emotionview.frame = CGRectMake(0, IPHONE_HEIGHT, 0, 0);
            self.btn_press.frame = CGRectMake(0, IPHONE_WIDTH,0, 0);
            self.moreView.frame = CGRectMake(0, IPHONE_HEIGHT, 0, 0);
            self.toolBarView.frame = CGRectMake(0, IPHONE_HEIGHT - NAV_HEIGHT  - self.toolBarView.height, IPHONE_WIDTH, self.toolBarView.height);
            self.tableView.height = IPHONE_HEIGHT - self.toolBarView.height - NAV_HEIGHT;
            if (self.tableView.contentSize.height > self.tableView.height) {
                [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height + 3) animated:NO];
            }
        }];
    }else{
        moreBtn.selected = YES;
        self.toolBarView.toolBarVoiceBtn.selected = NO;
        self.toolBarView.toolBarEmotionBtn.selected = NO;
        [self.textView resignFirstResponder];
        [UIView animateWithDuration:0 animations:^{
            self.moreView.frame = emotionUpFrame;
            self.emotionview.frame = CGRectMake(0, IPHONE_HEIGHT, 0, 0);
            self.btn_press.frame = CGRectMake(0, IPHONE_WIDTH,0, 0);
            self.toolBarView.frame = CGRectMake(0, IPHONE_HEIGHT - NAV_HEIGHT  - self.toolBarView.height - self.moreView.height, IPHONE_WIDTH, self.toolBarView.height);
            self.tableView.height = IPHONE_HEIGHT - self.moreView.height - self.toolBarView.height - NAV_HEIGHT;
            if (self.tableView.contentSize.height > self.tableView.height) {
                [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height + 3) animated:NO];
            }
        }];
    }
}
-(void)MoreWayBtnDidClicked:(UIButton *)moreWayBtn{
    LLImagePickerView * pickerV = [[LLImagePickerView alloc] init];
    pickerV.showDelete = YES;
    pickerV.showAddButton = YES;
    //自定义从本地相册中所选取的最大数量 11
    pickerV.maxImageSelected = 9 ;
    //如果不希望已经选择的图片或视频，再次被选择，那么可以设置为 NO
    pickerV.allowMultipleSelection = NO;
    //如果希望在选择图片的时候，出现视频资源，那么可以设置为 YES
    pickerV.allowPickingVideo = NO;
    if (moreWayBtn.tag == 901) {
        [pickerV openAlbum];
        [pickerV observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
            for (LLImagePickerModel *model in list) {
                // 在这里取到模型的数据
                NSLog(@"%@",model.image);
                [self sendLocalPictureMessageWithLocalStr:@"1" OriginalImage:model.image ThumbnailImage:model.image TimeStr:@"2017-08-23 23:23:12" NameStr:@"WOHANGO" HeaderStr:@"http://img3.redocn.com/tupian/20150430/mantenghuawenmodianshiliangbeijing_3924704.jpg" GuestStr:[NSString stringWithFormat:@"%d",random_Num] MemberId:@"110"];
                
            }
        }];
    }
    if (moreWayBtn.tag == 902) {
        [pickerV openCamera];
        [pickerV observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
            for (LLImagePickerModel *model in list) {
                // 在这里取到模型的数据
                NSLog(@"%@",model.image);
                self.cameraSelectImage = model.image;
                [self sendLocalPictureMessageWithLocalStr:@"1" OriginalImage:model.image ThumbnailImage:model.image TimeStr:@"2017-08-23 23:23:12" NameStr:@"WOHANGO" HeaderStr:@"http://img3.redocn.com/tupian/20150430/mantenghuawenmodianshiliangbeijing_3924704.jpg" GuestStr:[NSString stringWithFormat:@"%d",random_Num] MemberId:@"110"];
            }
        }];
        NSLog(@"2222222");
    }
    [self.view addSubview:pickerV];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)backBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

///发送文本消息
-(void)sendMessageWithText:(NSString *)text TimeStr:(NSString *)timeStr NameStr:(NSString *)nameStr HeaderStr:(NSString *)headerStr GuestStr:(NSString *)gustStr MemberId:(NSString *)memberId
{
    //text为空时
    if (text.length != 0) {
        WZHInformationModel * infomationModel = [[WZHInformationModel alloc] init];
        infomationModel.timeStr = timeStr;
        infomationModel.nameStr = nameStr;
        infomationModel.headerStr = headerStr;
        infomationModel.guestStr = gustStr;
        infomationModel.memberIdStr = memberId;
        [_informationArray addObject:infomationModel];
        
        WZHCellFrame *model = [self creatNormalMessageWithText:text];
        WZHVoiceMessage * voiceModel = [[WZHVoiceMessage alloc] init];
        WZHLocalPictureMessage * localModel = [[WZHLocalPictureMessage alloc] init];
        WZHWebPictureMessage * webModel = [[WZHWebPictureMessage alloc] init];
        NSLog(@"text === %@",text);
        [self.dataSourceArray addObject:model];
        [self.chatTypeArray addObject:@"text"];
        [self.voiceArray addObject:voiceModel];
        [self.localPictureArray addObject:localModel];
        [self.webPictureArray addObject:webModel];
        [self.pictureBoolArray addObject:@"0"];
        self.textView.text = nil;
        [self textViewDidChange:self.textView];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatTypeArray.count - 1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

///创建消息模型添加到数据源数组
-(WZHCellFrame *)creatNormalMessageWithText:(NSString *)text
{
    WZHCellFrame *cellFrame = [[WZHCellFrame alloc]init];
    WZHChatMessage *message = [[WZHChatMessage alloc]init];
    message.text = text;
    cellFrame.message = message;
    return cellFrame;
}
//发送语音消息
-(void)sendVoiceMessageWithFilePathStr:(NSString *)filePathStr VoiceTimeStr:(NSString *)voiceTimeStr TimeStr:(NSString *)timeStr NameStr:(NSString *)nameStr HeaderStr:(NSString *)headerStr GuestStr:(NSString *)gustStr MemberId:(NSString *)memberId{
    WZHInformationModel * infomationModel = [[WZHInformationModel alloc] init];
    infomationModel.timeStr = timeStr;
    infomationModel.nameStr = nameStr;
    infomationModel.headerStr = headerStr;
    infomationModel.guestStr = gustStr;
    infomationModel.memberIdStr = memberId;
    [_informationArray addObject:infomationModel];
    
    WZHCellFrame *model = [[WZHCellFrame alloc] init];
    WZHVoiceMessage * voiceModel = [[WZHVoiceMessage alloc] init];
    WZHLocalPictureMessage * localModel = [[WZHLocalPictureMessage alloc] init];
    WZHWebPictureMessage * webModel = [[WZHWebPictureMessage alloc] init];
    voiceModel.filePathStr = filePathStr;
    voiceModel.voiceTimeStr = voiceTimeStr;
    [_voiceArray addObject:voiceModel];
    [_chatTypeArray addObject:@"voice"];
    [_dataSourceArray addObject:model];
    [_localPictureArray addObject:localModel];
    [_webPictureArray addObject:webModel];
    [_pictureBoolArray addObject:@"0"];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatTypeArray.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
//发送本地图片消息
-(void)sendLocalPictureMessageWithLocalStr:(NSString *)localStr OriginalImage:(UIImage *)originalImage ThumbnailImage:(UIImage *)thumbnailImage TimeStr:(NSString *)timeStr NameStr:(NSString *)nameStr HeaderStr:(NSString *)headerStr GuestStr:(NSString *)gustStr MemberId:(NSString *)memberId{
    WZHInformationModel * infomationModel = [[WZHInformationModel alloc] init];
    infomationModel.timeStr = timeStr;
    infomationModel.nameStr = nameStr;
    infomationModel.headerStr = headerStr;
    infomationModel.guestStr = gustStr;
    infomationModel.memberIdStr = memberId;
    [_informationArray addObject:infomationModel];
    
    WZHCellFrame *model = [[WZHCellFrame alloc] init];
    WZHVoiceMessage * voiceModel = [[WZHVoiceMessage alloc] init];
    WZHLocalPictureMessage * localModel = [[WZHLocalPictureMessage alloc] init];
    WZHWebPictureMessage * webModel = [[WZHWebPictureMessage alloc] init];localModel.originalImage = originalImage;
    localModel.thumbnailImage = thumbnailImage;
    [_voiceArray addObject:voiceModel];
    [_chatTypeArray addObject:@"picture"];
    [_dataSourceArray addObject:model];
    [_localPictureArray addObject:localModel];
    [_webPictureArray addObject:webModel];
    [_pictureBoolArray addObject:@"2"];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatTypeArray.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}
//发送网络图片消息
-(void)sendWebPictureMessageWithLocalStr:(NSString *)localStr OriginalStr:(NSString *)originalStr ThumbnailStr:(NSString *)thumbnailStr TimeStr:(NSString *)timeStr NameStr:(NSString *)nameStr HeaderStr:(NSString *)headerStr GuestStr:(NSString *)gustStr MemberId:(NSString *)memberId{
    WZHInformationModel * infomationModel = [[WZHInformationModel alloc] init];
    infomationModel.timeStr = timeStr;
    infomationModel.nameStr = nameStr;
    infomationModel.headerStr = headerStr;
    infomationModel.guestStr = gustStr;
    infomationModel.memberIdStr = memberId;
    [_informationArray addObject:infomationModel];
    
    WZHCellFrame *model = [[WZHCellFrame alloc] init];
    WZHVoiceMessage * voiceModel = [[WZHVoiceMessage alloc] init];
    WZHLocalPictureMessage * localModel = [[WZHLocalPictureMessage alloc] init];
    WZHWebPictureMessage * webModel = [[WZHWebPictureMessage alloc] init];
    webModel.originalStr = originalStr;
    webModel.thumbnailStr = thumbnailStr;
    [_voiceArray addObject:voiceModel];
    [_chatTypeArray addObject:@"picture"];
    [_dataSourceArray addObject:model];
    [_localPictureArray addObject:localModel];
    [_webPictureArray addObject:webModel];
    [_pictureBoolArray addObject:@"1"];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatTypeArray.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}
#pragma mark - emotionView代理方法

-(void)emotionView_sBtnDidClick:(UIButton *)btn
{
    if (btn.tag == 3456) {
        //解析处理
        NSString *messageText = [[_textView.textStorage getPlainString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //发送按钮事件
        [self sendMessageWithText:messageText TimeStr:@"2017-08-23 23:23:12" NameStr:@"WOHANGO" HeaderStr:@"http://img3.redocn.com/tupian/20150430/mantenghuawenmodianshiliangbeijing_3924704.jpg" GuestStr:@"1" MemberId:@"110"];
    }else{
        [self textViewDidChange:self.textView];
        //判断输入框有内容让发送按钮变颜色
        if (self.emotionview.IputView.text.length > 0) {
            self.emotionview.sendBtn.selected = YES;
        }else{
            self.emotionview.sendBtn.selected = NO;
        }
    }
}

#pragma mark - tableview代理方法和数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chatTypeArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * typeStr = [NSString stringWithFormat:@"%@",_chatTypeArray[indexPath.row]];
    if ([typeStr isEqualToString:@"revocation"]) {
        static NSString * revocationID = @"revocationCell";
        UITableViewCell * revocationCell = [tableView dequeueReusableCellWithIdentifier:revocationID];
        if (!revocationCell) {
            revocationCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:revocationID];
        }
        UILabel * lab_revocation = [[UILabel alloc] init];
        lab_revocation.text = @"你撤回了一条消息";
        lab_revocation.textColor = FFFFFF;
        lab_revocation.backgroundColor = C999999;
        lab_revocation.frame = CGRectMake((IPHONE_WIDTH - [NSString getSizeByString:lab_revocation.text AndFontSize:12 size:CGSizeMake(IPHONE_WIDTH, 12 * ScaleY_Num)].width) / 2, 5 * ScaleY_Num, [NSString getSizeByString:lab_revocation.text AndFontSize:12 size:CGSizeMake(IPHONE_WIDTH, 12 * ScaleY_Num)].width, 12 * ScaleY_Num);
        [revocationCell addSubview:lab_revocation];
    }
    if ([typeStr isEqualToString:@"text"]) {
        static NSString *ID = @"WZHChatCell";
        WZHChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[WZHChatViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        NSInteger i = indexPath.row;
        [cell initWithTime:[_informationArray valueForKey:@"timeStr"][i] HeaderStr:[_informationArray valueForKey:@"headerStr"][i] Name:[_informationArray valueForKey:@"nameStr"][i] Guest:[_informationArray valueForKey:@"guestStr"][i] MessageWidth:[_dataSourceArray valueForKey:@"messageWidth"][i] MessageHight:[_dataSourceArray valueForKey:@"messageHight"][i] ChatMessageTag:i];
        [cell setCellFrame:[_dataSourceArray objectAtIndex:i]];
        cell.delegate = self;
        cell.backgroundColor = EEEEEE;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.firstCellHeight = cell.lab_time.frame.size.height + cell.lab_name.frame.size.height + cell.conversationView.frame.size.height + 31 * ScaleY_Num;
        return cell;
    }
    
    else if([typeStr isEqualToString:@"voice"]) {
        static NSString * VoiceID = @"WZHVoiceCell";
        WZHVoiceTableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:VoiceID];
        if (!firstCell) {
            firstCell = [[WZHVoiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VoiceID];
        }
        NSInteger j = indexPath.row;
        [firstCell initWithTimeStr:[_informationArray valueForKey:@"timeStr"][j] HeaderStr:[_informationArray valueForKey:@"headerStr"][j] NameStr:[_informationArray valueForKey:@"nameStr"][j] CurrentRecordTime:[_voiceArray valueForKey:@"voiceTimeStr"][j] Guest:[_informationArray valueForKey:@"guestStr"][j] RecordTag:j];
        firstCell.backgroundColor = EEEEEE;
        firstCell.delegate = self;
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return firstCell;
    }else if([typeStr isEqualToString:@"picture"]) {
        static NSString * pictureID = @"WZHPictureCell";
        WZHPictureTableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:pictureID];
        if (!secondCell) {
            secondCell = [[WZHPictureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pictureID];
        }
        secondCell.backgroundColor = EEEEEE;
        NSInteger k = indexPath.row;
        NSString * pictureBoolStr = [NSString stringWithFormat:@"%@",_pictureBoolArray[k]];
        NSLog(@"pictureBoolStr === %@",pictureBoolStr);
        if ([pictureBoolStr isEqualToString:@"1"]) {
            [secondCell initWithTime:[_informationArray valueForKey:@"timeStr"][k] HeaderStr:[_informationArray valueForKey:@"headerStr"][k] Name:[_informationArray valueForKey:@"nameStr"][k] Guest:[_informationArray valueForKey:@"guestStr"][k] thumbnailStr:[_webPictureArray valueForKey:@"thumbnailStr"][k] thumbnailImage:nil pictureBool:@"1" PictureTag:k];
        }else if ([pictureBoolStr isEqualToString:@"2"]){
            [secondCell initWithTime:[_informationArray valueForKey:@"timeStr"][k] HeaderStr:[_informationArray valueForKey:@"headerStr"][k] Name:[_informationArray valueForKey:@"nameStr"][k] Guest:[_informationArray valueForKey:@"guestStr"][k] thumbnailStr:@"local" thumbnailImage:[_localPictureArray valueForKey:@"thumbnailImage"][k] pictureBool:@"2" PictureTag:k];
        }
        secondCell.delegate = self;
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return secondCell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * typeStr = [NSString stringWithFormat:@"%@",_chatTypeArray[indexPath.row]];
    if ([typeStr isEqualToString:@"revocation"]) {
        return 22 * ScaleY_Num;
    }if ([typeStr isEqualToString:@"text"]) {
        WZHCellFrame *cellFrame = [self.dataSourceArray objectAtIndex:indexPath.row];
        return cellFrame.cellHeight + 45 * ScaleY_Num;
    }else if([typeStr isEqualToString:@"voice"]){
        return 70 * ScaleY_Num;
    }
    return 140 * ScaleY_Num;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark ----- 图片放大
-(void)PictureOriginalClicked:(UIButton *)pictureBtn{
    NSLog(@"%ld",pictureBtn.tag);
    NSInteger k = pictureBtn.tag - 501;
    NSString * pictureBoolStr = [NSString stringWithFormat:@"%@",_pictureBoolArray[k]];
    if ([pictureBoolStr isEqualToString:@"1"]) {
        [[XLImageViewer shareInstanse] showNetImages:@[[_webPictureArray valueForKey:@"originalStr"][k]] index:0 fromImageContainer:0];
    }else if ([pictureBoolStr isEqualToString:@"2"]){
        UIImage * m_imgFore = [_localPictureArray valueForKey:@"originalImage"][k];
        //png格式
        NSData * imagedata = UIImagePNGRepresentation(m_imgFore);
        //JEPG格式
        //NSData * imagedata = UIImageJEPGRepresentation(m_imgFore, 1.0);
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * documentsDirectory = [paths objectAtIndex:0];
        NSString * savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.png",(int)[NSDate date].timeIntervalSince1970]];
        [imagedata writeToFile:savedImagePath atomically:YES];
        [[XLImageViewer shareInstanse] showLocalImages:@[savedImagePath] index:0 fromImageContainer:0];
    }
}
#pragma mark ----- 语音播放
-(void)VoiceClicked:(UIButton *)voiceBtn{
    voiceBtn.selected = !voiceBtn.selected;
    NSString * tagStr = [NSString stringWithFormat:@"%04ld",voiceBtn.tag - 501];
    NSString * imageNumStr = [tagStr substringToIndex:tagStr.length - 2];
    NSString * arrayStr = [tagStr substringFromIndex:tagStr.length - 2];
    
    //    if (voiceBtn.selected == YES) {
    //        if ([imageNumStr intValue] == 0) {
    //            voiceBtn.imageView.animationImages = @[[UIImage imageNamed:@"right-3"],
    //                                                   [UIImage imageNamed:@"right-1"],
    //                                                   [UIImage imageNamed:@"right-2"]
    //                                                   ];
    //            voiceBtn.imageView.animationDuration = 0.6;
    //            [voiceBtn.imageView startAnimating];
    //        }else if ([imageNumStr intValue] == 1){
    //            voiceBtn.imageView.animationImages = @[[UIImage imageNamed:@"left-3"],
    //                                                   [UIImage imageNamed:@"left-1"],
    //                                                   [UIImage imageNamed:@"left-2"]
    //                                                   ];
    //            voiceBtn.imageView.animationDuration = 0.6;
    //            [voiceBtn.imageView startAnimating];
    //        }
    //    }else{
    //        if ([imageNumStr intValue] == 0) {
    //            voiceBtn.imageView.animationImages = @[[UIImage imageNamed:@"right-3"]];
    //        }else if ([imageNumStr intValue] == 1){
    //            voiceBtn.imageView.animationImages = @[[UIImage imageNamed:@"left-3"]];
    //        }
    //    }
    
    if ([_player isPlaying]) {
        [_player stop];
        _player = nil;
    }
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[_voiceArray valueForKey:@"filePathStr"][[arrayStr intValue]]] error:nil];
    if ([_player isPlaying]) {
        return;
    }
    [_player play];
}

#pragma mark ----- 复制撤销删除收藏
-(void)ChatMessageClicked:(UILongPressGestureRecognizer *)longBtn{
    self.alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"撤回",@"删除", nil];
    [_alert show];
    self.recognizerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
    
    [_recognizerTap setNumberOfTapsRequired:1];
    _recognizerTap.cancelsTouchesInView = NO;
    [[UIApplication sharedApplication].keyWindow addGestureRecognizer:_recognizerTap];
    
}
- (void)handleTapBehind:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded){
        CGPoint location = [sender locationInView:nil];
        if (![_alert pointInside:[_alert convertPoint:location fromView:_alert.window] withEvent:nil]){
            [_alert.window removeGestureRecognizer:sender];
            [_alert dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
}
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"@22222222222222");
        
    }
    if (buttonIndex == 2) {
        NSLog(@"444444444444444");
        
    }
}

#pragma mark ----- 语音
-(void)voiceBtnClickDown:(UIButton *)btn{//按下
    _filePath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *name = [NSString stringWithFormat:@"%d.wav",(int)[NSDate date].timeIntervalSince1970];
    _filePath=[_filePath stringByAppendingPathComponent:name];
    
    
    if ([_player isPlaying]) {
        [_player stop];
        _player = nil;
    }
    NSLog(@"按下");
    [btn setTitle:@"松开 结束" forState:UIControlStateNormal];
    NSURL *url=[NSURL fileURLWithPath:_filePath];
    NSDictionary * dict = @{AVFormatIDKey:@(kAudioFormatLinearPCM),
                            AVSampleRateKey:@(8000),
                            AVNumberOfChannelsKey:@(1),
                            AVLinearPCMBitDepthKey:@(8),
                            AVLinearPCMIsFloatKey:@(YES)
                            };
    if (!_session) {
        _session = [AVAudioSession sharedInstance];
        if ([_session respondsToSelector:@selector(requestRecordPermission:)]) {
            [_session performSelector:@selector(requestRecordPermission:) withObject:^(BOOL isTrue){
                if (isTrue) {
                }else{
                    NSLog(@"app需要访问您的麦克风。");
                }
            }];
        }
        [_session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }
    _record = [[AVAudioRecorder alloc]initWithURL:url settings:dict error:nil];
    _record.meteringEnabled = YES;//监听音量大小
    [_record prepareToRecord];
    [_record record];
    
    UIView * recordView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150 * ScaleX_Num, 150 * ScaleY_Num)];
    recordView.layer.cornerRadius = 8.0f;
    recordView.backgroundColor = [UIColor clearColor];
    recordView.tag = 101;
    
    UIImageView * micImg = [[UIImageView alloc]initWithFrame:CGRectMake(25 * ScaleX_Num, -20 * ScaleY_Num,100 * ScaleX_Num, 180 * ScaleY_Num)];
    micImg.contentMode = UIViewContentModeLeft;
    [micImg setImage:[UIImage imageNamed:@"voice_1"]];
    micImg.tag = 135;
    
    self.voiceFloat = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(voiceChange:) userInfo:nil repeats:YES];
    
    UIImageView * micImgCan = [[UIImageView alloc]initWithFrame:CGRectMake(50 * ScaleX_Num, 30 * ScaleY_Num,50 * ScaleX_Num, 70 * ScaleY_Num)];
    micImgCan.image = [UIImage imageNamed:@"cancelVoice"];
    micImgCan.tag = 134;
    
    //    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 130 * ScaleY_Num, 150 * ScaleX_Num, 14 * ScaleY_Num)];
    //    label.tag = 136;
    //    label.textAlignment = NSTextAlignmentCenter;
    //    label.textColor = [UIColor whiteColor];
    //    label.text = @"手指上滑,取消发送";
    //    label.font = UIFONT_SYS(14);
    
    micImgCan.hidden = YES;
    micImg.hidden = NO;
    
    //    [recordView addSubview:label];
    [recordView addSubview:micImg];
    [recordView addSubview:micImgCan];
    [UIView animateWithDuration:0 animations:^{
        self.voiceView.frame = CGRectMake(0, 0, 150 * ScaleX_Num, 150 * ScaleX_Num);
        self.voiceView.center = CGPointMake(IPHONE_WIDTH / 2, (IPHONE_HEIGHT - 2 * NAV_HEIGHT) / 2);
        [self.voiceView addSubview:recordView];
    }];
    //    [self.view addSubview:recordView];
}

-(void)voiceChange:(NSTimer *)timer{
    UIView * view = [self.view viewWithTag:101];
    UIImageView * micImg = [view viewWithTag:135];
    [_record updateMeters];//刷新音量数据
    CGFloat lowPassResults = pow(10, (0.05 * [_record peakPowerForChannel:0]));
    //    NSLog(@"lowPassResults = %f",lowPassResults);
    //  根据音量大小选择显示图片  图片 小-》大
    if (0<lowPassResults<=0.18) {
        [micImg setImage:[UIImage imageNamed:@"voice_1"]];
    }else if (0.18<lowPassResults<=0.36) {
        [micImg setImage:[UIImage imageNamed:@"voice_2"]];
    }else if (0.36<lowPassResults<=0.54) {
        [micImg setImage:[UIImage imageNamed:@"voice_3"]];
    }else if (0.54<lowPassResults<=0.72) {
        [micImg setImage:[UIImage imageNamed:@"voice_4"]];
    }else if (0.72<lowPassResults<=0.90) {
        [micImg setImage:[UIImage imageNamed:@"voice_5"]];
    }else if (0.90<lowPassResults) {
        [micImg setImage:[UIImage imageNamed:@"voice_6"]];
    }
    //    else if (0.84<lowPassResults) {
    //        [micImg setImage:[UIImage imageNamed:@"chat_microphone_7"]];
    //    }
    _voiceFloat = _voiceFloat + 0.1;
}


-(void)voiceBtnClickCancel:(UIButton *)btn{//意外取消
    
    [UIView animateWithDuration:0 animations:^{
        self.voiceView.frame = emotionDownFrame;
    }];
    NSLog(@"意外取消");
    [btn setTitle:@"松开 结束" forState:UIControlStateNormal];
    UIView * view = [self.view viewWithTag:101];
    [view removeFromSuperview];
    if ([_record isRecording]) {
        [_record stop];
        [_record deleteRecording];
    }
    
    _record = nil;
    if (_timer.isValid) {//判断timer是否在线程中
        [_timer invalidate];
    }
    _timer=nil;
}
-(void)voiceBtnClickUpInside:(UIButton *)btn{//点击(录音完成)
    [UIView animateWithDuration:0 animations:^{
        self.voiceView.frame = emotionDownFrame;
    }];
    NSLog(@"_filePath === %@  count == %f",_filePath,_voiceFloat);
    int result = (int)roundf(_voiceFloat);      //时间四舍五入
    if (result < 1) {
        
    }else{
        [self sendVoiceMessageWithFilePathStr:_filePath VoiceTimeStr:[NSString stringWithFormat:@"%d",result] TimeStr:@"2017-08-23 23:23:12" NameStr:@"WOHANGO" HeaderStr:@"http://img3.redocn.com/tupian/20150430/mantenghuawenmodianshiliangbeijing_3924704.jpg" GuestStr:[NSString stringWithFormat:@"%d",random_Num] MemberId:@"110"];
    }
    NSLog(@"点击");
    [btn setTitle:@"按住 说话" forState:UIControlStateNormal];
    UIView * view = [self.view viewWithTag:101];
    [view removeFromSuperview];
    [_record stop];
    if (_timer.isValid) {
        [_timer invalidate];
    }
    _timer=nil;
    
}
-(void)voiceBtnClickDragExit:(UIButton *)btn{//拖出
    [UIView animateWithDuration:0 animations:^{
        self.voiceView.frame = emotionDownFrame;
    }];
    NSLog(@"拖出");
    [btn setTitle:@"按住 说话" forState:UIControlStateNormal];
    UIView * view = [self.view viewWithTag:101];
    UIImageView * micImg = [view viewWithTag:135];
    micImg.hidden = YES;
    UIImageView * micImgCan = [view viewWithTag:134];
    micImgCan.hidden = NO;
    
    UILabel * alertLab = [view viewWithTag:136];
    alertLab.backgroundColor = [UIColor colorWithRed:255/255.0 green:128/255.0 blue:158/255.0 alpha:1];
    
}
-(void)voiceBtnClickUpOutside:(UIButton *)btn{//外部手势抬起
    [UIView animateWithDuration:0 animations:^{
        self.voiceView.frame = emotionDownFrame;
    }];
    NSLog(@"外部手势抬起");
    [btn setTitle:@"按住 说话" forState:UIControlStateNormal];
    UIView * view = [self.view viewWithTag:101];
    [view removeFromSuperview];
    if ([_record isRecording]) {
        [_record stop];
        [_record deleteRecording];
    }
    _record = nil;
    
    if (_timer.isValid) {
        [_timer invalidate];
    }
    _timer=nil;
    
}

-(void)voiceBtnClickDragEnter:(UIButton *)btn{//拖回
    [UIView animateWithDuration:0 animations:^{
        self.voiceView.frame = emotionDownFrame;
    }];
    NSLog(@"拖回");
    [btn setTitle:@"松开 结束" forState:UIControlStateNormal];
    UIView * view = [self.view viewWithTag:101];
    UIImageView * micImg = [view viewWithTag:135];
    micImg.hidden = NO;
    
    UIImageView * micImgCan = [view viewWithTag:134];
    micImgCan.hidden = YES;
    
    UILabel * alertLab = [view viewWithTag:136];
    alertLab.backgroundColor = [UIColor clearColor];
    
}

@end



