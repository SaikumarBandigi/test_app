import 'package:flutter/material.dart';
import 'LoginPage.dart'; // Import the LoginPage to navigate back on logout

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Map<String, int> cart = {}; // Store item quantities

  void _addToCart(String itemName) {
    setState(() {
      if (cart.containsKey(itemName)) {
        cart[itemName] = cart[itemName]! + 1;
      } else {
        cart[itemName] = 1;
      }
    });
  }

  // Function to show a confirmation dialog before logging out
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logout(); // Proceed to logout
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(), // Navigate to login page on logout
      ),
    );
  }

  void _showFullImage(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content:
              Image.asset(imagePath, fit: BoxFit.cover), // Display full image
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> menuItems = [
      {'name': 'Chicken Biryani Full', 'image': 'assets/images/Full.jpg'},
      {'name': 'Chicken Biryani Single', 'image': 'assets/images/Single.jpg'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _showLogoutDialog, // Call the logout confirmation dialog
          ),
        ],
      ),
      body: Column(
        children: menuItems.map((menuItem) {
          return Expanded(
            child: Card(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showFullImage(menuItem['image']!),
                      child: Image.asset(
                        menuItem['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      menuItem['name']!,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _addToCart(menuItem['name']!),
                    child: Text('Add to Cart'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'In Cart: ${cart[menuItem['name']] ?? 0}', // Show the current quantity in cart
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
