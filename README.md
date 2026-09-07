# KIBALU

Sécurité — E-commerce + Dashboard dispositifs GPS

**Organisation :** KIBALU Security

## Structure

```
12-kibalu/
├── backend/          # Express.js API (Port 3012)
│   ├── server.js
│   ├── package.json
│   └── db.json
├── web/              # React frontend (HTML + Babel standalone)
│   └── index.html
└── mobile/           # Flutter app
    └── lib/main.dart
```

## Démarrage

```bash
# Backend
cd 12-kibalu/backend
npm install
npm start

# Web — Ouvrir 12-kibalu/web/index.html dans un navigateur
# ou servir avec: npx serve 12-kibalu/web

# Mobile
cd 12-kibalu/mobile
flutter pub get
flutter run
```

## API

| Endpoint | Description |
|----------|-------------|
| GET /api/health | Health check |
| GET /api/stats | Statistiques |
