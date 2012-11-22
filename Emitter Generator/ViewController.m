//
//  ViewController.m
//  Emitter Generator
//
//  Created by Paul Thorsteinson on 2012-09-01.
//  Copyright (c) 2012 Paul Thorsteinson. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()

@property (strong, nonatomic) CAEmitterLayer *emitterLayer;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *contents;
@property (weak, nonatomic) IBOutlet UITextField *birthRate;
@property (weak, nonatomic) IBOutlet UITextField *lifetime;
@property (weak, nonatomic) IBOutlet UITextField *lifetimeRange;
@property (weak, nonatomic) IBOutlet UITextField *velocity;
@property (weak, nonatomic) IBOutlet UITextField *velocityRange;
@property (weak, nonatomic) IBOutlet UITextField *xAcceleration;
@property (weak, nonatomic) IBOutlet UITextField *yAcceleration;

@property (weak, nonatomic) IBOutlet UITextField *scale;
@property (weak, nonatomic) IBOutlet UITextField *colorR;
@property (weak, nonatomic) IBOutlet UITextField *colorG;
@property (weak, nonatomic) IBOutlet UITextField *colorB;
@property (weak, nonatomic) IBOutlet UITextField *emissionRange;
@property (weak, nonatomic) IBOutlet UITextField *beginTime;
@property (weak, nonatomic) IBOutlet UITextField *duration;
@property (weak, nonatomic) IBOutlet UITextField *scaleSpeed;
@property (weak, nonatomic) IBOutlet UITextField *spin;
@property (weak, nonatomic) IBOutlet UITextField *alphaSpeed;
@property (weak, nonatomic) IBOutlet UITextView *codeTextView;
@property (weak, nonatomic) IBOutlet UIButton *closeCodeButton;
@property (weak, nonatomic) IBOutlet UIView *codeHolder;

- (IBAction)closeCode:(id)sender;

- (IBAction)closeKeyboard:(id)sender;
- (IBAction)showCode:(id)sender;

- (IBAction)forceRefresh:(id)sender;
- (void)refreshEmitter;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self refreshEmitter];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)closeCode:(id)sender {
    _codeHolder.hidden = YES;
    [self refreshEmitter];
}

- (IBAction)closeKeyboard:(id)sender {
    [self.view endEditing:YES];
    [self refreshEmitter];
}

- (IBAction)showCode:(id)sender {
    
    // stop emitter from going over code
    [_emitterLayer removeFromSuperlayer];
    self.emitterLayer = nil;
    
    NSMutableString *result = [[NSMutableString alloc] initWithString:@""];
    
    [result appendFormat:@"CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];\n"];
    [result appendFormat:@"[self.view.layer addSublayer:emitterLayer];\n"];
    [result appendFormat:@"[self.view.layer setNeedsDisplay];\n"];
    [result appendFormat:@"emitterLayer.emitterPosition = self.view.center;\n"];
    [result appendFormat:@"emitterLayer.emitterSize = CGSizeMake(100, 100);\n"];
    [result appendFormat:@"emitterLayer.emitterShape = kCAEmitterLayerCircle;\n"];
    [result appendFormat:@"emitterLayer.renderMode = kCAEmitterLayerUnordered;\n"];
    [result appendFormat:@"CAEmitterCell *sample = [CAEmitterCell emitterCell];"];
    [result appendFormat:@"sample.name = %@;\n", _name.text];
    [result appendFormat:@"sample.birthRate = %f;\n",[_birthRate.text floatValue]];
    [result appendFormat:@"sample.lifetime = %f;\n",[_lifetime.text floatValue]];
    [result appendFormat:@"sample.lifetimeRange = %f;\n",[_lifetimeRange.text floatValue]];
    [result appendFormat:@"sample.emissionRange = %f;\n",[_emissionRange.text floatValue]];
    [result appendFormat:@"sample.velocity = %f;\n",[_velocity.text floatValue]];
    [result appendFormat:@"sample.velocityRange = %f;\n",[_velocityRange.text floatValue]];
    [result appendFormat:@"sample.xAcceleration = %f;\n",[_xAcceleration.text floatValue]];
    [result appendFormat:@"sample.yAcceleration = %f;\n",[_yAcceleration.text floatValue]];
    [result appendFormat:@"sample.scale = %f;\n",[_scale.text floatValue]];
    [result appendFormat:@"sample.scaleSpeed = %f;\n",[_scaleSpeed.text floatValue]];
    [result appendFormat:@"sample.alphaSpeed = %f;\n",[_alphaSpeed.text floatValue]];
    [result appendFormat:@"sample.beginTime = %f;\n",[_beginTime.text floatValue]];
    [result appendFormat:@"sample.duration = %f;\n",[_duration.text floatValue]];
    [result appendFormat:@"sample.spin = %f;\n",[_spin.text floatValue]];
    [result appendFormat:@"sample.contents =  (id)[[UIImage imageNamed:%@] CGImage];\n",_contents.text];
    [result appendFormat:@"sample.color = [[UIColor colorWithRed:%f green:%f blue:%f alpha:1.0] CGColor];\n",[_colorR.text floatValue],[_colorG.text floatValue],[_colorB.text floatValue]];
    [result appendFormat:@"_emitterLayer.emitterCells = [NSArray arrayWithObjects:sample, nil];\n"];

    
    
    _codeTextView.text = result;
    _codeHolder.hidden = NO;

}

