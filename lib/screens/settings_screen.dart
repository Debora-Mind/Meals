import 'package:flutter/material.dart';

import 'package:meals/screens/main_drawer.dart';
import '../models/settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final settings = Settings();

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _createSwitch(
                  'Sem Glúten',
                  'Só exibe refeições sem glúten',
                  settings.isGlutenFree as bool,
                  (value) => setState(() => settings.isGlutenFree = value),
                ),
                _createSwitch(
                  'Sem Lactose',
                  'Só exibe refeições sem lactose',
                  settings.isLactoseFree as bool,
                  (value) => setState(() => settings.isLactoseFree = value),
                ),
                _createSwitch(
                  'Vegana',
                  'Só exibe refeições veganas',
                  settings.isVegan as bool,
                  (value) => setState(() => settings.isVegan = value),
                ),
                _createSwitch(
                  'Vegetariana',
                  'Só exibe refeições vegetarianas',
                  settings.isVegetarian as bool,
                  (value) => setState(() => settings.isVegetarian = value),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}