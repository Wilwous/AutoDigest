# 🚗 AutoDigest

Приложение для просмотра автомобильных новостей, разработанное в рамках тестового задания для Autodoc.

🎥 [Скринкаст демо](https://disk.yandex.ru/d/XafwybgE36HuaQ)

---

## 📲 Описание

AutoDigest получает данные с публичного API и отображает их в виде новостной ленты. Пользователь может пролистывать новости, кликать на карточку и открывать её содержимое во встроенном браузере. Все изображения кэшируются локально.

---

## 🧩 Технологии

- UIKit
- UICollectionView + CompositionalLayout
- DiffableDataSource
- Combine
- MVVM
- async/await
- NSCache (кэш изображений)
- SFSafariViewController

---

## ✨ Функциональность

- Загрузка новостей с API (постранично)
- Интерактивная лента с адаптивной версткой
- Адаптация под iPhone и iPad
- Кэширование изображений
- Переход к полному источнику новости по ссылке
- Обработка ошибок с алертом

---

## 📁 Структура проекта

- `View/`
  - `NewsViewController.swift` — главный экран, конфигурирует UI, биндинг, snapshot и обработку выбора ячеек
  - `NewsCell.swift` — кастомная UICollectionViewCell с изображением и заголовком (с закруглёнными краями)
  - `NewsLayoutProvider.swift` — отвечает за адаптивную компоновку (разметку ленты)
- `ViewModel/`
  - `NewsViewModel.swift` — управляет загрузкой данных, обработкой ошибок и pagination
- `Model/`
  - `NewsItem.swift` — модель новости
  - `NewsResponse.swift` — модель ответа от API
- `Service/`
  - `NewsService.swift` — реализация сетевого слоя
  - `ImageCache.swift` — кэш изображений
- `Utils/`
  - `WebOpener.swift` — открытие ссылок через SFSafariViewController
  - `UIViewController+Alert.swift` — расширение для отображения алертов

---

## ⚙️ Требования

- iOS 15.0+
- Swift 5.9+
- Xcode 15+

---

## 📬 Автор

**Антон Павлов**  
Telegram: [@Wilwous](https://t.me/Wilwous)
