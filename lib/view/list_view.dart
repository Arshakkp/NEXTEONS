import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macchine_test/controller/api_controller.dart';
import 'package:macchine_test/model/response_model.dart';

enum Type { Title, Content }

class ListDataWidget extends StatelessWidget {
  const ListDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ApiProvider());

    return GetBuilder<ApiProvider>(
      builder: (_) {
        if (controller.isLoadding) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return TitleElement(context);
              } else {
                var data = controller.responseData!.data.list[index - 1];

                return ContentElement(context, data);
              }
            },
            itemCount: (controller.responseData?.data.list.length ?? 0) + 1,
          );
        }
      },
    );
  }

  String getDocType(int? typeId) {
    List docType = [
      'Image',
      'Video',
      'Pdf',
      'Audio',
      'Document',
    ];
    if (typeId != null && typeId < 4) {
      return docType[typeId];
    } else {
      return 'Others';
    }
  }

  SizedBox ContentElement(BuildContext context, ListElement data) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ContentLabel(data.name),
                ),
              ),
              Expanded(
                flex: 1,
                child: ContentLabel(data.uid.toString()),
              ),
              Expanded(
                flex: 3,
                child: ContentLabel(getDocType(data.docType)),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: data.url != ''
                      ? SizedBox(
                          height: 50,
                          child: Image.network(
                            data.url,
                          ),
                        )
                      : Text("Not Found"),
                ),
              )
            ],
          ),
          Divider()
        ],
      ),
    );
  }

  Text ContentLabel(String label) {
    return Text(
      label,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  SizedBox TitleElement(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 4,
                child: TiltleLable("Name"),
              ),
              Expanded(
                flex: 1,
                child: TiltleLable("UID"),
              ),
              Expanded(
                flex: 3,
                child: TiltleLable("Doc Type"),
              ),
              Expanded(
                flex: 2,
                child: TiltleLable("Image"),
              )
            ],
          ),
          Divider()
        ],
      ),
    );
  }

  Text TiltleLable(String label) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
