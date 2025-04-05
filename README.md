# WallaMarvel

WallaMarvel is a technical test app that consumes the Marvel API to display a list of superheroes and their related comics. It supports search, pagination, and navigation to a detail view.

---

## 📱 Screenshots

- Heroes List  
![Simulator Screenshot - iPhone 16 Pro - 2025-04-05 at 11 45 26](https://github.com/user-attachments/assets/de42e161-5193-408a-942f-0828fe27d92b)

 
- Hero Detail  
![Simulator Screenshot - iPhone 16 Pro - 2025-04-05 at 11 45 58](https://github.com/user-attachments/assets/4d18aed9-f76c-4b1b-99e3-271c000fbd69)

 
- Empty State on no results  
 ![Simulator Screenshot - iPhone 16 Pro - 2025-04-05 at 11 45 42](https://github.com/user-attachments/assets/e43084f5-6912-4e6a-9fcf-523e30f71692)



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

