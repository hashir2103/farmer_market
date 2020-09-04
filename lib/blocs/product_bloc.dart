import 'dart:async';
import 'dart:io';
import 'package:farmer_market/models/product.dart';
import 'package:farmer_market/services/firebase_storage_services.dart';
import 'package:farmer_market/services/firestore_service.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class ProductBloc {
  //stream Controllers
  final _productName = BehaviorSubject<String>();
  final _unitType = BehaviorSubject<String>();
  final _unitPrice = BehaviorSubject<String>();
  final _availableUnits = BehaviorSubject<String>();
  final _imageUrl = BehaviorSubject<String>();
  final _vendorId = BehaviorSubject<String>();
  final _product = BehaviorSubject<Product>();
  final _productSaved = PublishSubject<bool>();
  final _isImgUploading = BehaviorSubject<bool>();

  //instances
  var uuid = Uuid();
  final db = FirestoreService();
  final _picker = ImagePicker();
  final storageService = FirebaseStorageService();

  //getter

  Stream<String> get productName =>
      _productName.stream.transform(validateProductName);
  Stream<String> get unitType => _unitType.stream;
  Stream<String> get imgUrl => _imageUrl.stream;
  Stream<double> get unitPrice =>
      _unitPrice.stream.transform(validateUnitPrice);
  Stream<int> get availableUnits =>
      _availableUnits.stream.transform(validateAvailableUnits);
  Stream<bool> get isValid => CombineLatestStream.combine4(
      productName, unitType, unitPrice, availableUnits, (a, b, c, d) => true);
  Stream<List<Product>> productByVendorId(String vendorId) =>
      db.fetchProductByVendorId(vendorId);
  Stream<bool> get productSaved => _productSaved.stream;
  Stream<bool> get isImgUploading => _isImgUploading.stream;
  Future<Product> fetchProduct(String productId) => db.fetchProduct(productId);

  //setter

  Function(String) get changeVendorId => _vendorId.sink.add;
  Function(String) get changeProductName => _productName.sink.add;
  Function(String) get changeUnitType => _unitType.sink.add;
  Function(String) get changeUnitPrice => _unitPrice.sink.add;
  Function(String) get changeAvailableUnits => _availableUnits.sink.add;
  Function(String) get changeImgUrl => _imageUrl.sink.add;
  Function(Product) get changeProduct => _product.sink.add;

  dispose() {
    _isImgUploading.close();
    _imageUrl.close();
    _productName.close();
    _unitPrice.close();
    _unitType.close();
    _availableUnits.close();
    _vendorId.close();
    _product.close();
    _productSaved.close();
  }

  //validator
  final validateProductName = StreamTransformer<String, String>.fromHandlers(
      handleData: (productName, sink) {
    if (productName != null) {
      if (productName.length >= 3 && productName.length <= 20) {
        sink.add(productName.trim());
      } else {
        if (productName.length < 3) {
          sink.addError('3 Character Minimum');
        } else {
          sink.addError('20 Character Maximum');
        }
      }
    }
  });
  final validateUnitPrice = StreamTransformer<String, double>.fromHandlers(
      handleData: (unitPrice, sink) {
    if (unitPrice != null) {
      try {
        sink.add(double.parse(unitPrice));
      } catch (e) {
        sink.addError('Must be a number');
      }
    }
  });
  final validateAvailableUnits = StreamTransformer<String, int>.fromHandlers(
      handleData: (availableUnits, sink) {
    if (availableUnits != null) {
      try {
        sink.add(int.parse(availableUnits));
      } catch (e) {
        sink.addError('Must be a whole number');
      }
    }
  });

  //functions

  Future<void> saveProduct() async {
    Product product = Product(
        productId: (_product.value == null)
            ? uuid.v4()
            : _product.value.productId, //==>Random Id
        productName: _productName.value,
        unitType: _unitType.value,
        unitPrice: double.parse(_unitPrice.value),
        availableUnits: int.parse(_availableUnits.value),
        vendorId: _vendorId.value,
        approved: (_product.value == null) ? true : _product.value.approved,
        imageUrl: _imageUrl.value);
    print('=======image=${product.imageUrl}');
    return db
        .setProduct(product)
        .then((value) => _productSaved.sink.add(true))
        .catchError((error) => _productSaved.sink.add(false));
  }

  pickImage() async {
    // ==> it will run if u not given permission if u already give this will skip
    await Permission.photos.request();
    await Permission.camera.request();

    //we have to check permission for ios it work fine with android but in ios program doesnt know where u left of.
    var permissionStatus = [
      await Permission.photos.status,
      await Permission.camera.status
    ];
    PickedFile image;
    File croppedFile;
    if (permissionStatus[0].isGranted || permissionStatus[1].isGranted) {
      image = await _picker.getImage(source: ImageSource.gallery);
      if (image != null) {
        _isImgUploading.sink.add(true);

        //getting image properties
        ImageProperties properties =
            await FlutterNativeImage.getImageProperties(image.path);

        //crop image
        //portrait
        if (properties.height > properties.width) {
          var yOffset = (properties.height - properties.width) / 2;
          croppedFile = await FlutterNativeImage.cropImage(image.path, 0,
              yOffset.toInt(), properties.width, properties.width);
        }
        //landscape
        else if (properties.width > properties.height) {
          var xOffset = (properties.width - properties.height) / 2;
          croppedFile = await FlutterNativeImage.cropImage(image.path,
              xOffset.toInt(), 0, properties.height, properties.height);
        }
        //already squared
        else {
          croppedFile = File(image.path);
        }

        //Resize
        File compressedFile = await FlutterNativeImage.compressImage(
            croppedFile.path,
            quality: 100,
            targetHeight: 600,
            targetWidth: 600);

        var imageUrl =
            await storageService.uploadProductImage(compressedFile, uuid.v4());
        changeImgUrl(imageUrl);
        _isImgUploading.sink.add(false);
      } else {
        print("No path Received");
      }
    } else {
      print("Grant Premission an try again");
    }
  }
}
