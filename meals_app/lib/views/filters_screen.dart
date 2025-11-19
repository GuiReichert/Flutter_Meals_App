import 'package:flutter/material.dart';

enum FiltersEnum { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<FiltersEnum, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _gluttenFreeFilterConfig = false;
  var _lactoseFreeFilterConfig = false;
  var _vegetarianFilterConfig = false;
  var _veganFilterConfig = false;

  @override
  void initState() {
    super.initState();
    _gluttenFreeFilterConfig = widget.currentFilters[FiltersEnum.glutenFree]!;
    _lactoseFreeFilterConfig = widget.currentFilters[FiltersEnum.lactoseFree]!;
    _vegetarianFilterConfig = widget.currentFilters[FiltersEnum.vegetarian]!;
    _veganFilterConfig = widget.currentFilters[FiltersEnum.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your filters'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          Navigator.pop(context, {
            FiltersEnum.glutenFree: _gluttenFreeFilterConfig,
            FiltersEnum.lactoseFree: _lactoseFreeFilterConfig,
            FiltersEnum.vegetarian: _vegetarianFilterConfig,
            FiltersEnum.vegan: _veganFilterConfig,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _gluttenFreeFilterConfig,
              onChanged: (value) {
                setState(() {
                  _gluttenFreeFilterConfig = value;
                });
              },
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 32),
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only includes gluten-free meals.',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            SwitchListTile(
              value: _lactoseFreeFilterConfig,
              onChanged: (value) {
                setState(() {
                  _lactoseFreeFilterConfig = value;
                });
              },
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 32),
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only includes lactose-free meals.',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            SwitchListTile(
              value: _vegetarianFilterConfig,
              onChanged: (value) {
                setState(() {
                  _vegetarianFilterConfig = value;
                });
              },
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 32),
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only includes vegetarian meals.',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            SwitchListTile(
              value: _veganFilterConfig,
              onChanged: (value) {
                setState(() {
                  _veganFilterConfig = value;
                });
              },
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 32),
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only includes vegan meals.',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
