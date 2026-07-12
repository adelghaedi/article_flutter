# article_flutter

A Flutter application for managing articles, built as a practice project to demonstrate clean architecture with GetX state management and Dio HTTP client.

## Features

- List all articles with status badges (published / draft)
- Add new article with title, content, image, and active status
- Edit existing articles
- Delete articles
- Image picker support (gallery)
- RTL layout support (Persian)

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter |
| State Management | GetX |
| HTTP Client | Dio |
| Architecture | Repository Pattern |

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- A running instance of [article_drf](https://github.com/adelghaedi/article_drf)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/adelghaedi/article_flutter.git
cd article_flutter
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run -d chrome   # Web
flutter run             # Mobile
```

## Backend

This project connects to a Django REST Framework backend.
See [article_drf](https://github.com/adelghaedi/article_drf) for the backend source code.
