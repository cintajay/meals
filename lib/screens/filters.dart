import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _glutenFreeChecked = false;
  var _lactoseFreeChecked = false;
  var _vegetarianChecked = false;
  var _veganChecked = false;

  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filtersProvider); //read instead of watch because init state only executes once anyways

    _glutenFreeChecked = activeFilters[Filters.glutenFree]!;
    _lactoseFreeChecked = activeFilters[Filters.lactoseFree]!;
    _vegetarianChecked = activeFilters[Filters.vegetarian]!;
    _veganChecked = activeFilters[Filters.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Filters")),
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) { //manual implementation of pop after setting canPop false, after adding provider canPop set to true
          if (didPop) {
            return;
          }
          ref.read(filtersProvider.notifier).setFilters({
            Filters.glutenFree: _glutenFreeChecked,
            Filters.lactoseFree: _lactoseFreeChecked,
            Filters.vegetarian: _vegetarianChecked,
            Filters.vegan: _veganChecked,
          });
        },
        child: Column(
          children: [
            SwitchListTile(value: _glutenFreeChecked, onChanged: (isChecked) {
              setState(() {
                _glutenFreeChecked = isChecked;
              });
            },
              title: Text("Gluten Free", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground
              )),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),         
            ),
            SwitchListTile(
              value: _lactoseFreeChecked,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeChecked = isChecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegetarianChecked,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianChecked = isChecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _veganChecked,
              onChanged: (isChecked) {
                setState(() {
                  _veganChecked = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}