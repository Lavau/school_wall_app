import 'package:multi_image_picker/multi_image_picker.dart';

class Test{
  List<Asset> images = List<Asset>();

  // 选择照片并上传
  Future<void> uploadImages() async {
    images = List<Asset>();
    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
        // 选择图片的最大数量
        maxImages: 9,
        // 是否支持拍照
        enableCamera: true,
        materialOptions: MaterialOptions(
          // 显示所有照片，值为 false 时显示相册
            startInAllView: true,
            allViewTitle: '所有照片',
            actionBarColor: '#2196F3',
            textOnNothingSelected: '没有选择照片'
        ),
      );
    } on Exception catch (e) {
      e.toString();
    }

    images = (resultList == null) ? [] : resultList;
//    // 上传照片时一张一张上传
//    for(int i = 0; i < images.length; i++) {
//      // 获取 ByteData
//      ByteData byteData = await images[i].getByteData();
//      List<int> imageData = byteData.buffer.asUint8List();
//
//      MultipartFile multipartFile = MultipartFile.fromBytes(
//        imageData,
//        // 文件名
//        filename: 'some-file-name.jpg',
//        // 文件类型
//        contentType: MediaType("image", "jpg"),
//      );
//      FormData formData = FormData.fromMap({
//        // 后端接口的参数名称
//        "files": multipartFile
//      });
//      // 后端接口 url
//      String url = '';
//      // 后端接口的其他参数
//      Map<String, dynamic> params = Map();
//      // 使用 dio 上传图片
//      var response = await Dio().post(url, data: formData, queryParameters: params);
//      //
//      // do something with response...
//    }
  }
}