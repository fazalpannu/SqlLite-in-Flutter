import 'package:ch13/card.dart';
import 'package:ch13/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cartprovider with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  double _totalprices = 0;
  dbhelper _dbhelper = dbhelper();
  double get totalprices => _totalprices;
  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getdata() async {
    _cart = _dbhelper.getcartlist();
    return _cart;
  }

  void _setpreference() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setInt('cart_item', _counter);
    pre.setDouble('total_price', _totalprices);
    notifyListeners();
  }

  void _getpreference() async {
    SharedPreferences pre = await SharedPreferences.getInstance();

    _counter = pre.getInt('cart_item') ?? 0;

    _totalprices = pre.getDouble('total_price') ?? 0.0;

    notifyListeners();
  }

  void addtotalprices(double totalprices) {
    _totalprices = _totalprices + totalprices;
    _setpreference();

    notifyListeners();
  }

  void removetotalprices(double totalprices) {
    _totalprices = _totalprices - totalprices;
    _setpreference();

    notifyListeners();
  }

  double gettotalprices() {
    _getpreference();
    return _totalprices;
  }

  void addcounter() {
    _counter++;
    _setpreference();

    notifyListeners();
  }

  void removecounter() {
    _counter--;
    _setpreference();

    notifyListeners();
  }

  int getcounter() {
    _getpreference();
    return _counter;
  }
}
