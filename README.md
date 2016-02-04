# iOS Beginner Workshop
This is an outline for a workshop intended to get people up and running with iOS development.

#### Before we begin
Install Xcode from the App Store. Make sure it's up to date by searching for it in the App Store and going to its page.

## Part 1: Showing a To-Do List

#### Creating a project in Xcode
Open Xcode. If you see the *Welcome to Xcode* screen, you can click *Create a new Xcode project*.  
You can also click the File menu at the top, then select New -> Project.

Next, you'll be prompted to choose a template. Under the iOS Application section, choose the *Single View Application* template.  
Enter a descriptive Product Name like *ToDoList*. The Organization Name and Organization Identifier can be left at their defaults.  
For Language, select *Swift*.  
For Devices, select *Universal*.  
Uncheck *Use Core Data*, *Include Unit Tests*, and *Include UI Tests*
(placeholder for first image)

#### Finding your way around
You've just created a new project. There are a few files you should know about in here.

1. **Main.storyboard** is where you'll create your user interface.
2. **ViewController.swift** and other files ending in .swift contain your application's logic.

#### Creating a user interface in the Storyboard
The normal way to create user interfaces for iOS is by using Storyboards. Click on **Main.storyboard** on the left bar to see the Interface Builder.

In order to create the user interface for our To-Do List app, we're going to add some **views**. Views are just things you can see on the screen. Views can contain other views, and that's how bigger user interfaces are built up. The entire user interface visible at a given time is contained at some point in a single view.

The first thing we want in the view is a **navigation bar**. Click on the View Controller in the middle of the screen, then in the menu bar at the top, click **Editor -> Embed In -> Navigation Controller**.

Our To-Do items are going to be contained in a **Table View**. Let's add that first. Find the Table View in the list of views in the bottom right. You can type into the box to search for it. Drag the Table View on to the View Controller so that the top of the Table View is above the navigation bar.

To position views the right way for a variety of screen sizes, we use **constraints**. Constraints define how views should be positioned relative to each other. This allows us, for instance, to make a view always be the same size as its container.

