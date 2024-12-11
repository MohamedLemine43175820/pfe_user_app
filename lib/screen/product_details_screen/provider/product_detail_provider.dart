
import 'package:flutter/cupertino.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:user_app_pfe/core/data/data_provider.dart';
import 'package:user_app_pfe/models/product.dart';
import 'package:user_app_pfe/utility/snack_bar_helper.dart';
import 'package:user_app_pfe/utility/utility_extention.dart';



class ProductDetailProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  String? selectedVariant;
  var flutterCart = FlutterCart();

  ProductDetailProvider(this._dataProvider);

  void addToCart(Product product) {
    if(product.proVariantId!.isNotEmpty && selectedVariant == null){
      SnackBarHelper.showErrorSnackBar('Pleas select a variant');
      return;
    }
    double? price = product.offerPrice != product.price ? product.offerPrice : product.price;
    flutterCart.addToCart(
      cartModel: CartModel(
          productId: '${product.sId}',
          productName: '${product.name}',
         // productImages: ['${product.images.safeElementAt(0)?.url}'],
          productImages: product.images != null && product.images!.isNotEmpty
              ? ['${product.images!.safeElementAt(0)?.url ?? ''}']
              : [],

          variants: [ProductVariant(price: price ?? 0, color: selectedVariant)],
          productDetails: '${product.description}'),
    );
    selectedVariant = null;
    SnackBarHelper.showSuccessSnackBar('Item Added');
    notifyListeners();
  }


  //? to update UI
  void updateUI() {
    notifyListeners();
  }
}
