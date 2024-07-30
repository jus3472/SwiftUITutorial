// Continuation of boilerplate syntax flow:
// Here are all of the requirements for any struct that conforms to the View protocol: the struct must have a body computed property (BCP), and the body must return a value of type "some View".
// The BCP must return an object (ie container) from a struct that follows the View protocol.
// Note that the BCP must return just 1 view. Thus, usually there is an overarching explicit VStack. If you don't provide an overarching view, for example, you just have an Image and Text view, then Swift implicitly provides an overarching TupleView that is returned. TupleView groups views together without an actual layout behavior, so it leads to unpredictable layout behaviors.
// To reiterate, VStack, Text, and Button are all views, which are objects of their respective structs. VStack is also called a container, and using VStack {} is shorthand for creating an object of the VStack struct.
// Because the Image object and Text object arguments are in the container syntax, there is no need for commas like in the form: VStack(Image(), Text())
// The .imageScale(.large) is a modifier. In reality, it is a method and it follows the form of object.method.


// Key Concepts in SwiftUI:
// Views: The building blocks of the UI. They're technically objects that display UI elements. Examples include Text(), Image(), Button(), etc.
// Modifiers: Functions that modify views. Examples include .padding(), .background(), .font(), etc.
// Navigation: How navigation is handled in SwiftUI using the NavigationView container, NavigationLink child container, and .navigationTitle() and .navigationBarItems() modifiers.
// Lists: A view that displays a scrollable list of inner views using the List container. It comes with many modifiers like .listStyle(), .onDelete(), .onMove(), .listRowBackground(), .listRowInsets(), .listSeparatorStyle().
// State Management: A concept that allows you to control and update parts of the UI in response to data changes. There are 5 essential state tags/property wrappers.

// Please don't compare to CSS, SwiftUI is completely different!

// Essential Layout Modifiers:
// The order of modifiers matters in SwiftUI. For example, if you add a border first and then do padding, the padding will add space around the border. Meanwhile, if you add padding first and then border, the border will encompass the padding.
// To visualize the box model, if you just have content, then the overall view box will directly surround the content. If you add padding, now the overall view box will surround the padding. If you add a border, now the overall view box will surround the border.
// There is no margin in SwiftUI unlike CSS. In SwiftUI, padding acts as both padding in CSS and margin in CSS, depending on when it is used. For example, if padding is used before border, the border encompasses the padding. If padding is used after border, it is like margin in CSS, it pushes the border, and the overall box encompasses the padding.
// When you do padding-leading, space is added to the left side, but it doesn't go over the original overarching box (let's say it's just the content box). The space is added but the content box is shifted right. So if the original overarching box was a rectangle centered, then the new overarching box will also be a rectangle, but it isn't centered anymore. The left edge aligns with the left edge of the original position. The right edge extends further to the right to bc of the padding. In other words, the left half of the overarching box is at the same location, but the right half has been extended.
// It is different if you do padding(), which adds padding to all 4 directions. padding() will just add space outside on all on 4 sides, which pushes other views away. The original content box is in the same location but the overarching box has increased in dimension.
// Note that when the border modifier is applied, it sits directly outside the previous modifier. For example, if a border is applied after a frame, it is outside the frame but directly touching the frame's outer edges.
// Frame is an invisible outline that defines a space which the view and its prior modifiers must fit. If the frame is the last modifier, then the overall box has the same outline. If there are modifiers after frame, then the overall box has the outline of the last modifier. Note that frame will make it so that all past modifiers like border cannot change in size anymore. However, they can still change in location if you add padding after the frame though.
// Position will display the view at a specified x and y coordinate relative to its parent view. However, the actual location is still the original location and so subsequent views will still be placed below. The positioned displayed view can overlap other views.
// Offset has the same properties as position. The only difference being that it will display the view at a specified x and y coordinate relative to its own original position.
// .scaleEffect() will only "visually" enlarge a view. The overarching box is in the same location and has the same size. The scaling will occur in the center of the view, which can make it seem to "grow" in all directions. This is why it doesn't follow vstack's alignment argument. The displayed scaled view can overlap with other views.
// "alignment: .leading" is another argument inside the vstack object. It makes every child view of the vstack align their left edges with the left edge of the vstack. The left edge of the vstack is usually vertically aligned with the leading edge of the widest child view, unless the vstack has an added frame modifier. Note that this isn't like position or offset in that the child elements that are moved are actually moved, and it isn't just visual.
// Spacer is a view like Text, not a modifier. It is a view that doesn't have content. You can specify a min length or by default, it takes up as much space as possible while keeping surrounding views visible.
// To reiterate, SwiftUI's layout system is designed around a container-based approach where views are positioned relative to their parent containers rather than being directly moved. Using alignment properties within containers like VStack, HStack, and ZStack is one of the only ways to genuinely move views by affecting their actual layout frames. These alignment properties reposition the child views within the container, altering their layout structure rather than just their visual representation. While modifiers like position and offset adjust where a view is drawn on the screen, they do not change the underlying view's size and location.

