import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Function(Meal) onToggleFavorite;
  final Function(Meal) isFavorite;

  const MealDetailScreen(this.onToggleFavorite, this.isFavorite, {super.key});

  _createSectionTittle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _createSectionContainer(Widget child) {
    return Container(
        width: 350,
        height: 200,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)?.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          _createSectionTittle(context, 'Ingredientes'),
          _createSectionContainer(
            ListView.builder(
              itemCount: meal.ingredients.length,
              itemBuilder: (ctx, index) {
                return Card(
                  color: Theme.of(context).hintColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(meal.ingredients[index]),
                  ),
                );
              },
            ),
          ),
          _createSectionTittle(context, 'Passos'),
          _createSectionContainer(
            ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Theme.of(context)
                              .primaryTextTheme
                              .titleLarge!
                              .color,
                          child: Text('${index + 1}'),
                        ),
                        title: Text(meal.steps[index]),
                      ),
                      const Divider()
                    ],
                  );
                }),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(meal) ? Icons.star : Icons.star_border),
        onPressed: () => {
          onToggleFavorite(meal),
        },
      ),
    );
  }
}
