# Jokes

A SwiftUI application for browsing and enjoying random jokes across different categories with interactive tap-to-reveal punchlines and smooth animations.

## Features

- **Category-based browsing** with 5 tabs: Home, Wordplay, Animals, Food, and Objects
- **Random joke selection** from each category
- **Interactive tap-to-reveal punchline** mechanism with smooth transitions
- **Offline functionality** - all jokes loaded from local JSON file bundled with app
- **Animated UI elements** with bouncing hand gestures and fade effects
- **Loading states and error handling** with user-friendly messages
- **Clean and modern UI** with custom gradient backgrounds
- **About view** with app information and usage instructions
- **Sequential animations** for smooth user experience

## Architecture

The project demonstrates modern SwiftUI patterns and MVVM architecture:

### Model

**Joke** - Decodable model representing joke data
- Contains `type`, `setup`, `punchline`, and `id` properties
- Conforms to `Decodable` and `Identifiable` for JSON parsing and list operations
- All properties use appropriate types (JokeType enum, String, Int)

**JokeType** - Enum representing joke categories
- Cases: `wordplay`, `animal`, `food`, `objects`
- Conforms to `Decodable` with raw String values
- Used for filtering jokes by category

### Service

**FetchService** - Loads and decodes joke data from local JSON file
- Uses `Bundle.main.url` to access bundled JSON resource
- Custom error handling with `FileError` enum (invalidURL, decodingFail, noJokeAvailable)
- Uses `JSONDecoder` to parse jokes from local file
- Filters jokes by type and returns random joke from filtered results
- Returns single `Joke` object based on optional `JokeType` parameter

### ViewModel

**JokeViewModel** - Manages joke state and presentation logic
- Uses `@Observable` macro for reactive UI updates
- `@MainActor` for thread-safe UI updates
- Dependency injection via initializer (receives `FetchService` and `JokeType`)
- Manages punchline reveal state with `isPunchlineRevealed` property
- Controls animation states: `handTapBounce`, `isPunchlineVisible`, `isSetupVisible`, `isHandTapVisible`
- Error state management with optional `errorMessage`
- `loadRanomJoke()` async method for fetching new jokes
- `resetJoke()` method to reset all animation and reveal states
- Stores current `jokeType` for category filtering

### Views

**JokeMainView** - Main TabView container with category navigation
- Uses `TabView` with 5 tabs for different joke categories
- Each tab contains a `NavigationStack` for proper navigation hierarchy
- Home tab displays `JokeMenuView` (welcome screen)
- Other tabs show category-specific `JokeDetailView` instances
- System icons for each category (house, text.page, dog, fork.knife, umbrella)

**JokeMenuView** - Welcome screen with animated instructions
- Custom gradient background using `LinearGradient`
- Sequential fade-in animations for header, subtitle, and hand gesture
- Animated bouncing hand icon using `symbolEffect(.bounce)`
- Toolbar button to present About view as sheet
- Multi-line centered text layout
- Uses async Task with delays for sequential animations

**JokeDetailView** - Interactive joke display with tap-to-reveal
- Custom gradient background matching app theme
- Loading state with `ProgressView`
- Error state with warning icon and message
- Two-phase interaction: tap to reveal punchline, tap again for new joke
- Animated transitions between setup, punchline, and loading states
- Bouncing hand tap icon as interaction hint
- Smooth fade animations controlled by ViewModel state properties
- Complex animation sequences using async Tasks with delays
- Resets joke state on view appearance
- Uses dependency injection in initializer to create ViewModel with FetchService

**JokeAboutView** - Information view displayed as modal sheet
- Custom semi-transparent gradient background
- Explains app functionality and usage
- Mentions offline capability and random selection behavior
- Presented as sheet from JokeMenuView toolbar button

### Constants

**GradientMainBackground** - Defines app-wide gradient colors
- Static array of colors: indigo, cyan, mint
- Used consistently across main app views

**GradientAboutBackground** - Defines About view gradient colors
- Semi-transparent version of main gradient (70% opacity)
- Creates visual distinction for modal presentation

### Dependency Injection

The project uses constructor-based dependency injection at multiple levels:

- `JokeViewModel` receives `FetchService` as a dependency through its initializer
- `JokeDetailView` initializes `JokeViewModel` with fresh `FetchService` instance in its init
- The `type: JokeType` parameter is passed to `JokeDetailView` and forwarded to ViewModel
- This pattern allows for easy testing and swapping implementations
- Promotes loose coupling between views, view models, and services
- Each view instance creates its own ViewModel with dedicated FetchService

### State Management

- `@State` for local view state (ViewModel instance, sheet presentation, animation triggers)
- `@Observable` macro for reactive ViewModel updates
- State-based animation control with boolean flags
- Complex multi-step animations coordinated through async Tasks
- Sequential state changes for smooth visual transitions

## Technologies

- **SwiftUI** - Modern declarative UI framework
- **Async/Await** - Asynchronous joke loading using modern Swift concurrency
- **Local JSON** - Bundled jokes.json file for offline functionality
- **TabView** - Tab-based navigation between categories
- **NavigationStack** - Proper navigation hierarchy within each tab
- **JSON Decoding** - Custom Decodable implementation for jokes
- **Observable** - Using @Observable macro for reactive UI updates
- **Dependency Injection** - Constructor-based DI for testability and flexibility
- **Animation** - Smooth transitions with withAnimation and symbolEffect
- **Sheet Presentation** - Modal About view
- **LinearGradient** - Custom gradient backgrounds for visual appeal
- **ProgressView** - Loading state indicator
- **Task** - Async sequential animations with sleep delays
- **SymbolEffect** - SF Symbols bounce animation for interactive hints

## Requirements

- iOS 26.0+
- Xcode 26.0+
- Swift 6+
- No internet connection required (works offline)
