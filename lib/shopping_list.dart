import 'package:flutter/material.dart';

// -----------------商品列表中一件商品------------------ //
class Product {
  const Product({this.name});
  final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({Product product, this.inCart, this.onCartChanged}) 
    : product=product, super(key: ObjectKey(product));

  // 将其在构造函​​数中接收到的值存储在final成员变量中，然后在build函数中使用
  final Product product;
  // inCart布尔值表示在两种视觉展示效果之间切换：一个使用当前主题的主色，另一个使用灰色
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54: Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

// -------------------商品列表-------------------- //
class ShoppingList extends StatefulWidget {
  // Key在构建相同类型widget的多个实例时很有用
  // 通过给列表中的每个条目分配为“语义” key，无限列表可以更高效，因为框架将同步条目与匹配的语义key并因此具有相似（或相同）的可视外观
  // 语义上同步条目意味着在有状态子widget中，保留的状态将附加到相同的语义条目上，而不是附加到相同数字位置上的条目
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  // 调用其 createState 函数以创建一个新的_ShoppingListState实例来与该树中的相应位置关联
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    // 调用setState将该widget标记为”dirty”(脏的)，并且计划在下次应用程序需要更新屏幕时重新构建它
    setState(() {
      // 处理onCartChanged回调时，_ShoppingListState通过添加或删除产品来改变其内部_shoppingCart状态
      if (inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        // 访问当前ShoppingList的属性，_ShoppingListState可以使用它的widget属性
        // 如果父级重建并创建一个新的ShoppingList，那么 _ShoppingListState不会重新构建，但其widget的属性会更新为新构建的widget
        // 如果希望在widget属性更改时收到通知，则可以覆盖didUpdateWidget函数，以便将旧的oldWidget与当前widget进行比较
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Shopping App',
    home: ShoppingList(
      products: <Product>[
        Product(name: 'Eggs'),
        Product(name: 'Flour'),
        Product(name: 'Chocolate chips'),
      ],
    )
  ));
}