# Locale

# iOS assignment | Locale

1. High-level review of the application.
- Created file structure as per features and includes files(view, viewmodel, subviews..) into one group
- Used MVVM architecture with SOLID principles
- Made project unit testable using dependency injection whereever applicable.
- Improved test coverage for the all viewmodels
- Used composable views to build nested screens
- I would recommond usage of SPM for third party libraries.
- Image loading asynchronously
- I would recommond the modular structure based on feature.
- I would recommond Use Liniting tools eg. SwiftLint

### **Things that can be improved**
- Support of accessibility
- Introduce XCUItest
- Modularization
- Dark theme support
- dynamic fonts
- Indroduce loading indicator
- Introduce internet connectivity and failure and retry screens
- Introduce async/await for better performance and clean architecture. 

##### **Notes: The project works with Xcode 13.4.1 (Not sure about lower version might some apple api won't work) and the language used is Swift. And Run project into simulator land you to insert user location manually.**

##### How project works in simulator 
- User run application its asking for location permission if you allow the permission it will show places without radius. when user add radius manually and search again then i will show places near to user location. when user move and update their location user only show places in the previously set radius.

- if user dont allow location then initially user won't see the places on map. when user press search without or with radius. places are visible according to ip address or api call location.
