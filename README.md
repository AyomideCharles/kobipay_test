# kobipayy

A Flutter demo app to view, filter, and analyze transactions. It loads data from a mock API (local JSON), supports filtering by month, and includes smooth animations & charts.

# Set up instructions
- git clone https://github.com/AyomideCharles/kobipay_test.git
- cd transactions-app
- flutter pub get (to install dependencies)
- flutter run

# Features
- Loads transactions from API
- Filter transactions by month
- Pull to refreesh transaction list
- Transaction details screen with a refund button
- Expense chart showing total amount

# Libraries used
- Flutter riverpod
- Flutter screenutil
- intl
- pie_chart
- google fonts


# Design and State management
- Riverpod
- lib/
 ├── core/            
 ├── models/            
 ├── providers/         
 ├── services/          
 ├── widgets/           
 └── views/   


 # Api simulation
 - Transactions are loaded from a local JSON file inside the assets folder