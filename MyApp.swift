// Swift is analogous to JavaScript. SwiftUI is analogous to html, css, and react hooks.

// Boilerplate syntax flow:
// The main tag marks the entry point of the app. Under it, it requires a struct that conforms to the App protocol. The struct's name can be anything.
// Here are all of the requirements for any struct that conforms to the App protocol: the struct must have a body computed property (bcp), and the body must return a value of type "some Scene".
// Remember that for all computed properties including the bcp, must have a get block and an optional set block. Here, the get block is implicit.
// Normally, to the right of the colon of a computed property, is the return type like Double or String. This is saying that this computed property must return an object of the Double or String struct. Remember that when an object of a struct is assigned to a variable, that variable directly stores that object.
// However "some Scene" is saying that the computed property must return an object of any struct (rarely class) that follows the "Scene" protocol.
// WindowGroup {} is called a container. It is shorthand for just creating an object of the WindowGroup struct (which follows the Scene protocol). The ContentView() is the argument inside the parenthesis when you create the WindowGroup object. Longhand would look like "WindowGroup(ContentView())".
// If you create an object of a struct without a bcp, it just initializes the arguments if there are any. Then if you want to call a computed property from the struct, you would just do object.computedProperty or rect.area.
// If you create an object of a struct with a bcp, it initializes the arguments if there are any, and then automatically calls the bcp which returns some view.

import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            
            //StateExample()
            //BindingExample()
            //ObservedObjectExample()
            //StateObjectExample()
            //EnvironmentObjectExample()
        }
    }
}
