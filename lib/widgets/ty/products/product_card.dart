import 'package:flutter/material.dart';

import 'package:flutter_course/widgets/ty/products/price_tag.dart';
import 'package:flutter_course/widgets/ty/ui_elements/title_default.dart';
import 'package:flutter_course/widgets/ty/products/address_tag.dart';
import 'package:flutter_course/models/product.dart';

import 'package:flutter_course/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;
  final BuildContext context;

  ProductCard(this.product, this.productIndex, this.context);

  Widget _buildTitlePriceRow() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(product.title),
          SizedBox(
            width: 8.0,
          ),
          PriceTag(product.price.toString())
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.info),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  model.selectProduct(model.allProducts[productIndex].id);
                  Navigator.pushNamed<bool>(context,
                          '/product/' + model.allProducts[productIndex].id)
                      .then((_) {
                    model.selectProduct(null);
                  });
                },
              ),
               IconButton(
                icon: Icon(model.allProducts[productIndex].isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Colors.red,
                onPressed: () {
                  model.selectProduct(model.allProducts[productIndex].id);
                  model.toggleProductFavouriteStatus();
                },
              ),
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(product.image),
            placeholder: AssetImage('assets/food.jpg'),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          _buildTitlePriceRow(),
          AddressTag('Union Square, San Francisco'),
          //Text(product.userEmail),
          _buildActionButtons(context)
        ],
      ),
    );
  }
}