1. Click on the **Add New Constraints** button (it's kind of a hieroglyph) in the bottom right.
2. Add new constraints for the top, bottom, left and right by clicking the red I-shaped buttons.
3. Uncheck "constrain to margins" and enter 0 for all the values of the top/left/bottom/right constraints.
4. Near the bottom there's a drop-down menu labeled **Update Frames**. Select *Items of New Constraints* from the menu.
5. Click **Add Constraints**.

The Table View should have blown up to take up the whole space in the View Controller. *If the top didn't go high enough*, click on the constraint on the top and delete it, then drag the top up past the navigation bar and recreate the constraint to make it go to the top.

Next we have to define appearance of the rows in the table. Click on the Table View in the Storyboard, then open the **Attributes Inspector** on the right side. (That's the icon that looks like an arrow pointing down, just to the right of the little box with the squares and lines on it.)

You should see a drop-down menu labeled **Prototype Cells.** Set its value to 1.  
An empty cell should have appeared in your Table View. Select this UITableViewCell and set its style to *Basic* and its Reuse Identifier to *ToDoItem*.  
This will allow us to make table view cells with this style in this table and show data with them.

Now we're ready to start providing data to the table view so we can see something really happen in our app.

#### Inside ViewController.swift
Click on **ViewController.swift** on the left menu and see what's going on in there. ViewController is a class which inherits from the built-in class UIViewController. We override methods of the built-in UIViewController in order to make the app behave in a certain way.

The most important thing we want in a to-do list is a view which lists the to-do items! To achieve this, we're going to make use of **UITableView**. The UITableView class displays a list of items provided by its data source.

Every data source for a UITableView conforms to a **protocol** called *UITableViewDataSource*. A protocol, like an interface in Java, is just a set of methods that an object can provide. We can take any class and make it work as a *UITableViewDataSource* by decorating it and implementing certain methods on it.

#### Implementing UITableViewDataSource
Edit the signature of the *ViewController* class in ViewController.swift so it conforms to *UITableViewDataSource* as well as *UIViewController*.
```swift
class ViewController: UIViewController, UITableViewDataSource {

// You can leave the stuff inside the class alone

}
```
To make this class work as a *UITableViewDataSource*, we will have to implement the methods `tableView(tableView: UITableView, numberOfRowsInSection section: Int)` and `tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)`. **Just start typing tableView inside the class** and look through the list that pops up until you find the methods with those names, then click on the method name to write its signature in your class file.

Both of these methods will have little `code` placeholders inside. We will have to implement them.  
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
(3) Obtain a table view cell and prepare it for display in the `cellForRowAtIndexPath` method.
```swift
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ToDoItem", forIndexPath: indexPath)
    
    cell.textLabel?.text = toDoItems[indexPath.row]
    
    return cell
}
```

#### Hooking up the UITableView to the UITableViewDataSource
Now, we just need to let the table view know that its dataSource is our ViewController. Open Main.storyboard and click on the Table View. Then hold Control and drag from the Table View to the View Controller (the orange circle icon with the white rectangle inside). In the menu that pops up, click **dataSource**.

#### First milestone
Now you should have enough made in order to show something! Select a Simulator from the top drop-down menu and then click the play button. The simulator should load and show you your app, consisting of a table containing the to-do items you coded into your ViewController.

## Part 2: Adding Items to the To-Do List

The next thing people want to do in a To-Do List is add items to it! Let's create a new view where the user can add an item to the list.

1. Open Main.storyboard.
2. Drag a View Controller onto the storyboard. As before, embed it in a navigation controller with  **Editor -> Embed In -> Navigation Controller**.
3. Add a **Bar Button Item** to the right side of the title bar in the previous view controller that contained the Table View.
4. In the *System Item* dropdown on the right, select **Add**. The button should now look like a + sign.
5. Control-drag from the button to the navigation controller that contains the next view controller. Choose **Present Modally**. A transition between view controllers is called a *segue*, and a modal presentation is one type of segue.

#### Creating an AddToDoViewController
We need to create a new View Controller subclass to contain the behavior we want this new screen to have.

1. In the file listing on the left, right click on the yellow folder with the same name as your project. Select **New File**.
2. Choose the category **iOS Source** and select **Swift File**. Name it **ToDoAddViewController**.
3. In the new file, change `import Foundation` to `import UIKit`. Then write a Swift class as so:
```swift
class ToDoAddViewController : UIViewController {
    
}
```

#### Creating a delegate protocol
When the user creates a new to-do item and returns to the to-do list, the first view controller will need to be provided with the new item so it can add it to the list. We are going to communicate between views by creating our own protocol as follows:
```swift
protocol ToDoAddViewControllerDelegate : NSObjectProtocol {
    func toDoAddViewControllerDidAddToDoItem(toDoItem: String)
}
```
Write this code above the class definition for AddToDoViewController. The method name is a mouthful, but it helps with autocomplete and attributing what protocol a method comes from.

The idea of the **delegate** pattern is that one object is "delegated" to handle events that occur on another object. This is the primary way that "child" objects communicate with their parent. This kind of design is helpful because it limits the ways the child can interfere with the parent, makes it clear how communication is taking place between components, and makes components reusable because the child can work with any object which implements its delegate protocol.

The child is going to have a `weak` reference to its delegate. Don't worry about what that means for now, but know that delegates are typically referenced using `weak` variables. Add the following line of code to your `ToDoAddViewController`:
```swift
weak var delegate: ToDoAddViewControllerDelegate?
```

#### Wiring up the ToDoAddViewController in the Storyboard
Let's go back to Main.storyboard and add some things to the new View Controller.

1. Add a **Bar Button Item** and set its *System Item* to **Done**.
2. Add a **Text Field** and then add the following constraints:
3. Add a constraint for horizontal center.
4. Add a constraint for the width to 250 points.
5. Add a constraint for the top to 60 points.

In the end you should have a text field centered vertically with a decent margin beneath the title bar.

Now it's time to wire the newly created views up to the `ToDoAddViewController`.

1. Click on the **Identity Inspector**-- the icon that looks like a box containing a box and lines.
2. Select the new View Controller in the storyboard, then in the Class field on the right, type ToDoAddViewController and hit return.
3. Click the button in the upper right that looks like two rings linked together. This is the Assistant Editor. You can use some of the buttons in the very upper right and in other places to dismiss unwanted menus and make more space.

Now that Interface Builder knows what class this view controller corresponds to, it shows our ToDoAddViewController file.

1. Click on the text field you placed in Interface Builder and control-drag it to your Swift class on the right side. You should see the text "Insert Outlet, Action or Outlet Collection".
2. Release the mouse button and name the outlet `textToDoAdd`. Click **Connect**.
3. Control-drag from the **Done** button to the Swift class and choose **Action** in the Connection dropdown. Name it `doneButtonTapped` and click Connect.
4. In the upper right, click on the button with the lines to dismiss the Assistant Editor and go back to the regular editor.
5. Open ToDoAddViewController.swift and implement `doneButtonTapped:`
```swift
@IBAction func doneButtonTapped(sender: AnyObject) {
    if let text = textToDoAdd.text {
        delegate?.toDoAddViewControllerDidAddToDoItem(text)
    }
    dismissViewControllerAnimated(true, completion: nil)
}
```
This will inform the delegate of the text of the new to-do item, then return control to the view controller that presented this view controller.

#### Implementing the delegate protocol in ViewController.swift
For *ViewController* to receive messages from *ToDoAddViewController*, it must implement the delegate protocol we created.

1. Click on ViewController.swift and add `ToDoAddViewControllerDelegate` to the class signature, after `UITableViewDataSource`.
2. Xcode should be mad right now, because we need to implement the methods of this protocol. Inside the class body, start typing toDoAdd... and the whole signature of the method should pop up. Select it and hit enter to autocomplete. Implement the method as follows:
```swift
func toDoAddViewControllerDidAddToDoItem(toDoItem: String) {
    toDoItems.append(toDoItem)
}
```

Now, when the *ToDoAddViewController* is about to be presented, we need to attach this view controller to it as a delegate. Start typing `prepareForSegue` and hit return to autocomplete the method signature. The segue contains a reference to the navigation controller it's heading to, and we need to get at the ToDoAddViewController contained in the navigation controller. Implement it as follows:
```swift
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let destination = segue.destinationViewController.childViewControllers.first as? ToDoAddViewController {
        destination.delegate = self
    }
}
```
If you go and run the app right now, however, you'll be disappointed! The table view has no idea that this update has taken place, and we will need to notify it.  
Go into Main.storyboard and add an **outlet** named `tableView` for the table view to ViewController.swift just like you did with the text field. You can option-click on a file when using the Assistant Editor to make the file open in the right half of the window.

Now we can complete the delegate implementation:
```swift
func toDoAddViewControllerDidAddToDoItem(toDoItem: String) {
    toDoItems.append(toDoItem)
    tableView.reloadData()
}
```
Run the app, and you should find that you can go to the add view controller, type in an item's name, and have it show up in the to-do list!

## Next steps
- Try to implement UITableViewDelegate (don't forget to wire it up in the Storyboard) so you can handle events from the table view and let the user check off or delete items.
- Rename the ViewController class and .swift file to something more descriptive like ToDoListViewController. Remember to rename the class for the corresponding View Controller in the Storyboard as well.
- Exercise your Google-fu and come up with more cool things to make your app do.
