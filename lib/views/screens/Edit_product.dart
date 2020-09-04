import 'package:farmer_market/blocs/auth_bloc.dart';
import 'package:farmer_market/blocs/product_bloc.dart';
import 'package:farmer_market/models/product.dart';
import 'package:farmer_market/style/baseStyle.dart';
import 'package:farmer_market/style/colorsStyle.dart';
import 'package:farmer_market/style/textstyle.dart';
import 'package:farmer_market/views/widgets/AppButton.dart';
import 'package:farmer_market/views/widgets/AppDropDown.dart';
import 'package:farmer_market/views/widgets/AppSliverScaffold.dart';
import 'package:farmer_market/views/widgets/AppTexField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final String productId;

  const EditProduct({Key key, this.productId}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  void initState() {
    final productBloc = Provider.of<ProductBloc>(context, listen: false);
    productBloc.productSaved.listen((saved) {
      if (saved != null && saved == true && context != null) {
        Fluttertoast.showToast(
            msg: "Product Saved",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: AppColor.lightblue,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var productBloc = Provider.of<ProductBloc>(context);
    var authBloc = Provider.of<AuthBloc>(context);

    return FutureBuilder<Product>(
        future: productBloc.fetchProduct(widget.productId),
        builder: (context, snapshot) {
          //if we are editing product iD !=null and we have not yet recieve data from firebase thn
          if (!snapshot.hasData && widget.productId != null) {
            return Scaffold(
              body: Center(
                  child: (Platform.isIOS)
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator()),
            );
          }

          Product existingProduct;
          if (widget.productId != null) {
            // Edit logic
            existingProduct = snapshot.data;
            loadValues(productBloc, existingProduct, authBloc.userId);
          } else {
            // add logic
            loadValues(productBloc, null, authBloc.userId);
          }

          return (Platform.isIOS)
              ? AppSliverScaffold.cupertinoSliverScaffold(
                  navTitle: '',
                  pageBody:
                      pageBody(true, productBloc, context, existingProduct),
                  context: context,
                )
              : AppSliverScaffold.materialSliverScaffold(
                  navTitle: '',
                  pageBody:
                      pageBody(false, productBloc, context, existingProduct),
                  context: context);
        });
  }

  Widget pageBody(
      bool isIOS, ProductBloc productBloc, context, Product existingProduct) {
    var items = Provider.of<List<String>>(context);
    var pageLabel = (existingProduct != null) ? 'Edit Product' : 'Add Product';
    return ListView(
      children: [
        Text(
          pageLabel,
          style: TextStyles.subTitle,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: BaseStyle.listPadding,
          child: Divider(
            color: AppColor.darkblue,
          ),
        ),
        StreamBuilder<String>(
            stream: productBloc.productName,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: isIOS,
                hintText: 'Product Name',
                cupertinoIcon: FontAwesomeIcons.shoppingBag,
                materialIcon: FontAwesomeIcons.shoppingBag,
                errorText: snapshot.error,
                initialText: (existingProduct != null)
                    ? existingProduct.productName
                    : null,
                onChanged: productBloc.changeProductName,
              );
            }),
        StreamBuilder<String>(
            stream: productBloc.unitType,
            builder: (context, snapshot) {
              return AppDropDownButton(
                items: items,
                hintText: 'Unit Type',
                materialIcon: FontAwesomeIcons.balanceScale,
                cupertinoIcon: FontAwesomeIcons.balanceScale,
                onChanged: productBloc.changeUnitType,
                value: snapshot.data,
              );
            }),
        StreamBuilder<double>(
            stream: productBloc.unitPrice,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: isIOS,
                hintText: 'Unit Price       ',
                textInputType: TextInputType.number,
                cupertinoIcon: FontAwesomeIcons.tag,
                materialIcon: FontAwesomeIcons.tag,
                errorText: snapshot.error,
                initialText: (existingProduct != null)
                    ? existingProduct.unitPrice.toString()
                    : null,
                onChanged: productBloc.changeUnitPrice,
              );
            }),
        StreamBuilder<int>(
            stream: productBloc.availableUnits,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: isIOS,
                hintText: 'Available Units',
                textInputType: TextInputType.number,
                cupertinoIcon: FontAwesomeIcons.hashtag,
                materialIcon: FontAwesomeIcons.hashtag,
                errorText: snapshot.error,
                initialText: (existingProduct != null)
                    ? existingProduct.availableUnits.toString()
                    : null,
                onChanged: productBloc.changeAvailableUnits,
              );
            }),
        StreamBuilder<bool>(
            stream: productBloc.isImgUploading,
            builder: (context, snapchot) {
              return (!snapchot.hasData || snapchot.data == false)
                  ? Container()
                  : Center(
                      child: (Platform.isIOS)
                          ? CupertinoActivityIndicator()
                          : CircularProgressIndicator());
            }),
        StreamBuilder<String>(
            stream: productBloc.imgUrl,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == "") {
                return AppButton(
                  buttonText: 'Add Image',
                  buttonType: ButtonType.Straw,
                  onPressed: productBloc.pickImage,
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: BaseStyle.listPadding,
                    child: Image.network(snapshot.data),
                  ),
                  AppButton(
                    buttonText: 'Change Image',
                    buttonType: ButtonType.Straw,
                    onPressed: productBloc.pickImage,
                  )
                ],
              );
            }),
        StreamBuilder<bool>(
            stream: productBloc.isValid,
            builder: (context, snapshot) {
              return AppButton(
                  onPressed: productBloc.saveProduct,
                  buttonText: 'Save Product',
                  buttonType: (snapshot.data == true)
                      ? ButtonType.DarkBlue
                      : ButtonType.Disable);
            }),
      ],
    );
  }

  loadValues(ProductBloc productBloc, Product product, String vendorId) {
    productBloc.changeProduct(product);
    productBloc.changeVendorId(vendorId);
    if (product != null) {
      //edit
      productBloc.changeUnitType(product.unitType);
      productBloc.changeProductName(product.productName);
      productBloc.changeUnitPrice(product.unitPrice.toString());
      productBloc.changeAvailableUnits(product.availableUnits.toString());
      productBloc.changeImgUrl(product.imageUrl ?? '');
    } else {
      //add
      productBloc.changeUnitType(null);
      productBloc.changeProductName(null);
      productBloc.changeUnitPrice(null);
      productBloc.changeAvailableUnits(null);
      productBloc.changeImgUrl('');
    }
  }
}
