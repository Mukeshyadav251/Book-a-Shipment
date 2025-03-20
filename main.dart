import 'package:flutter/material.dart';

void main() {
  runApp(BookShipment());
}

class BookShipment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookShipmentScreen(),
    );
  }
}

class BookShipmentScreen extends StatefulWidget {
  @override
  _BookShipmentScreenState createState() => _BookShipmentScreenState();
}

class _BookShipmentScreenState extends State<BookShipmentScreen> {
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController deliveryController = TextEditingController();
  String? selectedCourier;
  double price = 0.0;

  final List<String> couriers = ["Delhivery", "DTDC", "Bluedart"];

  void calculatePrice() {
    if (pickupController.text.isEmpty || deliveryController.text.isEmpty || selectedCourier == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() {

      price = (pickupController.text.length + deliveryController.text.length) * 2.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book a Shipment")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: pickupController,
              decoration: InputDecoration(labelText: "Pickup Address"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: deliveryController,
              decoration: InputDecoration(labelText: "Delivery Address"),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Select Courier"),
              value: selectedCourier,
              items: couriers.map((courier) {
                return DropdownMenuItem(
                  value: courier,
                  child: Text(courier),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCourier = value;
                });
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: calculatePrice,
              child: Text("Calculate Price"),
            ),
            SizedBox(height: 10),
            Text("Estimated Price: ₹$price", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (price > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Shipment Booked Successfully!")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please calculate the price first")),
                  );
                }
              },
              child: Text("Submit & Pay"),
            ),
          ],
        ),
      ),
    );
  }
}
