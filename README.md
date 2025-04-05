# WallaMarvel

WallaMarvel is a technical test app that consumes the Marvel API to display a list of superheroes and their related comics. It supports search, pagination, and navigation to a detail view.

---

## 📱 Screenshots

> _You can add screenshots here once ready using markdown syntax._

- Heroes List  
  ![Simulator Screenshot - iPhone 16 Pro - 2025-04-05 at 11 45 26](https://github.com/user-attachments/assets/95e9656d-3ed4-43d8-b013-33e442b2bef8)

- Hero Detail  
  ![Simulator Screenshot - iPhone 16 Pro - 2025-04-05 at 11 45 58](https://github.com/user-attachments/assets/f00264e2-adb6-4733-9e40-9b7f58535258)


- Empty State on no results  
  ![Simulator Screenshot - iPhone 16 Pro - 2025-04-05 at 11 45 42](https://github.com/user-attachments/assets/706ec8ec-b27b-40c5-a5b3-0415a8cae7f0)


---

## 🚀 Features

- ✅ Infinite scroll with pagination.
- ✅ Real-time search with empty state feedback.
- ✅ Hero detail view with image and comic list.
- ✅ Decoupled architecture (MVP + Clean Layers).
- ✅ Visual empty state label for no search results.
- ✅ Fully tested: Presenters, Use Cases, Repositories, DataSources, and APIClient.
- ✅ UI tests using XCTest (search + navigation).

---

## 🧱 Architecture

The project follows clean architecture principles, split into the following layers:

- **UI (UIKit + SwiftUI):** View controllers and reusable components.
- **Presenter:** Presentation logic, fully decoupled from UI.
- **Use Cases:** Application-specific business logic.
- **Repository:** Abstraction over the data source layer.
- **Data Source:** Responsible for accessing external APIs.
- **APIClient:** Low-level HTTP request abstraction.
- **Models:** Clean, decodable data structures.