// Essential Appearance Modifiers:
// .font(.system(size: 35)) will increase the font size. It will enlarge the content box size and the content will adjust the fit it. Enlarging the content box will increase the border size as well. And of course, the ovearching box is enlarged. Note that increasing the font size in a frame will not enlarge the content box (bc frame locks past modifiers' sizes) but the content will still increase. This will likely make the text end with a ...
// .font(.largeTitle) provides a font style and also increases the size to a predetermined value. Note that the font style and .foregroundColor() just affects the way the content looks and doesn't affect the content box, padding, border, frame, etc.
// The order you place these modifiers matter: .background(), .cornerRadius(), .shadow(), .opacity()

// Essential List/Navigation Modifiers:
// .navigationTitle() adds a title to the navigation bar and can only be used within a NavigationView container. The NavigationView container allows users to navigate between different views seamlessly. Inside the NavigationView, it expects just one root container, usually a VStack, and not sibling containers like VStack and HStack. When we have a NavigationView with a VStack inside it, the NavigationView reserves space at the top (called the navigation bar). The .navigationTitle() modifier is applied to the root container (e.g., VStack) within the NavigationView or to a NavigationLink view inside the VStack. It places a title in the reserved space at the top, with a specific font, size, and color. The title does not overlap with other views in the VStack.
// .navigationBarItems() adds buttons or other items to reserved space. It must be used within a NavigationView container. The modifier is applied to the root container (e.g., VStack) within the NavigationView or to a NavigationLink view inside the VStack. It is not merely visual; it reserves space in the navigation bar, and other views will respect this space and not overlap. Although the modifier is applied to a VStack, it only affects the reserved space and does not alter the layout or outline of the VStack itself.
// NavigationLink is a container that is only used inside a NavigationView container. It creates a tappable link that when selected, navigates to a different view by going to a new page. Note that only all of views inside the NavigationView are hidden after pressing the link. If you have views like HStack after the NavigationView, they remain visible in the new view.
// .listStyle() changes the visual and behavior of the List. The List container provides a scrollable list of whatever views are inside the container.

// The following Text views follow specfic patterns to demonstrate how the order of modifiers matters. They all end with a border to show what the overall view box looks like.
// PBF, PFB, BPF, BFP, FPB, FBP

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Image(systemName: "globe")
                    .foregroundColor(.red)
                Text("Hello, world!")
                    .font(.system(size: 35))
                
                NavigationLink(destination: DetailView()) {
                    Text("Go to Detail View")
                }
                .navigationTitle("Home")
                
                List {
                    Text("Item 1")
                    Text("Item 2")
                    Text("Item 3")
                }
                .listStyle(DefaultListStyle())
                .frame(width: 150, height: 60, alignment: .center)
                //the "alignment: .center" in the frame makes the content centered in the frame.
                
                Text("num1: testing this very long sentence of mine that is being used for my testing purposes.")
                    .padding()
                    .border(Color.black)
                    .frame(width: 150, height: 56, alignment: .center)
                    .border(Color.black)

                Text("num2: testing this very long sentence of mine that is being used for my testing purposes.")
                    .padding()
                    .frame(width: 150, height: 56, alignment: .center)
                    .border(Color.black)
                
                Text("num3: testing this very long sentence of mine that is being used for my testing purposes.")
                    .border(Color.black)
                    .padding()
                    .frame(width: 150, height: 56, alignment: .center)
                    .border(Color.black)
                
                Text("num4: testing this very long sentence of mine that is being used for my testing purposes.")
                    .border(Color.black)
                    .frame(width: 150, height: 56, alignment: .center)
                    .padding()
                    .border(Color.black)
                
                Text("num5: testing this very long sentence of mine that is being used for my testing purposes.")
                    .frame(width: 150, height: 56, alignment: .center)
                    .padding()
                    .border(Color.black)
                
                Text("num6: testing this very long sentence of mine that is being used for my testing purposes.")
                    .frame(width: 150, height: 56, alignment: .center)
                    .border(Color.black)
                    .padding()
                    .border(Color.black)
            }
            .navigationBarItems(
                leading: Button(action: {
                    print("Leading button tapped")
                }) {
                    Text("Edit")
                },
                trailing: Button(action: {
                    print("Trailing button tapped")
                }) {
                    Image(systemName: "plus")
                }
            )
            // The navigationBarItems method has two arguments, one for the leading parameter and one for the trailing parameter. Each argument is a Button object with one closure for the action parameter and one trailing closure for the label parameter.
        }
            HStack {
                Text("One")
                Spacer()
                Text("Two")
                Spacer()
                Text("Three")
            }
    }
}

