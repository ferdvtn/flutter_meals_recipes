import 'package:flutter/material.dart';

import '../main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(this.settings, this.saveSettingHandler, {Key? key})
      : super(key: key);

  static const routeName = 'filters';

  final Map<String, bool> settings;
  final Function saveSettingHandler;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var glutenFree = false;
  var lactoseFree = false;
  var vegan = false;
  var vegetarian = false;

  @override
  void initState() {
    glutenFree = widget.settings['gluten_free'] as bool;
    lactoseFree = widget.settings['lactose_free'] as bool;
    vegan = widget.settings['vegan'] as bool;
    vegetarian = widget.settings['vegetarian'] as bool;

    super.initState();
  }

  Widget _buildSwitchListTile({
    required String title,
    required String subtitle,
    required bool state,
    required Function onChangedHandler,
  }) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: state,
      onChanged: (newValue) => onChangedHandler(newValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Map<String, bool> params = {
                'gluten_free': glutenFree,
                'lactose_free': lactoseFree,
                'vegan': vegan,
                'vegetarian': vegetarian,
              };

              widget.saveSettingHandler(context, params);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Adjust your meal selection',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  title: 'Gluten Free',
                  subtitle: 'Only include gluten free meals',
                  state: glutenFree,
                  onChangedHandler: (newValue) {
                    setState(() => glutenFree = newValue);
                  },
                ),
                _buildSwitchListTile(
                  title: 'Lactose Free',
                  subtitle: 'Only include lactose free meals',
                  state: lactoseFree,
                  onChangedHandler: (newValue) {
                    setState(() => lactoseFree = newValue);
                  },
                ),
                _buildSwitchListTile(
                  title: 'Vegan',
                  subtitle: 'Only include vegan meals',
                  state: vegan,
                  onChangedHandler: (newValue) {
                    setState(() => vegan = newValue);
                  },
                ),
                _buildSwitchListTile(
                  title: 'Vagetarian',
                  subtitle: 'Only include vagetarian meals',
                  state: vegetarian,
                  onChangedHandler: (newValue) {
                    setState(() => vegetarian = newValue);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
