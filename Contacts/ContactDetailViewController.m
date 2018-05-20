//
//  ContactDetailViewController.m
//  Contacts1
//
//  Created by Jacob Harris on 5/20/18.
//  Copyright © 2018 Sneeze & Cookie, LLC. All rights reserved.
//

#import "ContactDetailViewController.h"

@interface ContactDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *address1TextField;
@property (weak, nonatomic) IBOutlet UITextField *address2TextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipTextField;

@end

@implementation ContactDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstNameTextField.text = self.contact.firstName;
    self.lastNameTextField.text = self.contact.lastName;
    self.phoneTextField.text = self.contact.phoneNumber;
    self.address1TextField.text = self.contact.streetAddress1;
    self.address2TextField.text = self.contact.streetAddress2;
    self.cityTextField.text = self.contact.city;
    self.stateTextField.text = self.contact.state;
    self.zipTextField.text = self.contact.zipCode;
}

- (IBAction)didTapSaveButton:(UIBarButtonItem *)sender {
    Contact *contact = [[Contact alloc] init];
    contact.firstName = self.firstNameTextField.text;
    contact.lastName = self.lastNameTextField.text;
    contact.phoneNumber = self.phoneTextField.text;
    contact.streetAddress1 = self.address1TextField.text;
    contact.streetAddress2 = self.address2TextField.text;
    contact.city = self.cityTextField.text;
    contact.state = self.stateTextField.text;
    contact.zipCode = self.zipTextField.text;
    
    self.contact = contact;
    [self performSegueWithIdentifier:@"UnwindSegue" sender:nil];
}


@end
