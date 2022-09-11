import { TodoListItem } from './TodoListItem';
import router from '@ohos.router';
import { TodoData } from '../model/TodoData'
import { initializeOnStartup, finishItem } from '../model/TodoDataModels'
import { ModifyDialog } from './ModifyDialog'
import { AddItemDialog } from './AddItemDialog'

let objectArraySort = function (keyName) {
  return function (objectN, objectM) {
    var valueN = objectN[keyName]
    var valueM = objectM[keyName]
    if (valueN < valueM) {
      console.log(valueN + '**' + valueM)
      return 1
    }

    else if (valueN > valueM) {
      console.log(valueM + '**' + valueN)
      return -1
    }
    else return 0
  }
}

@Entry
@Component
struct TodoList {
  @State todoItems: TodoData[] = initializeOnStartup();
  @State tempName: string = '任务名称'
  @State tempImage: Resource = undefined
  @State tempDdl: Date = new Date()
  @State tempStar: boolean = false
  @State tempDesc: string = '任务描述'
  @State tempFinished: boolean = false
  dialogController: CustomDialogController = new CustomDialogController({
    builder: AddItemDialog({
      cancel: this.onCancel,
      confirm: this.onAccept,
      tempName: $tempName,
      tempImage: $tempImage,
      tempDesc: $tempDesc,
      tempFinished: $tempFinished,
      todoItems: $todoItems
    }),
    cancel: this.existApp,
    autoCancel: true
  })

  build() {
    Column() {
      Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
        Text('我的任务')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 20, })
          .fontColor(Color.White)
//        Button('ddl').onClick(()=>{
//          this.todoItems.sort((a: TodoData, b: TodoData) => {
//            return a.ddl.getTime() - b.ddl.getTime()
//          })
//          this.todoItems.forEach(element => {
//            console.log(JSON.stringify(element))
//          });
//        })
//        Button('name').onClick(()=>{
//          this.todoItems.sort((a: TodoData, b: TodoData) => {
//            return a.name.localeCompare(b.name)
//          })
//          this.todoItems.forEach(element => {
//            console.log(JSON.stringify(element))
//          });
//        })
        Select(
          [{ value: '按截止日期排序' },
           { value: '按创建时间排序' },
           { value: '按名称排序' },
           { value: '星标优先'},
           { value: '未完成优先'}

          ])

          .margin({ right: 20 })
          .value('排序方式')
          .fontColor(Color.White)
          .selectedOptionFontColor(Color.Black)
          .optionFontColor(Color.Black)
          .selectedOptionFont({ weight: FontWeight.Bold })
            //          .optionFont({size: 30, weight: 400, family: 'serif', style: FontStyle.Normal })
          .onSelect((index: number) => {
            console.info("Select:" + index)
            switch (index) {
              case 0:
                this.todoItems.sort((a: TodoData, b: TodoData) => {
                  return a.ddl.getTime() - b.ddl.getTime()
                })
                this.todoItems.forEach(element => {
                  console.log(JSON.stringify(element))
                });
                break;
              case 1:
                this.todoItems.sort((a: TodoData, b: TodoData) => {
                  return Number(a.id) - Number(b.id)
                })
                this.todoItems.forEach(element => {
                  console.log(JSON.stringify(element))
                });
                break;
              case 2:
                this.todoItems.sort((a: TodoData, b: TodoData) => {
                  return a.name.localeCompare(b.name)
                })
                this.todoItems.forEach(element => {
                  console.log(JSON.stringify(element))
                });
                break;
              case 3:
                this.todoItems.sort((a: TodoData, b: TodoData) => {
                  return Number(b.star) - Number(a.star)
                })
                this.todoItems.forEach(element => {
                  console.log(JSON.stringify(element))
                });
                break;
              case 4:
                this.todoItems.sort((a: TodoData, b: TodoData) => {
                  return Number(a.finished) - Number(b.finished)
                })
                this.todoItems.forEach(element => {
                  console.log(JSON.stringify(element))
                });
                break;
            }
          })
        //        Button('排序方式').backgroundColor(Color.Orange).opacity(0.8)
        //          .margin({right:20})
        //          .onClick(()=>{
        //          this.todoItems.sort(objectArraySort('name'))
        //          this.todoItems.sort((a:TodoData,b:TodoData)=>{
        //            return a.ddl.getTime() - b.ddl.getTime()
        //          })
        //          this.todoItems.forEach(element => {
        //            console.log(JSON.stringify(element))
        //          });
        //        })
      }
      .height('7%')

      List() {
        ForEach(this.todoItems, item => {
          ListItem() {
            TodoListItem({ todoItem: item, todoArray: $todoItems })
          }
        }, item => item.id.toString())
      }
      .height('93%')

      Button('+')
        .type(ButtonType.Circle)
        .position({ x: '80%', y: '88%' })
        .borderRadius(25)
        .fontSize(25)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.dialogController.open()
          //                  this.todoItems.push(new TodoData('新任务',null,new Date(),false,'请输入描述',false))
        })
    }.backgroundImage($r('app.media.bg3'))
    .backgroundImageSize(ImageSize.Auto)
  }

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  existApp() {
    console.info('Click the callback in the blank area')
  }
}