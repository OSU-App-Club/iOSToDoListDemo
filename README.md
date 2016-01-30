# iOS To-Do List
This is a guide intended to get you up and running with iOS development.  

#### Before we begin
Install Xcode from the App Store. Make sure it's up to date by searching for it in the App Store and going to its page.

#### Creating a project in Xcode
Open Xcode. If you see the *Welcome to Xcode* screen, you can click *Create a new Xcode project*.  
You can also click the File menu at the top, then select New -> Project.

Next, you'll be prompted to choose a template. Under the iOS Application section, choose the *Single View Application* template.  
Enter a descriptive Product Name like ToDoList. The Organization Name and Organization Identifier can be left at their defaults.  
For Language, select Swift.  
For Devices, select Universal.  
Uncheck *Use Core Data*, *Include Unit Tests*, and *Include UI Tests*
(placeholder for first image)

#### Finding your way around
You've just created a new project. There are a few files you should know about in here.

1. Main.storyboard is where you'll create your user interface.
2. ViewController.swift and other files ending in .swift contain your application's logic.

#### Inside ViewController.swift
First, click on ViewController.swift and see what's going on in there. ViewController is a class which inherits from the built-in class UIViewController. We override methods of the built-in UIViewController in order to make the app behave in a certain way.

The most important thing we want in a to-do list is a view which lists the to-do items! To achieve this, we're going to make use of UITableView. The UITableView class displays a list of items provided by its data source.

Every data source for a UITableView conforms to a *protocol* called UITableViewDataSource. A protocol, like an interface in Java, is just a set of methods that an object can provide. We can take any class and make it work as a UITableViewDataSource by decorating it and implementing certain methods on it.

#### Implementing UITableViewDataSource
Edit the signature of the ViewController class in ViewController.swift so it conforms to UITableViewDataSource as well as UIViewController.
```swift
class ViewController: UIViewController, UITableViewDataSource {

// You can leave the stuff inside the class alone

}
```
To make this class work as a UITableViewDataSource, we will have to implement the methods `tableView(tableView: UITableView, numberOfRowsInSection section: Int)` and `tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)`. Just start typing tableView inside the class and look through the list that pops up until you find the methods with those names, then click on the method name to write its signature in your class file.

Both of these methods will have little `code` placeholders. We will have to implement them.  
There are a few steps to do this:

(1) Add an array instance variable to the ViewController class.
```swift
// Right below the class signature:
var toDoItems = ["Walk the dog", "Wash the car", "Get groceries"]
```
(2) Return the size of the array in the `numberOfRowsInSection` method.
```swift
func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toDoItems.count
}
```
(3) Create and return a table view cell in the `cellForRowAtIndexPath` method.
```swift
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("toDoItem", forIndexPath: indexPath)
    
    cell.textLabel?.text = toDoItems[indexPath.row]
    
    return cell
}
```