struct DetailView: View {
    var body: some View {
        Text("This is the Detail View")
            .navigationTitle("Detail")
    }
}



// Here are the essential state management tags: @State, @Binding, @ObservedObject, @StateObject, @EnvironmentObject

// The @State tag wraps a variable, causing SwiftUI to watch for changes to this variable. If it changes, SwiftUI redraws the parts of the UI where the variable is used. In this example, the Text view displays the content of the placeHolderText variable. When the first button is tapped, it changes placeHolderText to "Woof". Because placeHolderText has a @State tag, the Text view updates to show "Woof". The self is used bc it is referring to the current variable for that specific object. In this case, the object is StateExample() in MyApp.swift. Notice that it isn't assigned to a variable.
struct StateExample: View {
    @State var placeHolderText = "I'm a placeholder"
    
    var body: some View {
        VStack {
            Text("\(self.placeHolderText)")
            
            Button("Dog says") {
                self.placeHolderText = "Woof"
            }
        }
    }
}


// The @Binding tag creates a two-way connection between a variable in one struct and a @Binding variable in another struct. This allows changes from the @Binding variable to update the bounded variable and vice versa. The variable in the first struct is usually a @State variable, but it can be any variable that supports binding.
// A CustomButton object is created. Since it is an object of a struct with a BCP, it will initialize the parameters and then the BCP will return a view. Since there is no variable being assigned the object, the object will simply return the view and then be displayed to the UI. The placeHolderText parameter is referencing the one in the CustomButton struct marked with @Binding, and self.$placeHolderText is the current placeHolderText = "I'm a placeholder". The @State and @Binding variables need to have the same name. The $ indicates that the variable is bounded to the @Binding variable, meaning whenever the @Binding variable changes, the bounded variable also changes, and vice versa. At this point, the @Binding placeHolderText is assigned "I'm a placeholder". Now, the button is displayed, and when pressed, it changes the @Binding placeHolderText to "Meow", which also updates the @State placeHolderText. Consequently, the Text view gets redrawn because it uses the state variable.
struct BindingExample: View {
    @State var placeHolderText = "I'm a placeholder"

    var body: some View {
        VStack {
            Text("\(self.placeHolderText)")
            CustomButton(placeHolderText: self.$placeHolderText)
        }
    }
}
struct CustomButton: View {
    @Binding var placeHolderText: String

    var body: some View {
        Button("Cat says") {
            self.placeHolderText = "Meow"
        }
    }
}


