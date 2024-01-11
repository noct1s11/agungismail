import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Replace this with your actual data fetching logic
  Future<List<CartItem>> getCartItems() async {
    // Simulating fetching data from an API
    await Future.delayed(Duration(seconds: 2));
    List<String> shoeBrands = ['Nike', 'Adidas', 'Jordan', 'Under Armour', 'Puma'];

    return List.generate(
      shoeBrands.length,
      (index) => CartItem(
        itemName: '${shoeBrands[index]} Basketball Shoe',
        price: 20.0 + index * 5,
        quantity: 10, // Default quantity
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: FutureBuilder(
        future: getCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<CartItem> cartItems = snapshot.data as List<CartItem>;

            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItemWidget(
                  cartItem: cartItems[index],
                  updateState: () {
                    // Trigger a rebuild of the UI
                    setState(() {});
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CartItem extends StatefulWidget {
  final String itemName;
  final double price;
  int quantity;

  CartItem({
    required this.itemName,
    required this.price,
    required this.quantity,
  });

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return CartItemWidget(cartItem: widget, updateState: () {});
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback updateState;

  const CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.updateState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(cartItem.itemName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('\$${cartItem.price.toStringAsFixed(2)}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // Increase quantity
                      cartItem.quantity++;
                      // Trigger a rebuild of the UI
                      updateState();
                    },
                  ),
                  Text('Quantity: ${cartItem.quantity}'),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      // Decrease quantity, but not below 1
                      if (cartItem.quantity > 1) {
                        cartItem.quantity--;
                        // Trigger a rebuild of the UI
                        updateState();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Handle delete button pressed
                      // You can use setState to trigger a rebuild of the UI
                      // Perform the delete operation here
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