- (IBAction)forceRefresh:(id)sender {
    [self refreshEmitter];
}

- (void)refreshEmitter{
    
    [_emitterLayer removeFromSuperlayer];
    
    self.emitterLayer = [CAEmitterLayer layer];
    [self.view.layer addSublayer:_emitterLayer];
    [self.view.layer setNeedsDisplay];
    
    _emitterLayer.emitterPosition = self.view.center;
    _emitterLayer.emitterSize = CGSizeMake(100, 100);
    _emitterLayer.emitterShape = kCAEmitterLayerCircle;
    _emitterLayer.renderMode = kCAEmitterLayerUnordered;

    
    CAEmitterCell *sample = [CAEmitterCell emitterCell];
    sample.name = _name.text;
    sample.birthRate = [_birthRate.text floatValue];
    sample.lifetime = [_lifetime.text floatValue];
    sample.lifetimeRange = [_lifetimeRange.text floatValue];
    sample.emissionRange = [_emissionRange.text floatValue];
    sample.velocity = [_velocity.text floatValue];
    sample.velocityRange = [_velocityRange.text floatValue];
    sample.xAcceleration = [_xAcceleration.text floatValue];
    sample.yAcceleration = [_yAcceleration.text floatValue];
    sample.scale = [_scale.text floatValue];
    sample.scaleSpeed = [_scaleSpeed.text floatValue];
    sample.alphaSpeed = [_alphaSpeed.text floatValue];
    sample.beginTime = [_beginTime.text floatValue];
    sample.duration = [_duration.text floatValue];
    sample.spin = [_spin.text floatValue];
    sample.contents =  (id)[[UIImage imageNamed:_contents.text] CGImage];
    sample.color = [[UIColor colorWithRed:[_colorR.text floatValue] green:[_colorG.text floatValue] blue:[_colorB.text floatValue] alpha:1.0] CGColor];
    _emitterLayer.emitterCells = [NSArray arrayWithObjects:sample, nil];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self refreshEmitter];
    
    NSInteger tag = [(UITextField *)textField tag];
    tag++;
    if (tag > 19) {
        tag = 1;
    }
    
    UIView *view = [self.view viewWithTag:tag];
    [view becomeFirstResponder];
    
    return YES;
}

- (void)viewDidUnload {
    [self setCodeTextView:nil];
    [self setCloseCodeButton:nil];
    [self setCodeHolder:nil];
    [super viewDidUnload];
}
@end
