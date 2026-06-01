import 'package:flutter/material.dart';

void main() {
  runApp(const CoffeeApp());
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Coffee',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8B5E3C)),
      ),
      home: const OrderPage(),
    );
  }
}

class CoffeeDrink {
  final String name;
  final String details;
  final double price;
  final IconData icon;
  final Color color;

  const CoffeeDrink(this.name, this.details, this.price, this.icon, this.color);
}

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final List<CoffeeDrink> drinks = const [
    CoffeeDrink(
      'Vanilla Latte',
      'Espresso, steamed milk, and vanilla',
      4.75,
      Icons.local_cafe_rounded,
      Color(0xFF8B5E3C),
    ),
    CoffeeDrink(
      'Iced Caramel Macchiato',
      'Cold milk, espresso, and caramel',
      5.25,
      Icons.icecream_rounded,
      Color(0xFFD98C3F),
    ),
    CoffeeDrink(
      'Iced Brown Sugar Oatmilk Shaken Espresso',
      'Oatmilk, brown sugar, and espresso',
      5.75,
      Icons.local_drink_rounded,
      Color(0xFF5C4033),
    ),
    CoffeeDrink(
      'Chai Latte',
      'Chai and steamed milk, hot or iced',
      4.95,
      Icons.local_cafe_rounded,
      Color(0xFF2F5D7C),
    ),
  ];

  int selectedDrink = -1;
  int quantity = 1;
  bool addFlavor = false;
  String flavorChoice = 'Vanilla';
  double tipPercent = 0.10;
  bool orderPlaced = false;

  double get drinkPrice {
    if (selectedDrink == -1) {
      return 0;
    }
    return drinks[selectedDrink].price;
  }

  double get flavorPrice {
    return addFlavor ? 0.75 : 0;
  }

  double get subtotal {
    return (drinkPrice + flavorPrice) * quantity;
  }

  double get tipAmount {
    return subtotal * tipPercent;
  }

  double get total {
    return subtotal + tipAmount;
  }

  void placeOrder() {
    if (selectedDrink == -1) {
      return;
    }

    setState(() {
      orderPlaced = true;
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Order Confirmed'),
          content: Text(
            'Your total is ${money(total)}. Your coffee will be ready soon!',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: ListView(
              padding: const EdgeInsets.all(18),
              children: [
                const Header(),
                const SizedBox(height: 20),
                const Text(
                  'Choose your drink',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                for (int i = 0; i < drinks.length; i++)
                  DrinkCard(
                    drink: drinks[i],
                    selected: selectedDrink == i,
                    onTap: () {
                      setState(() {
                        selectedDrink = i;
                        orderPlaced = false;
                      });
                    },
                  ),
                const SizedBox(height: 12),
                if (selectedDrink == -1)
                  const SelectMessage()
                else
                  Column(
                    children: [
                      QuantityCard(
                        quantity: quantity,
                        onMinus: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                              orderPlaced = false;
                            });
                          }
                        },
                        onPlus: () {
                          setState(() {
                            quantity++;
                            orderPlaced = false;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Card(
                        child: SwitchListTile(
                          title: const Text(
                            'Add a flavor shot',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text('Adds \$0.75 to each drink'),
                          value: addFlavor,
                          activeThumbColor: const Color(0xFF8B5E3C),
                          onChanged: (value) {
                            setState(() {
                              addFlavor = value;
                              orderPlaced = false;
                            });
                          },
                        ),
                      ),
                      if (addFlavor)
                        Card(
                          color: const Color(0xFFFFF0DD),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Choose a flavor',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5C4033),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  children: [
                                    ChoiceChip(
                                      label: const Text('Vanilla'),
                                      selected: flavorChoice == 'Vanilla',
                                      onSelected: (_) {
                                        setState(() {
                                          flavorChoice = 'Vanilla';
                                          orderPlaced = false;
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      label: const Text('Caramel'),
                                      selected: flavorChoice == 'Caramel',
                                      onSelected: (_) {
                                        setState(() {
                                          flavorChoice = 'Caramel';
                                          orderPlaced = false;
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      label: const Text('Mocha'),
                                      selected: flavorChoice == 'Mocha',
                                      onSelected: (_) {
                                        setState(() {
                                          flavorChoice = 'Mocha';
                                          orderPlaced = false;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 10),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Tip',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${(tipPercent * 100).round()}%',
                                    style: const TextStyle(
                                      color: Color(0xFF8B5E3C),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              // New UI element explored: Slider for choosing a tip amount.
                              Slider(
                                value: tipPercent,
                                min: 0,
                                max: 0.25,
                                divisions: 5,
                                label: '${(tipPercent * 100).round()}%',
                                activeColor: const Color(0xFF8B5E3C),
                                onChanged: (value) {
                                  setState(() {
                                    tipPercent = value;
                                    orderPlaced = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TotalCard(
                        drinkName: drinks[selectedDrink].name,
                        quantity: quantity,
                        addFlavor: addFlavor,
                        flavorChoice: flavorChoice,
                        subtotal: subtotal,
                        tipAmount: tipAmount,
                        total: total,
                      ),
                    ],
                  ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: selectedDrink == -1 ? null : placeOrder,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5E3C),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Place Order',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (orderPlaced)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF0DD),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE4C39D)),
                    ),
                    child: const Text(
                      'Thanks! Your coffee order is in progress.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF5C4033),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF8B5E3C),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.local_cafe_rounded,
            color: Colors.white,
            size: 36,
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Campus Coffee',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Fresh coffee between classes',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DrinkCard extends StatelessWidget {
  final CoffeeDrink drink;
  final bool selected;
  final VoidCallback onTap;

  const DrinkCard({
    super.key,
    required this.drink,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: selected ? drink.color : const Color(0xFFE8DFD5),
          width: selected ? 2 : 1,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: drink.color.withValues(alpha: 0.15),
          child: Icon(drink.icon, color: drink.color),
        ),
        title: Text(
          drink.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(drink.details),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              money(drink.price),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: selected ? drink.color : Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class SelectMessage extends StatelessWidget {
  const SelectMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: const [
            Icon(Icons.touch_app_rounded, color: Color(0xFF8B5E3C)),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Pick a coffee drink to see your total and extra options.',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuantityCard extends StatelessWidget {
  final int quantity;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const QuantityCard({
    super.key,
    required this.quantity,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'Quantity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: onMinus,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text(
              '$quantity',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: onPlus,
              icon: const Icon(Icons.add_circle),
              color: const Color(0xFF8B5E3C),
            ),
          ],
        ),
      ),
    );
  }
}

class TotalCard extends StatelessWidget {
  final String drinkName;
  final int quantity;
  final bool addFlavor;
  final String flavorChoice;
  final double subtotal;
  final double tipAmount;
  final double total;

  const TotalCard({
    super.key,
    required this.drinkName,
    required this.quantity,
    required this.addFlavor,
    required this.flavorChoice,
    required this.subtotal,
    required this.tipAmount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2B211C),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SummaryRow(label: '$quantity x $drinkName', value: ''),
            if (addFlavor)
              SummaryRow(label: '$quantity x $flavorChoice flavor', value: ''),
            const Divider(color: Colors.white30),
            SummaryRow(label: 'Subtotal', value: money(subtotal)),
            SummaryRow(label: 'Tip', value: money(tipAmount)),
            const Divider(color: Colors.white30),
            SummaryRow(
              label: 'Total',
              value: money(total),
              large: true,
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool large;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: large ? 18 : 14,
                fontWeight: large ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: large ? const Color(0xFFFFD166) : Colors.white,
              fontSize: large ? 20 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

String money(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}
