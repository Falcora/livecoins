//
//  LCHUDViewController.m
//  livecoins
//
//  Created by Seth Porter on 2/11/14.
//  Copyright (c) 2014 falcora. All rights reserved.
//

#import "LCHUDViewController.h"
#import <CommonCrypto/CommonHMAC.h>
#import "Base64.h"
#import "SVProgressHUD.h"

#import "UIColor+MoreColors.h"

// Set your keys in these fields

#define coinbaseapikey @""
#define coinbaseapisecret @""

#define cryptsyapikey @""
#define cryptsyapisecret @""

#define multipoolkey @""

#define lcTextColor [UIColor whiteColor]
#define lcWaitingTextColor [UIColor melon]
#define lcBackgroundColor [UIColor clearColor]



#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define h1fontsize IS_IPAD ? 64.0f : 44.0f
#define h2fontsize IS_IPAD ? 42.0f : 32.0f
#define sectionHeaderfontSize IS_IPAD ? 28.0f : 18.0f
#define valuefontSize IS_IPAD ? 32.0f : 24.0f
#define labelfontSize IS_IPAD ? 20.0f : 14.0f


@interface LCHUDViewController ()
{
    // Unified
    UILabel* _totalUSDLabel;
    UILabel* _totalUSDTitleLabel;
    
    UILabel* _BTCValueLabel;
    UILabel* _BTCValueTitleLabel;
    
    // Cryptsy
    UILabel* _CryptsyTitleLabel;
    
    UILabel* _CryptsyBTCBalanceLabel;
    UILabel* _CryptsyBTCBalanceTitleLabel;
    
    UILabel* _DogeBTCRateLabel;
    UILabel* _DogeBTCRateTitleLabel;
    
    UILabel* _DogeBalanceLabel;
    UILabel* _DogeBalanceTitleLabel;
    
    // Coinbase
    UILabel* _CoinbaseTitleLabel;
    
    UILabel* _BTCUSDLabel;
    UILabel* _BTCUSDTitleLabel;
    
    UILabel* _CoinbaseBTCBalanceLabel;
    UILabel* _CoinbaseBTCBalanceTitleLabel;
    
    // Multipool
    UILabel* _MultipoolTitleLabel;
    
    UILabel* _DogeHashrateLabel;
    UILabel* _DogeHashrateTitleLabel;
    
    UILabel* _MultipoolDogeBalanceLabel;
    UILabel* _MultipoolDogeBalanceTitleLabel;
    
    UIButton* _updateButton;
}


@end

