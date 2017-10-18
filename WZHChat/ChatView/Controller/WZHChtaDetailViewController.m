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


@interface WZHChtaDetailViewController () <UITextViewDelegate,WZHToolBarDelegate,WZHEmotionViewdelegate,WZHMoreWayDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic ,strong)UITextView *textView;
@property(nonatomic ,strong)UIButton *emotionBtn;
@property(nonatomic,strong)WZHEmotionView *emotionview;
@property(nonatomic,strong)WZHToolbarView *toolBarView;
@property(nonatomic,strong)WZHMoreView * moreView;
@property(assign,nonatomic)CGFloat keyBoardH;
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)NSMutableArray *dataSourceArray;
@property(nonatomic,strong)UIButton * btn_press;

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
-(UIImageView *)moreView{
    if (!_moreView) {
        self.moreView = [[WZHMoreView alloc] init];
        _moreView.userInteractionEnabled = YES;
        _moreView.delegate = self;
        [self.view addSubview:_moreView];
        
    }
    return _moreView;
}


-(NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    [self creatToolBar];
    [self setNoti];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    self.emotionview.IputView = self.toolBarView.textView;
}

-(void)creatTableView
{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT - NAV_HEIGHT -self.toolBarView.height)];
    self.tableView = tableview;
    tableview.backgroundColor = [UIColor orangeColor];
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
    CGRect keyBoardFrame = [[(NSDictionary *)noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
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
    self.keyBoardH = 0;
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
    
    _btn_press = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_press.layer.cornerRadius = 8;
    _btn_press.layer.borderWidth = 0.5f;
    _btn_press.layer.borderColor = C707070.CGColor;
    _btn_press.backgroundColor = EEEEEE;
    [_btn_press setTitle:@"按住 说话" forState:UIControlStateNormal];
    [_btn_press setTitle:@"松开 结束" forState:UIControlStateHighlighted];
    [_btn_press setTitleColor:C999999 forState:UIControlStateNormal];
    [_btn_press addTarget:self action:@selector(clickPressBtton:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBarView addSubview:_btn_press];
}

-(void)clickPressBtton:(UIButton *)sender{
    
}
#pragma mark - textView代理方法
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.toolBarView.toolBarEmotionBtn.selected = NO;
    self.emotionview.frame = emotionUpFrame;
    [UIView animateWithDuration:0 animations:^{
        self.btn_press.frame = emotionDownFrame;
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
        [self sendMessageWithText:messageText];
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
    if (moreWayBtn.tag == 901) {
        NSLog(@"1111111");
    }
    if (moreWayBtn.tag == 902) {
        NSLog(@"2222222");
    }
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
-(void)sendMessageWithText:(NSString *)text
{
    //text为空时
    if (text.length == 0) {
        //了解一下编码格式
        //text = @"[憨笑]  彩笔，怎么可以输入空格呢？[抓狂]";
    }else{
        WZHCellFrame *model = [self creatNormalMessageWithText:text];
        NSLog(@"text === %@",text);
        [self.dataSourceArray addObject:model];
        self.textView.text = nil;
        [self textViewDidChange:self.textView];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSourceArray.count - 1 inSection:0];
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
    message.type = @"message";
    cellFrame.message = message;
    return cellFrame;
}
#pragma mark - emotionView代理方法

-(void)emotionView_sBtnDidClick:(UIButton *)btn
{
    if (btn.tag == 3456) {
        //解析处理
        NSString *messageText = [[_textView.textStorage getPlainString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //发送按钮事件
        [self sendMessageWithText:messageText];
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
    return self.dataSourceArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"WZHChatCell";
    WZHChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WZHChatViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellFrame = [self.dataSourceArray objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WZHCellFrame *cellFrame = [self.dataSourceArray objectAtIndex:indexPath.row];
    return cellFrame.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
