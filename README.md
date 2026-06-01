
## Overview

The app allows users to browse a coffee menu, select drinks, view pricing updates, and place an order through an interactive user interface.

## Features

### Coffee Menu
Users can browse a menu containing multiple coffee options. Each item includes:

- Product name
- Product price
- Visual representation
- Selection controls

### Dynamic State Management

The application uses Flutter state management to:

- Track selected items
- Update the user interface in real time
- Calculate pricing automatically
- Enable order interactions

### Conditional User Interface

- Displaying order summaries
- Showing confirmation messages
- Revealing additional options after selections

### Total Price Calculation

As users select drinks, the application automatically:

- Calculates subtotal
- Updates total price
- Reflects changes immediately on screen

### Order Confirmation

Before completing an order, users receive a confirmation that summarizes their selections and confirms order placement.

## Technologies Used

- Flutter
- Dart
- Visual Studio Code
  
## Run

```bash
flutter pub get
flutter run -d chrome
```
