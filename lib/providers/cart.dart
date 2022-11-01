import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem{
   final String id;
   final String title;
   final int Quantity;
   final double price;

   CartItem({required this.title,required this.id,required this.Quantity,required this.price});
}
class Cart with ChangeNotifier{
    Map<String ,CartItem> _items={};

 Map<String,CartItem>get items{
   return{..._items };
 }
 int get itemCount{
   return _items==null?0:_items .length;
 }

 double get totalAmount {
      var total = 0.0;
      _items.forEach((key, cartItem) {
        total += cartItem.price * cartItem.Quantity;
      });
      return total;
    }
void addItem(String productId,double price,String title){
   if(_items .containsKey(productId)){
_items .update(
  productId, (existingCarItem) =>
    CartItem(
        title: existingCarItem.title,
        id: existingCarItem.id,
        Quantity: existingCarItem.Quantity+1,
        price: existingCarItem.price

    ),

);
   }else{
     _items .putIfAbsent(productId, () =>CartItem(title: title, id:DateTime.now().toString(), Quantity:1, price: price),);
   }

notifyListeners();
}
    void removeItem(String productId) {
      _items.remove(productId);
      notifyListeners();
    }

    void removeSingleItem(String productId) {
      if (!_items.containsKey(productId)) {
        return;
      }
      if (_items[productId]?.Quantity != null) {
        _items.update(
            productId,
                (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              Quantity: existingCartItem.Quantity - 1,
            ));
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }


    void  clear(){
       _items={};
       notifyListeners();
    }
}