@implementation LCHUDViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [self.view setBackgroundColor:[UIColor colorWithRed:52.0f/255.0f green:142.0f/255.0f blue:218.0f/255.0f alpha:1.0f]];
    
    
    
    
    // Header Labels
    
    _totalUSDLabel = [[UILabel alloc] init];
    [_totalUSDLabel setTextColor:lcTextColor];
    [_totalUSDLabel setBackgroundColor:lcBackgroundColor];
    [_totalUSDLabel setText:@"$0.00"];
    [_totalUSDLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:h1fontsize]];
    [_totalUSDLabel setTextAlignment:NSTextAlignmentCenter];
    [_totalUSDLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_totalUSDLabel];
    
    _totalUSDTitleLabel = [[UILabel alloc] init];
    [_totalUSDTitleLabel setTextColor:lcTextColor];
    [_totalUSDTitleLabel setBackgroundColor:lcBackgroundColor];
    [_totalUSDTitleLabel setText:@"Total Value in USD"];
    [_totalUSDTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:labelfontSize]];
    [_totalUSDTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_totalUSDTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_totalUSDTitleLabel];
    
    _BTCValueLabel = [[UILabel alloc] init];
    [_BTCValueLabel setTextColor:lcTextColor];
    [_BTCValueLabel setBackgroundColor:lcBackgroundColor];
    [_BTCValueLabel setText:@"0.00000000"];
    [_BTCValueLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:h2fontsize]];
    [_BTCValueLabel setTextAlignment:NSTextAlignmentCenter];
    [_BTCValueLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_BTCValueLabel];
    
    _BTCValueTitleLabel = [[UILabel alloc] init];
    [_BTCValueTitleLabel setTextColor:lcTextColor];
    [_BTCValueTitleLabel setBackgroundColor:lcBackgroundColor];
    [_BTCValueTitleLabel setText:@"Total Value in BTC"];
    [_BTCValueTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:labelfontSize]];
    [_BTCValueTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_BTCValueTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_BTCValueTitleLabel];
    
    
    
    // Coinbase Views
    _CoinbaseTitleLabel = [[UILabel alloc] init];
    [_CoinbaseTitleLabel setTextColor:lcTextColor];
    [_CoinbaseTitleLabel setBackgroundColor:lcBackgroundColor];
    [_CoinbaseTitleLabel setText:@"Coinbase"];
    [_CoinbaseTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:sectionHeaderfontSize]];
    [_CoinbaseTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_CoinbaseTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_CoinbaseTitleLabel];
    
    _BTCUSDLabel = [[UILabel alloc] init];
    [_BTCUSDLabel setTextColor:lcTextColor];
    [_BTCUSDLabel setBackgroundColor:lcBackgroundColor];
    [_BTCUSDLabel setText:@"0.00"];
    [_BTCUSDLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:valuefontSize]];
    [_BTCUSDLabel setTextAlignment:NSTextAlignmentCenter];
    [_BTCUSDLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_BTCUSDLabel];
    
    _BTCUSDTitleLabel = [[UILabel alloc] init];
    [_BTCUSDTitleLabel setTextColor:lcTextColor];
    [_BTCUSDTitleLabel setBackgroundColor:lcBackgroundColor];
    [_BTCUSDTitleLabel setText:@"BTC/USD"];
    [_BTCUSDTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:labelfontSize]];
    [_BTCUSDTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_BTCUSDTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_BTCUSDTitleLabel];
    
    _CoinbaseBTCBalanceLabel = [[UILabel alloc] init];
    [_CoinbaseBTCBalanceLabel setTextColor:lcTextColor];
    [_CoinbaseBTCBalanceLabel setBackgroundColor:lcBackgroundColor];
    [_CoinbaseBTCBalanceLabel setText:@"0.00000000"];
    [_CoinbaseBTCBalanceLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:valuefontSize]];
    [_CoinbaseBTCBalanceLabel setTextAlignment:NSTextAlignmentCenter];
    [_CoinbaseBTCBalanceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_CoinbaseBTCBalanceLabel];
    
    _CoinbaseBTCBalanceTitleLabel = [[UILabel alloc] init];
    [_CoinbaseBTCBalanceTitleLabel setTextColor:lcTextColor];
    [_CoinbaseBTCBalanceTitleLabel setBackgroundColor:lcBackgroundColor];
    [_CoinbaseBTCBalanceTitleLabel setText:@"BTC Balance"];
    [_CoinbaseBTCBalanceTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:labelfontSize]];
    [_CoinbaseBTCBalanceTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_CoinbaseBTCBalanceTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_CoinbaseBTCBalanceTitleLabel];
    
    
    // Multipool
    
    _MultipoolTitleLabel = [[UILabel alloc] init];
    [_MultipoolTitleLabel setTextColor:lcTextColor];
    [_MultipoolTitleLabel setBackgroundColor:lcBackgroundColor];
    [_MultipoolTitleLabel setText:@"Multipool"];
    [_MultipoolTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:sectionHeaderfontSize]];
    [_MultipoolTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_MultipoolTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_MultipoolTitleLabel];
    
    _DogeHashrateLabel = [[UILabel alloc] init];
    [_DogeHashrateLabel setTextColor:lcTextColor];
    [_DogeHashrateLabel setBackgroundColor:lcBackgroundColor];
    [_DogeHashrateLabel setText:@"0"];
    [_DogeHashrateLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:valuefontSize]];
    [_DogeHashrateLabel setTextAlignment:NSTextAlignmentCenter];
    [_DogeHashrateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_DogeHashrateLabel];
    
    _DogeHashrateTitleLabel = [[UILabel alloc] init];
    [_DogeHashrateTitleLabel setTextColor:lcTextColor];
    [_DogeHashrateTitleLabel setBackgroundColor:lcBackgroundColor];
    [_DogeHashrateTitleLabel setText:@"kH/s"];
    [_DogeHashrateTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:labelfontSize]];
    [_DogeHashrateTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_DogeHashrateTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_DogeHashrateTitleLabel];
    
    _MultipoolDogeBalanceLabel = [[UILabel alloc] init];
    [_MultipoolDogeBalanceLabel setTextColor:lcTextColor];
    [_MultipoolDogeBalanceLabel setBackgroundColor:lcBackgroundColor];
    [_MultipoolDogeBalanceLabel setText:@"0"];
    [_MultipoolDogeBalanceLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:valuefontSize]];
    [_MultipoolDogeBalanceLabel setTextAlignment:NSTextAlignmentCenter];
    [_MultipoolDogeBalanceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_MultipoolDogeBalanceLabel];
    
    _MultipoolDogeBalanceTitleLabel = [[UILabel alloc] init];
    [_MultipoolDogeBalanceTitleLabel setTextColor:lcTextColor];
    [_MultipoolDogeBalanceTitleLabel setBackgroundColor:lcBackgroundColor];
    [_MultipoolDogeBalanceTitleLabel setText:@"DOGE Balance"];
    [_MultipoolDogeBalanceTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:labelfontSize]];
    [_MultipoolDogeBalanceTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_MultipoolDogeBalanceTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_MultipoolDogeBalanceTitleLabel];
    
    
    
    // Cryptsy
    
    _CryptsyTitleLabel = [[UILabel alloc] init];
    [_CryptsyTitleLabel setTextColor:lcTextColor];
    [_CryptsyTitleLabel setBackgroundColor:lcBackgroundColor];
    [_CryptsyTitleLabel setText:@"Cryptsy"];
    [_CryptsyTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:sectionHeaderfontSize]];
    [_CryptsyTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_CryptsyTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_CryptsyTitleLabel];
    
    _DogeBTCRateLabel = [[UILabel alloc] init];
    [_DogeBTCRateLabel setTextColor:lcTextColor];
    [_DogeBTCRateLabel setBackgroundColor:lcBackgroundColor];
    [_DogeBTCRateLabel setText:@"0"];
    [_DogeBTCRateLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:valuefontSize]];
    [_DogeBTCRateLabel setTextAlignment:NSTextAlignmentCenter];
    [_DogeBTCRateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_DogeBTCRateLabel];
    
    _DogeBTCRateTitleLabel = [[UILabel alloc] init];
    [_DogeBTCRateTitleLabel setTextColor:lcTextColor];
    [_DogeBTCRateTitleLabel setBackgroundColor:lcBackgroundColor];
    [_DogeBTCRateTitleLabel setText:@"DOGE/BTC"];
    [_DogeBTCRateTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:labelfontSize]];
    [_DogeBTCRateTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_DogeBTCRateTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_DogeBTCRateTitleLabel];
    
    _DogeBalanceLabel = [[UILabel alloc] init];
    [_DogeBalanceLabel setTextColor:lcTextColor];
    [_DogeBalanceLabel setBackgroundColor:lcBackgroundColor];
    [_DogeBalanceLabel setText:@"0"];
    [_DogeBalanceLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:valuefontSize]];
    [_DogeBalanceLabel setTextAlignment:NSTextAlignmentCenter];
    [_DogeBalanceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_DogeBalanceLabel];
    
    _DogeBalanceTitleLabel = [[UILabel alloc] init];
    [_DogeBalanceTitleLabel setTextColor:lcTextColor];
    [_DogeBalanceTitleLabel setBackgroundColor:lcBackgroundColor];
    [_DogeBalanceTitleLabel setText:@"DOGE Balance"];
    [_DogeBalanceTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:labelfontSize]];
    [_DogeBalanceTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_DogeBalanceTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_DogeBalanceTitleLabel];
    
    _CryptsyBTCBalanceLabel = [[UILabel alloc] init];
    [_CryptsyBTCBalanceLabel setTextColor:lcTextColor];
    [_CryptsyBTCBalanceLabel setBackgroundColor:lcBackgroundColor];
    [_CryptsyBTCBalanceLabel setText:@"0.00000000"];
    [_CryptsyBTCBalanceLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:valuefontSize]];
    [_CryptsyBTCBalanceLabel setTextAlignment:NSTextAlignmentCenter];
    [_CryptsyBTCBalanceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_CryptsyBTCBalanceLabel];
    
    _CryptsyBTCBalanceTitleLabel = [[UILabel alloc] init];
    [_CryptsyBTCBalanceTitleLabel setTextColor:lcTextColor];
    [_CryptsyBTCBalanceTitleLabel setBackgroundColor:lcBackgroundColor];
    [_CryptsyBTCBalanceTitleLabel setText:@"BTC Balance"];
    [_CryptsyBTCBalanceTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:labelfontSize]];
    [_CryptsyBTCBalanceTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_CryptsyBTCBalanceTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_CryptsyBTCBalanceTitleLabel];
    
    
    _updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_updateButton setTitle:@"Update" forState:UIControlStateNormal];
    [_updateButton setBackgroundColor:[UIColor colorWithRed:96.0/255.0f green:166.0/255.0f blue:226.0/255.0f alpha:1.0f]];
    [_updateButton setTitleColor:[UIColor colorWithRed:37.0/255.0f green:100.0/255.0f blue:53.0/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [_updateButton addTarget:self action:@selector(updateData) forControlEvents:UIControlEventTouchUpInside];
    [_updateButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_updateButton];
    
    _updateButton.layer.cornerRadius = 5.0f;
    
    [_updateButton addTarget:self action:@selector(highlightBorder) forControlEvents:UIControlEventTouchDown];
    [_updateButton addTarget:self action:@selector(unhighlightBorder) forControlEvents:UIControlEventTouchUpInside];
    [_updateButton addTarget:self action:@selector(unhighlightBorder) forControlEvents:UIControlEventTouchDragOutside];
    
    _updateButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    _updateButton.layer.borderWidth = 2.0f;


    
    [NSTimer scheduledTimerWithTimeInterval:60.0f target:self selector:@selector(updateData) userInfo:nil repeats:YES];
    
    
    
    
    // Setup invisible padder views
    UIView* invisibleView = [[UIView alloc] init];
    UIView* invisibleView2 = [[UIView alloc] init];
    UIView* invisibleView3 = [[UIView alloc] init];
    UIView* invisibleView4 = [[UIView alloc] init];
    UIView* invisibleView5 = [[UIView alloc] init];
    UIView* invisibleView6 = [[UIView alloc] init];
    UIView* invisibleView7 = [[UIView alloc] init];
    UIView* invisibleView8 = [[UIView alloc] init];
    UIView* invisibleView9 = [[UIView alloc] init];
    UIView* invisibleView10 = [[UIView alloc] init];
    UIView* invisibleView11 = [[UIView alloc] init];
    UIView* invisibleView12 = [[UIView alloc] init];
    [invisibleView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [invisibleView2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [invisibleView3 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [invisibleView4 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [invisibleView5 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [invisibleView6 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [invisibleView7 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [invisibleView8 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [invisibleView9 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [invisibleView10 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [invisibleView11 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [invisibleView12 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:invisibleView];
    [self.view addSubview:invisibleView2];
    [self.view addSubview:invisibleView3];
    [self.view addSubview:invisibleView4];
    [self.view addSubview:invisibleView5];
    [self.view addSubview:invisibleView6];
    [self.view addSubview:invisibleView7];
    [self.view addSubview:invisibleView8];
    [self.view addSubview:invisibleView9];
    [self.view addSubview:invisibleView10];
    [self.view addSubview:invisibleView11];
    [self.view addSubview:invisibleView12];
    
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_totalUSDLabel, _totalUSDTitleLabel, _BTCValueLabel, _BTCValueTitleLabel, _CryptsyTitleLabel, _CryptsyBTCBalanceLabel, _CryptsyBTCBalanceTitleLabel, _DogeBTCRateLabel, _DogeBTCRateTitleLabel, _DogeBalanceLabel, _DogeBalanceTitleLabel, _CoinbaseTitleLabel, _BTCUSDLabel, _BTCUSDTitleLabel, _CoinbaseBTCBalanceLabel, _CoinbaseBTCBalanceTitleLabel, _MultipoolTitleLabel, _DogeHashrateLabel, _DogeHashrateTitleLabel, _MultipoolDogeBalanceLabel, _MultipoolDogeBalanceTitleLabel, _updateButton, invisibleView, invisibleView2, invisibleView3, invisibleView4, invisibleView5, invisibleView6, invisibleView7, invisibleView8, invisibleView9, invisibleView10, invisibleView11, invisibleView12);
    
    // Add auto layout constraints
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-25-[_totalUSDLabel][_totalUSDTitleLabel]-[_BTCValueLabel][_BTCValueTitleLabel]-[invisibleView2]|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    // Add auto layout constraints
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[invisibleView3(==invisibleView4)][_totalUSDLabel(==300)][invisibleView4]|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[invisibleView3(==invisibleView4)][_totalUSDTitleLabel(==300)][invisibleView4]|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[invisibleView3(==invisibleView4)][_BTCValueLabel(==300)][invisibleView4]|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[invisibleView3(==invisibleView4)][_BTCValueTitleLabel(==300)][invisibleView4]|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    

    
    // Update button (bottom center)
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-80-[_updateButton]-80-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[_updateButton]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    
    // Left hand Div Veritical
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[_BTCValueTitleLabel]-20-[_CoinbaseTitleLabel]-[_BTCUSDLabel][_BTCUSDTitleLabel]-[_CoinbaseBTCBalanceLabel][_CoinbaseBTCBalanceTitleLabel]-[invisibleView5][invisibleView6]-60-[_MultipoolTitleLabel]-[_DogeHashrateLabel][_DogeHashrateTitleLabel]-[_MultipoolDogeBalanceLabel][_MultipoolDogeBalanceTitleLabel]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    // Right Hand Div Vertical
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[_BTCValueTitleLabel]-20-[_CryptsyTitleLabel]-[_DogeBTCRateLabel][_DogeBTCRateTitleLabel]-[_DogeBalanceLabel][_DogeBalanceTitleLabel]-[_CryptsyBTCBalanceLabel][_CryptsyBTCBalanceTitleLabel]-[invisibleView7]-[invisibleView8][invisibleView9]-[invisibleView10][invisibleView11]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    
    // Horizontals
    // @"H:|[invisibleView3(==invisibleView4)][_BTCValueLabel(==200)][invisibleView4]|"
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[_CoinbaseTitleLabel(==_CryptsyTitleLabel)]-[_CryptsyTitleLabel]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[_BTCUSDLabel(==_DogeBTCRateLabel)]-[_DogeBTCRateLabel]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[_BTCUSDTitleLabel(==_DogeBTCRateTitleLabel)]-[_DogeBTCRateTitleLabel]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[_CoinbaseBTCBalanceLabel(==_DogeBalanceLabel)]-[_DogeBalanceLabel]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[_CoinbaseBTCBalanceTitleLabel(==_DogeBalanceTitleLabel)]-[_DogeBalanceTitleLabel]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[invisibleView5(==_CryptsyBTCBalanceLabel)]-[_CryptsyBTCBalanceLabel]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[invisibleView6(==_CryptsyBTCBalanceTitleLabel)]-[_CryptsyBTCBalanceTitleLabel]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[_MultipoolTitleLabel(==invisibleView7)]-[invisibleView7]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[_DogeHashrateLabel(==invisibleView8)]-[invisibleView8]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[_DogeHashrateTitleLabel(==invisibleView9)]-[invisibleView9]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[_MultipoolDogeBalanceLabel(==invisibleView10)]-[invisibleView10]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[_MultipoolDogeBalanceTitleLabel(==invisibleView11)]-[invisibleView11]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    
    
    
    
    
    
    [self getCryptsyMarketData];
    [self getCoinbaseMarketData];
    [self getCoinbaseBalances];
    [self getCryptsyBalances];
    [self getMultipoolBalance];
    
	// Do any additional setup after loading the view.
}


-(void)updateData
{
//    [_totalUSDLabel setText:@"$0.00"];
//    [_BTCValueLabel setText:@"0.00000000"];
    
    
    [self.view setBackgroundColor:[UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f]];
	[UIView beginAnimations:@"flash screen" context:nil];
	[UIView setAnimationDuration:1.0f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:52.0f/255.0f green:142.0f/255.0f blue:218.0f/255.0f alpha:1.0f]];
    
	[UIView commitAnimations];
    
    
    [_BTCUSDLabel setTextColor:lcWaitingTextColor];
    [_CoinbaseBTCBalanceLabel setTextColor:lcWaitingTextColor];
    
    [_MultipoolDogeBalanceLabel setTextColor:lcWaitingTextColor];
    [_DogeHashrateLabel setTextColor:lcWaitingTextColor];

    
    [_DogeBTCRateLabel setTextColor:lcWaitingTextColor];
    [_DogeBalanceLabel setTextColor:lcWaitingTextColor];
    [_CryptsyBTCBalanceLabel setTextColor:lcWaitingTextColor];

    
    [self getCryptsyMarketData];
    [self getCoinbaseMarketData];
    [self getCoinbaseBalances];
    [self getCryptsyBalances];
    [self getMultipoolBalance];
}

-(void)computeTotals
{
    double btcExchangeRate = [[_BTCUSDLabel text] doubleValue];
    double dogeExchangeRate = [[_DogeBTCRateLabel text] doubleValue];
    
    double coinbaseBTCBalance = [[_CoinbaseBTCBalanceLabel text] doubleValue];
    double cryptsyBTCBalance = [[_CryptsyBTCBalanceLabel text] doubleValue];
    
    double cryptsyDOGEBalance = [[_DogeBalanceLabel text] doubleValue];
    double multiDogeBalance = [[_MultipoolDogeBalanceLabel text] doubleValue];
    
    double TotalBTC = coinbaseBTCBalance + cryptsyBTCBalance;
    double TotalDoge = cryptsyDOGEBalance + multiDogeBalance;
    
    double TotalBTCValue = (TotalBTC + TotalDoge * (dogeExchangeRate/100000000));
    double TotalUSDValue = btcExchangeRate * TotalBTCValue;

    
    
    [_BTCValueLabel setText:[NSString stringWithFormat:@"%.8f", TotalBTCValue]];
    [_totalUSDLabel setText:[NSString stringWithFormat:@"$%.2f", TotalUSDValue]];
    

    
    
}

-(void)getMultipoolBalance
{
    NSString* baseURL = @"http://api.multipool.us/api.php?api_key=";
    NSString* requestURL = [baseURL stringByAppendingString:multipoolkey];
    
    NSURL *url = [[NSURL alloc] initWithString:requestURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *r, NSData *data, NSError *error)
     {
         if(data != Nil)
         {
             NSDictionary *multiDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
             
             
             if (multiDict != NULL)
             {
                 //             [SVProgressHUD dismiss];
                 NSString* dogeHashRate = [[[multiDict objectForKey:@"currency"] objectForKey:@"doge"] objectForKey:@"hashrate"];
                 NSString* multiDogeBalance = [[[multiDict objectForKey:@"currency"] objectForKey:@"doge"] objectForKey:@"confirmed_rewards"];
                 
                 
                 NSLog(@"Doge Hashrate: %@", dogeHashRate);
                 NSLog(@"Multi Doge Balance: %@", multiDogeBalance);
                 
                 [_DogeHashrateLabel setText:dogeHashRate];
                 [_MultipoolDogeBalanceLabel setText:[NSString stringWithFormat:@"%.2f",[multiDogeBalance floatValue]]];
                 
                 [_DogeHashrateLabel setTextColor:lcTextColor];
                 [_MultipoolDogeBalanceLabel setTextColor:lcTextColor];



                 
                 
                 [self computeTotals];
                 
             }
             else
             {
                 // Dictionary was null, meaning that the clients credentials were rejected by the server.
                 //             [SVProgressHUD showErrorWithStatus:@"Unable to access server."];
                 NSLog(@"Cryptsy Market Lookup Failed");
             }
         }
         else
         {
             [SVProgressHUD showErrorWithStatus:@"Multipool is Down"];
         }
     }];

}

-(void)getCryptsyMarketData
{
    
//    [SVProgressHUD showWithStatus:@"Refreshing Blueprints"];
    
    NSString* requestURL = @"http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=132";
    
    
    NSURL *url = [[NSURL alloc] initWithString:requestURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *r, NSData *data, NSError *error)
     {
         NSDictionary *cryptsyDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         
         
         if (cryptsyDict != NULL)
         {
//             [SVProgressHUD dismiss];
             
             if([[cryptsyDict objectForKey:@"return"] isKindOfClass:[NSDictionary class]])
             {
                 NSString* DogePrice = [[[[cryptsyDict objectForKey:@"return"] objectForKey:@"markets"] objectForKey:@"DOGE"] objectForKey:@"lasttradeprice"];
                 
                 double DogeSatoshi = [DogePrice doubleValue];
                 DogeSatoshi = DogeSatoshi * 100000000;
                 
                 NSLog(@"Doge Price: %.0f Satoshi", DogeSatoshi);
                 
                 [_DogeBTCRateLabel setText:[NSString stringWithFormat:@"%.0f", DogeSatoshi]];
                 [_DogeBTCRateLabel setTextColor:lcTextColor];

                 [self computeTotals];

             }
             else
             {
                 NSLog(@"Cryptsy Doge Market Null Return");

             }
             
         }
         else
         {
             NSLog(@"Cryptsy Market Lookup Failed");
         }
     }];
}

-(void)getCoinbaseMarketData
{
    NSString* requestURL = @"https://coinbase.com/api/v1/currencies/exchange_rates";
    
    
    NSURL *url = [[NSURL alloc] initWithString:requestURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *r, NSData *data, NSError *error)
     {
         NSDictionary *coinbaseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         //         NSLog(@"%@\n", coinbaseDict);
         
         
         if (coinbaseDict != NULL)
         {
             //             [SVProgressHUD dismiss];
             
             NSString* BTCPrice = [coinbaseDict objectForKey:@"btc_to_usd"];
             
             NSLog(@"BTC Price %0.2f USD", [BTCPrice floatValue]);
             
             [_BTCUSDLabel setText:[NSString stringWithFormat:@"%0.2f",[BTCPrice floatValue]]];
             [_BTCUSDLabel setTextColor:lcTextColor];
             
             [self computeTotals];

             
             
         }
         else
         {
             // Dictionary was null, meaning that the clients credentials were rejected by the server.
             //             [SVProgressHUD showErrorWithStatus:@"Unable to access server."];
             
             NSLog(@"Coinbase Market Lookup Failed");
             
         }
     }];
}


-(void)getCryptsyBalances
{
    NSString* requestURL = @"https://api.cryptsy.com/api";
    NSString* nonce = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    
    
    
    NSURL *url = [[NSURL alloc] initWithString:requestURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString* body = [@"method=getinfo&nonce=" stringByAppendingString:nonce];
    NSData* messageData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    // Compute SHA256 Hash
    
    NSData *keyData = [cryptsyapisecret dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *messageData = jsonData;
    NSMutableData* hash = [NSMutableData dataWithLength:CC_SHA512_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA512, keyData.bytes, keyData.length, messageData.bytes, messageData.length, hash.mutableBytes);
//    NSString *signature = [hash base64EncodedStringWithOptions:0];
    
    const unsigned char *dataBuffer = (const unsigned char *)[hash bytes];
    
    
    NSUInteger          dataLength  = [hash length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
    {
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    
    NSString *signature = hexString;
    
    
    
    // Request
    [request setHTTPBody:messageData];
    
    // Set Headers
    [request setValue:cryptsyapikey forHTTPHeaderField:@"Key"];
    [request setValue:signature forHTTPHeaderField:@"Sign"];
    
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *r, NSData *data, NSError *error)
     {
         if(data != nil)
         {
             NSDictionary *cryptDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
             
             
             
             if (cryptDict != NULL)
             {
                 //             [SVProgressHUD dismiss];
                 
                 NSString* cryptsyBTCBalance = [[[cryptDict objectForKey:@"return"] objectForKey:@"balances_available"] objectForKey:@"BTC"];
                 NSString* cryptsyDOGEBalance = [[[cryptDict objectForKey:@"return"] objectForKey:@"balances_available"] objectForKey:@"DOGE"];
                 
                 NSLog(@"Cryptsy BTC Balance: %@", cryptsyBTCBalance);
                 NSLog(@"Cryptsy DOGE Balance: %@", cryptsyDOGEBalance);
                 
                 [_CryptsyBTCBalanceLabel setText:cryptsyBTCBalance];
                 [_DogeBalanceLabel setText:[NSString stringWithFormat:@"%.0f", [cryptsyDOGEBalance floatValue]]];
                 
                 [_CryptsyBTCBalanceLabel setTextColor:lcTextColor];
                 [_DogeBalanceLabel setTextColor:lcTextColor];
                 
                 [self computeTotals];


                 
                 
             }
             else
             {
                 // Dictionary was null, meaning that the clients credentials were rejected by the server.
                 //             [SVProgressHUD showErrorWithStatus:@"Unable to access server."];
                 
                 NSLog(@"Cryptsy Market Lookup Failed");
                 
             }
         }
     }];

}

-(void)getCoinbaseBalances
{
    NSString* requestURL = @"https://coinbase.com/api/v1/account/balance";
    NSString* nonce = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    
    
    NSURL *url = [[NSURL alloc] initWithString:requestURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSString* body = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    
    NSString* message = [[nonce stringByAppendingString:requestURL] stringByAppendingString:body];
    
    
    // Compute SHA256 Hash
    
    NSData *keyData = [coinbaseapisecret dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* hash = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH ];
    CCHmac(kCCHmacAlgSHA256, keyData.bytes, keyData.length, messageData.bytes, messageData.length, hash.mutableBytes);
//    NSString *signature = [hash base64EncodedStringWithOptions:0];
    
//    NSLog(@"\nSignature: %@, \nLength: %d", signature, [signature length]);
    
    const unsigned char *dataBuffer = (const unsigned char *)[hash bytes];
    
    
    NSUInteger          dataLength  = [hash length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
    {
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    
    NSString *signature = hexString;
    
    
    
    // Set Headers
    [request setValue:coinbaseapikey forHTTPHeaderField:@"ACCESS_KEY"];
    [request setValue:nonce forHTTPHeaderField:@"ACCESS_NONCE"];
    [request setValue:signature forHTTPHeaderField:@"ACCESS_SIGNATURE"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
//    NSLog(@"%@", request);
    
    
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *r, NSData *data, NSError *error)
     {
         NSDictionary *coinbaseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         //         NSLog(@"%@\n", coinbaseDict);
         
         
         if (coinbaseDict != NULL)
         {
             //             [SVProgressHUD dismiss];
             
//             NSString* BTCPrice = [coinbaseDict objectForKey:@"btc_to_usd"];
//             
//             NSLog(@"BTC Price: %.2f USD", [BTCPrice floatValue]);
             
             NSString* coinbaseBalance = [coinbaseDict objectForKey:@"amount"];
             NSLog(@"Coinbase Balance: %@", coinbaseBalance);
             
             [_CoinbaseBTCBalanceLabel setText:coinbaseBalance];
             
             [_CoinbaseBTCBalanceLabel setTextColor:lcTextColor];
             
             
             [self computeTotals];

             
             
         }
         else
         {
             // Dictionary was null, meaning that the clients credentials were rejected by the server.
             //             [SVProgressHUD showErrorWithStatus:@"Unable to access server."];
             
             NSLog(@"Coinbase Market Lookup Failed");
             
         }
     }];

}


- (void)highlightBorder
{
    _updateButton.layer.borderColor = [[UIColor colorWithRed:37.0/255.0f green:100.0/255.0f blue:53.0/255.0f alpha:1.0f] CGColor];
}

- (void)unhighlightBorder
{
    _updateButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    //additional code for an action when the button is released can go here.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
