//
//  ContactsViewController.m
//  Contacts1
//
//  Created by Jacob Harris on 5/20/18.
//  Copyright © 2018 Sneeze & Cookie, LLC. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactDetailViewController.h"
#import "Contact.h"

@interface ContactsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSDictionary *json_contacts;
@property (nonatomic, strong) NSMutableArray *contacts;
@property (nonatomic, strong) Contact *selectedContact;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) BOOL isEditing;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reloadContacts];
}

- (void)reloadContacts {
    self.isEditing = NO;
    self.contacts = [NSMutableArray array];
    self.json_contacts = [[self JSONFromFile:@"contacts"] objectForKey:@"contacts"];
    for (NSDictionary *contact_dict in self.json_contacts) {
        Contact *contact = [[Contact alloc] init];
        contact.contactID = [contact_dict objectForKey:@"contact_id"];
        contact.firstName = [contact_dict objectForKey:@"first_name"];
        contact.lastName = [contact_dict objectForKey:@"last_name"];
        contact.phoneNumber = [contact_dict objectForKey:@"phone_number"];
        contact.streetAddress1 = [contact_dict objectForKey:@"street_address_1"];
        contact.streetAddress2 = [contact_dict objectForKey:@"street_address_2"];
        contact.city = [contact_dict objectForKey:@"city"];
        contact.state = [contact_dict objectForKey:@"state"];
        contact.zipCode = [contact_dict objectForKey:@"zip_code"];
        [self.contacts addObject:contact];
    }
    
    NSLog(@"%@", self.contacts);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

- (NSDictionary *)JSONFromFile:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Segue_ContactsViewController_ContactDetailViewController"]) {
        ContactDetailViewController *contactDetailViewController = segue.destinationViewController;
        contactDetailViewController.contact = self.selectedContact;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [self.contacts count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Contact *contact = [self.contacts objectAtIndex:indexPath.row];
    NSString *name = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    cell.textLabel.text = name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedContact = [self.contacts objectAtIndex:indexPath.row];
    self.selectedIndex = indexPath.row;
    self.isEditing = YES;
    [self performSegueWithIdentifier:@"Segue_ContactsViewController_ContactDetailViewController" sender:nil];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.contacts removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

- (IBAction)reloadContacts:(UIBarButtonItem *)sender {
    [self reloadContacts];
}

- (IBAction)addContact:(UIBarButtonItem *)sender {
    self.isEditing = NO;
    self.selectedContact = nil;
    [self performSegueWithIdentifier:@"Segue_ContactsViewController_ContactDetailViewController" sender:nil];
}

- (IBAction)unwind:(UIStoryboardSegue *)sender {
    ContactDetailViewController *contactDetailViewController = sender.sourceViewController;
    Contact *contact = contactDetailViewController.contact;

    if (self.isEditing) {
        [self.contacts replaceObjectAtIndex:self.selectedIndex withObject:contact];
    } else {
        [self.contacts addObject:contact];
    }
    
    [self.tableView reloadData];
}

@end
