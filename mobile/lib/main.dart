import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const KibaluApp());
}

class KibaluApp extends StatelessWidget {
  const KibaluApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KIBALU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE53E3E)),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE53E3E),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  Map<String, dynamic> stats = {};

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    try {
      final res = await http.get(Uri.parse('http://localhost:3012/api/stats'));
      if (res.statusCode == 200) {
        setState(() => stats = json.decode(res.body));
      }
    } catch (e) {
      // Offline mode
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KIBALU', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _currentIndex == 0
          ? _buildHome()
          : _currentIndex == 1
              ? _buildServices()
              : _buildProfile(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Bienvenue sur KIBALU',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Plateforme professionnelle adaptée au Congo-Brazzaville',
          style: TextStyle(color: Colors.grey[400]),
        ),
        const SizedBox(height: 24),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _StatCard(icon: Icons.people, value: '${stats['users'] ?? stats['products'] ?? stats['federations'] ?? stats['artists'] ?? stats['clients'] ?? stats['players'] ?? stats['investors'] ?? 0}', label: 'Utilisateurs'),
            _StatCard(icon: Icons.shopping_cart, value: '${stats['orders'] ?? stats['tickets'] ?? stats['clubs'] ?? stats['events'] ?? stats['projects'] ?? stats['tournaments'] ?? stats['transactions'] ?? 0}', label: 'Commandes'),
            _StatCard(icon: Icons.attach_money, value: '${stats['revenue'] ?? stats['totalInvestments'] ?? 0} F', label: 'CA'),
            _StatCard(icon: Icons.trending_up, value: 'Actif', label: 'Statut'),
          ],
        ),
      ],
    );
  }

  Widget _buildServices() {
    return const Center(child: Text('Services bientôt disponibles'));
  }

  Widget _buildProfile() {
    return const Center(child: Text('Profil utilisateur'));
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 32),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
