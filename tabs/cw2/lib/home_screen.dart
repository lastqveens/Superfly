import 'package:flutter/material.dart';
import 'detailsscreen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> recipes = [
    {
      'name': 'Salsa Verde Chicken',
      'ingredients': '4 (8-ounce) boneless, skinless chicken breasts, 1 teaspoon black pepper, 1 tablespoon olive oil, 1 cup jarred thick salsa verde (such as Casa Martinez), 4 ounces pepper Jack cheese, shredded (about 1 cup), Kosher salt to taste, Chopped fresh cilantro (optional)',
      'instructions': 'Preheat the oven to 425°F. Arrange a rack in the center of the oven. Season the chicken evenly with pepper. Place the chicken in a 12-inch ovenproof skillet or 3-quart baking dish. Drizzle with the oil. Pour the salsa verde over the chicken. Bake until the salsa is bubbly and a thermometer inserted into the thickest part of the chicken registers 140°F, 20 to 25 minutes. (Note: the chicken is not supposed to be fully cooked at this point). Remove from the oven and turn the oven to broil. Sprinkle the chicken with the cheese and return to the oven. Broil until a thermometer inserted into the thickest part of the chicken registers 165°F, and the cheese is melted and browned in spots, about four minutes. Season the chicken with salt to taste.'
    },
    {
      'name': 'Coconut Mango Ice Cream',
      'ingredients': '750g frozen chopped mango, 400ml can coconut cream, 395g can sweetened condensed milk, 600ml thickened cream, 2 tbsp toasted coconut flakes to sprinkle',
      'instructions': 'Place mango and coconut cream in a food processor. Process until mixture is smooth and combined. Using an electric mixer, beat condensed milk and thickened cream until soft peaks form. Fold in mango mixture. Pour mixture into a 9cm-deep, 11.5cm x 20cm metal loaf pan. Sprinkle with coconut flakes. Freeze for 6 hours or overnight. Remove from freezer. Stand at room temperature for 10 minutes. Serve.'
    },
    {
      'name': 'Bar Brownies',
      'ingredients': '6 x 53g Mars bars, chopped, 100g butter, chopped, 3 eggs, lightly whisked, 75g (1/2 cup) self-raising flour, 50g (1/2 cup) cocoa powder',
      'instructions': 'Preheat the oven to 160°C/140°C fan forced. Grease a square 18cm cake pan and line the base with baking paper, extending up 2 sides. Combine the chopped Mars bars and butter in a heatproof bowl and stand the bowl over a pan of simmering water (don’t let the bowl touch the water). Heat, stirring occasionally, until the butter and chocolate have melted but lumps of nougat remain. Remove from the heat and set aside to cool slightly. Add the egg to the chocolate mixture and stir to combine. Sift in the flour and cocoa powder. Fold to combine. Transfer the mixture to the prepared pan, smoothing the top. Bake for 30 minutes or until a skewer inserted into the middle of the brownie comes out with crumbs clinging slightly. Allow to cool in the pan for 10 minutes. Use the paper to lift the brownie from the pan and cut into squares. Serve warm or at room temperature.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Recipes'),
      ),
      backgroundColor: Colors.lightBlue[50],
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recipes[index]['name']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(recipe: recipes[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
