import 'package:flutter/material.dart';

Route<dynamic> errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('There was an error in your last request.'),
      ),
    );
  });
}
