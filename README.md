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

#### Creating a user interface in the Storyboard
The normal way to create user interfaces for iOS is by using Storyboards. Click on Main.storyboard on the left bar to see the Interface Builder.

In order to create the user interface for our To-Do List app, we're going to add some views. Views are just things you can see on the screen. Views can contain other views, and that's how bigger user interfaces are built up. The entire user interface visible at a given time is contained at some point in a single view.

The first thing we want in the view is a navigation bar. Click on the View Controller in the middle of the screen, then in the menu bar at the top, click Editor -> Embed In -> Navigation Controller.

Our To-Do items are going to be contained in a Table View. Let's add that first. Find the Table View in the list of views in the bottom right. You can type into the box to search for it. Drag the Table View on to the View Controller so that the top of the Table View is above the navigation bar.

To position views the right way for a variety of screen sizes, we use *constraints*. Constraints define how views should be positioned relative to each other. This allows us, for instance, to make a view always be the same size as its container.

1. Click on the Add New Constraints button (it's kind of a hieroglyph) in the bottom right.
2. Add new constraints for the top, bottom, left and right by clicking the red I-shaped buttons.
3. Uncheck "constrain to margins" and enter 0 for all the values of the top/left/bottom/right constraints.
4. Near the bottom there's a drop-down menu labeled Update Frames. Select "Items of New Constraints" from the menu.
5. Click "Add Constraints".

The Table View should have blown up to take up the whole space in the View Controller. If the top didn't go high enough, click on the constraint on the top and delete it, then drag the top up past the navigation bar and recreate the constraint to make it go to the top.

Next we have to define appearance of the rows in the table. Click on the Table View in the Storyboard, then open the Attributes Inspector on the right side. (That's the icon that looks like an arrow pointing down, just to the right of the little box with the squares and lines on it.)

You should see a drop-down menu labeled *Prototype Cells.* Set its value to 1. An empty cell should have appeared in your Table View. Select this UITableViewCell and set its style to *Basic* and its Reuse Identifier to *ToDoItem*. This will allow us to make table view cells with this style in this table and show data with them.

Now we're ready to start providing data to the table view so we can see something really happen in our app.

#### Inside ViewController.swift
Click on ViewController.swift on the left menu and see what's going on in there. ViewController is a class which inherits from the built-in class UIViewController. We override methods of the built-in UIViewController in order to make the app behave in a certain way.

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
    let cell = tableView.dequeueReusableCellWithIdentifier("ToDoItem", forIndexPath: indexPath)
    
    cell.textLabel?.text = toDoItems[indexPath.row]
    
    return cell
}
```

#### Hooking up the UITableView to the UITableViewDelegate
Now, we just need to let the table view know that its delegate is our ViewController. Open Main.storyboard and click on the Table View. Then hold Control and drag from the Table View to the View Controller (the orange circle icon with the white rectangle inside). In the menu that pops up, click *dataSource*.

#### First milestone
Now you should have enough made in order to show something! Select a Simulator from the top drop-down menu and then click the play button. The simulator should load and show you your app, consisting of a table containing the to-do items you coded into your ViewController.
