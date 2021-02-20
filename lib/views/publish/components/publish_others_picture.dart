import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PublishOthersPicture extends StatefulWidget {
  String id;
  int typeId;

  int pictureNum = 0;
  List<Asset> img = new List<Asset>();

  PublishOthersPicture({this.id, this.typeId});

  _PublishOthersPictureState createState() => _PublishOthersPictureState();

  Future<List<MultipartFile>> obtainPictures () async {
    if (img.length == 0) return null;

    //处理图片
    List<MultipartFile> imageList = new List<MultipartFile>();
    for (Asset asset in img) {
      //将图片转为二进制数据
      ByteData byteData = await asset.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = new MultipartFile.fromBytes(
        imageData,
        //这个字段要有，否则后端接收为null
        filename: 'load_image',
        //请求contentType，设置一下，不设置的话默认的是application/octet/stream，后台可以接收到数据，但上传后是.octet-stream文件
        contentType: MediaType("image", "jpg"),
      );
      imageList.add(multipartFile);
    }

    return imageList;
  }
}

class _PublishOthersPictureState extends State<PublishOthersPicture> {
  ScrollController _imgController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                widget.img == null ? Expanded(
                  flex: 1,
                  child: Text(""),
                ) : Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: ListView.builder(
                      controller: _imgController,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.img.length,
                      itemBuilder: (context, index){
                        return Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                style: BorderStyle.solid,
                                color: Colors.black26,
                              )
                          ),
                          child: AssetThumb(
                            asset: widget.img[index],
                            width: 50,
                            height: 50,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.black26,
                        )
                    ),
                    child: Center(
                      child: Icon(Icons.camera_alt),
                    ),
                  ),
                  onTap: _openGallerySystem ,
                )
              ],
            )
          ],
        )
    );
  }

  //选择文件上传
  void _openGallerySystem () async {
    List<Asset> resultList = List<Asset>();
    resultList = await MultiImagePicker.pickImages(
      maxImages: 3,
      enableCamera: true,
      selectedAssets: widget.img,
      materialOptions:MaterialOptions(
          startInAllView:true,
          allViewTitle:'所有照片',
          actionBarColor:'#2196F3',
          textOnNothingSelected:'没有选择照片',
          selectionLimitReachedText: "最多选择3张照片"
      ),
    );
    setState(() {
      widget.img = resultList;
    });
  }
}