import 'package:flutter/material.dart';

void main() {
  runApp(const DashboardApp());
}

class DashboardApp extends StatefulWidget {
  const DashboardApp({super.key});

  @override
  State<DashboardApp> createState() => _DashboardAppState();
}

class _DashboardAppState extends State<DashboardApp> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: DashboardScreen(
        onToggleTheme: () {
          setState(() => darkMode = !darkMode);
        },
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const DashboardScreen({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(onToggleTheme: onToggleTheme),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: const [
                        StatCard(title: "Tasks", value: "24"),
                        StatCard(title: "Completed", value: "18"),
                        StatCard(title: "Pending", value: "6"),
                        TaskCard(),
                        TaskCard(),
                        TaskCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Column(
        children: const [
          SizedBox(height: 40),
          Icon(Icons.dashboard, size: 40),
          SizedBox(height: 40),
          SidebarItem("Dashboard"),
          SidebarItem("Tasks"),
          SidebarItem("Settings"),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final String text;

  const SidebarItem(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}

class Header extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const Header({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Dashboard",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        IconButton(
          icon: const Icon(Icons.dark_mode),
          onPressed: onToggleTheme,
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value,
              style:
                  const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          Text(title),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.task),
        title: const Text("Design new UI"),
        subtitle: const Text("High priority"),
        trailing: Checkbox(value: false, onChanged: (_) {}),
      ),
    );
  }
}