// The @ObservedObject tag is similar to @State in that it watches for changes and, when they occur, redraws the parts of the UI where the variable is used. While @State is used for variables that "store" value-type objects from predefined or custom structs, @ObservedObject is used for variables that "point" to reference-type objects from classes.
// For @State, SwiftUI will only redraw if the entire @State variable changes. For example, if @State var placeHolderText = "I'm a placeholder" is changed to self.placeHolderText = "Meow", it will redraw. Similarly, if @State var placeHolderText = Vehicle() is changed to self.placeHolderText = House(), it will redraw. However, if only a property of the state variable is changed, like self.placeHolderText.car = "blue", it won't trigger a redraw.
// For @ObservedObject, SwiftUI will redraw the parts of the UI that depend on a @Published stored property of the object when that property changes. For example, self.counter.value += 1 changes value, which is @Published, so SwiftUI redraws the UI where counter.value is used. If a stored property that isn't @Published changes, it won't redraw. Additionally, if @ObservedObject var counter = Counter() is reassigned to self.counter = House(), it won't trigger a redraw. It will only redraw if a @Published variable within the object counter points to changes.
// When a variable is given a @ObservedObject tag, it must be assigned an object of a class that conforms to the ObservableObject protocol. Inside this class, there will typically be @Published tags.
class Counter: ObservableObject {
    @Published var count: Int = 0
}
struct ObservedObjectExample: View {
    @ObservedObject var counter = Counter()
    
    var body: some View {
        VStack {
            Text("Counter: \(counter.count)")
            
            Button("Increment") {
                self.counter.count += 1
            }
        }
    }
}


// The @StateObject tag is used exactly the same as @ObservedObject with one exception. In this example, RandomNumberView is the main struct. It displays an overarching VStack, with an inner VStack that contains a simple random number generator. When the user presses the button, randomNumber is assigned a new value, which updates the Text view because it’s a @State variable. However, when the @State variable changes, it also reevaluates the entire BCP where the variable is used.
// When StateObjectExample() returns a VStack with the button, using @StateObject ensures that viewModel's stored properties persist even when the RandomNumberView is reevaluated due to the change in the @State variable. In other words, the reevaluation will not create a new StateObjectExample() object and preserve the current one, keeping viewModel's count the same.
// However, if @ObservedObject were used instead, it would reset viewModel's stored properties every time RandomNumberView is reevaluated, because the reevaluation will create a new StateObjectExample() object, where its viewModel's count is initially 0.
// For example, if the viewModel in StateObjectExample is marked with @StateObject, pressing the "Generate random number" button will not reset the current count to 0.
// However, if viewModel is marked with @ObservedObject instead, pressing the "Generate random number" button will reset the count to 0.
// Note that both @ObservedObject and @StateObject require the variable they are attached to be assigned an object of a class that conforms to the ObservableObject protocol, which typically has @Published stored properties.
class CounterViewModel: ObservableObject {
    @Published var count = 0
}
struct StateObjectExample: View {
    @State var randomNumber = 0
    
    var body: some View {
        VStack {
            VStack {
                Text("Random: \(randomNumber)")
                
                Button("Generate random number") {
                    randomNumber = (0...100).randomElement()!
                }
            }
            CounterView()
        }
    }
}
struct CounterView: View {
    @StateObject var viewModel = CounterViewModel()
    
    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")
            
            Button("Increase count") {
                viewModel.count += 1
            }
        }
    }
}


// The @EnvironmentObject tag allows a variable to access and be assigned an object from a different struct. This object, usually marked by @StateObject or @ObservedObject, must be from a class that conforms to ObservableObject.
// NavigationLink, when pressed, navigates to SettingsView() specified in the "destination:" parameter.
// More specifically, it creates and initializes an object of a struct that has a BCP, and calls the BCP, which returns a new view.
// Typing ".environmentObject(settings)" injects the "settings" object into SettingsView(), allowing any @EnvironmentObject variable to be assigned "settings", only if the @EnvironmentObject object is of the same class as "settings".
// In general, when you use the .environmentObject(settings) modifier, it makes the settings object available to all views within the scope where the modifier is applied.
class SettingsViewModel: ObservableObject {
    @Published var username: String = "Guest"
}
struct EnvironmentObjectExample: View {
    @StateObject var settings = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome, \(settings.username)")
                NavigationLink(destination: SettingsView().environmentObject(settings)) {
                    Text("Go to Settings")
                }
            }
        }
    }
}
struct SettingsView: View {
    @EnvironmentObject var userSettings: SettingsViewModel  //userSettings is of type SettingsViewModel. In other words, it is an object of the SettingsViewModel class. More technically, it's a variable that points to an object of SettingsViewModel.
    
    var body: some View {
        VStack {
            Text("Current username: \(userSettings.username)")
            TextField("New username", text: $userSettings.username)
        }
    }
}
