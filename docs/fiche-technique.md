# KIBALU — Fiche Technique

## 1. Structure du Projet

```
12-kibalu/
├── backend/              # API de gestion
│   ├── server.js         # Serveur Express.js
│   ├── package.json      # Dépendances
│   └── db.json           # Base de données simulée
├── web/                  # Frontend
│   └── index.html        # Application React (Babel standalone)
├── mobile/               # Application mobile
│   └── lib/main.dart     # App Flutter
└── docs/                 # Documentation
```

## 2. Spécifications Fonctionnelles

### 2.1 Backend — API REST

| Endpoint | Méthode | Description |
|----------|---------|-------------|
| /api/health | GET | Vérification de l'état du service |
| /api/stats | GET | Statistiques générales |
| /api/users | GET/POST | Gestion des utilisateurs |
| /api/transactions | GET/POST | Gestion des transactions |

### 2.2 Web — Fonctionnalités

- Dashboard avec statistiques en temps réel
- Gestion des entités (selon le projet)
- Interface responsive
- Graphiques et visualisations

### 2.3 Mobile — Fonctionnalités

- Navigation bottom bar
- Dashboard stats
- Gestion des entières
- Notifications push

## 3. Exigences Non-Fonctionnelles

| Exigence | Spécification |
|----------|---------------|
| Performance | Temps de réponse API < 200ms |
| Disponibilité | 99.5% uptime |
| Sécurité | HTTPS, validation des entrées, protection CSRF |
| Compatibilité | iOS 12+, Android 8+, Chrome, Firefox, Safari |
| Accessibilité | WCAG 2.1 AA |

## 4. Planning de Développement

| Phase | Durée | Livrables |
|-------|-------|-----------|
| Phase 1 — MVP | 4 semaines | Backend + Web basique |
| Phase 2 — Mobile | 3 semaines | App Flutter |
| Phase 3 — Features | 3 semaines | Fonctionnalités avancées |
| Phase 4 — Lancement | 2 semaines | Tests, déploiement |

## 5. Équipe Nécessaire

| Rôle | Nombre | Responsabilités |
|------|--------|-----------------|
| Chef de projet | 1 | Coordination, planning |
| Développeur Backend | 1 | API, base de données |
| Développeur Frontend | 1 | Web, UI/UX |
| Développeur Mobile | 1 | App Flutter |
| Designer | 1 | Maquettes, identité visuelle |

## 6. Risques et Mitigations

| Risque | Probabilité | Impact | Mitigation |
|--------|-------------|--------|------------|
| Retard livraison | Moyenne | Élevé | Planning tampon, fournisseurs de secours |
| Problèmes paiement | Faible | Élevé | Intégration Mobile Money, support 24/7 |
| Concurrence | Moyenne | Moyen | Différenciation par la qualité et le service |
| Réglementation | Faible | Élevé | Veille juridique, conformité |

## 7. KPIs de Suivi

| KPI | Objectif | Fréquence |
|-----|----------|-----------|
| Taux de conversion | 3%+ | Hebdomadaire |
| Taux de rétention | 30%+ | Mensuel |
| NPS | 50+ | Mensuel |
| CA mensuel | Objectif projet | Mensuel |
