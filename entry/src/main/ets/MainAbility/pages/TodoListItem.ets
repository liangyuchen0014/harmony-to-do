import { ModifyDialog } from './ModifyDialog';
import router from '@ohos.router';
import { TodoData } from '../model/TodoData';

@Component
export struct TodoListItem {
  @State todoItem: TodoData = {
    id: '0',
    name: ' ',
    image: null,
    ddl: new Date(),
    star: true,
    description: ' ',
    finished: false
  }
  @Link todoArray: Array<TodoData>
//
//  aboutToAppear(): void {
//    console.log(this.todoItem.star.toString())
//
//  }
  //  touchMove(e){  // swipe处理事件
  //    if(e.direction == "left"){  // 右滑退出
  //      console.log('swipe left')
  //      this.todoArray.splice(Number(this.todoItem.id),1)
  //    }
  //  }
  build() {
    GridContainer({ columns: 6, gutter: 0, margin: 12 }) {
      Row() {
        if (this.todoItem.finished == true) {
          Image($r('app.media.CheckCircleRegular')).objectFit(ImageFit.ScaleDown).width(27).height(27).useSizeType({
            xs: { span: 1, offset: 0 },
            sm: { span: 1, offset: 0 },
            md: { span: 1, offset: 0 },
            lg: { span: 1, offset: 0 },
          })
            .onClick(() => {
              //              this.todoArray=finishItem(this.todoArray,this.todoItem.id,this.todoItem.finished)
              this.todoItem.finished = !this.todoItem.finished

            })
        }
        else {
          Image($r('app.media.CircleRegular')).objectFit(ImageFit.ScaleDown).width(27).height(27).useSizeType({
            xs: { span: 1, offset: 0 },
            sm: { span: 1, offset: 0 },
            md: { span: 1, offset: 0 },
            lg: { span: 1, offset: 0 },
          }).onClick(() => {
            //              this.todoItem.finished = !this.todoItem.finished
            this.todoItem.finished = !this.todoItem.finished
          })
        }
        Column() {
          Text(this.todoItem.name)
            .fontSize(14)
            .textAlign(TextAlign.Center)
            .maxLines(3)
            .lineHeight(20)
            .fontWeight(FontWeight.Bold)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .onClick(() => {
              console.log(this.todoItem.name)
              router.push({
                url: 'pages/TodoDetail',
                params: {
                  data: {
                    todoDataa: this.todoItem,
                    todoItems: this.todoArray
                  },
                }
              })
            })
          Text(
            this.todoItem.ddl.getFullYear().toString()+'年'+
            this.todoItem.ddl.getMonth().toString() + '月' + this.todoItem.ddl.getDate().toString() + '日周'
          + ((this.todoItem.ddl.getDay()+4)%7+1).toString() + ' ' + this.todoItem.ddl.getHours().toString() + ':'
          + this.todoItem.ddl.getMinutes().toString())
            .fontSize(14)
            .onClick(() => {
              console.log(this.todoItem.name)
              router.push({
                url: 'pages/TodoDetail',
                params: {
                  data: { todoDataa: (this.todoItem) },
                }
              })
            })
        }.useSizeType({
          xs: { span: 4, offset: 1 },
          sm: { span: 4, offset: 1 },
          md: { span: 4, offset: 1 },
          lg: { span: 4, offset: 1 },
        })

        if (this.todoItem.star == true) {
          Image($r('app.media.starFilled'))
            .objectFit(ImageFit.ScaleDown)
            .width(27)
            .height(27)
            .useSizeType({
              xs: { span: 1, offset: 5 },
              sm: { span: 1, offset: 5 },
              md: { span: 1, offset: 5 },
              lg: { span: 1, offset: 5 },
            })
            .onClick(() => {
              //              this.todoItem.star = !this.todoItem.star
              //              console.log(this.todoItem.star.toString())
              this.todoItem.star = !this.todoItem.star
            })
        }
        else {
          Image($r('app.media.star')).objectFit(ImageFit.ScaleDown).width(27).height(27).useSizeType({
            xs: { span: 1, offset: 5 },
            sm: { span: 1, offset: 5 },
            md: { span: 1, offset: 5 },
            lg: { span: 1, offset: 5 },
          })
            .onClick(() => {
              //              this.todoItem.star = !this.todoItem.star
              //              console.log(this.todoItem.star.toString())
              this.todoItem.star = !this.todoItem.star
            })
        }
      }
    }
    .margin({ top: 8 })
    .backgroundColor(Color.White)
    .opacity(0.65)
    .borderRadius(8)
    .padding(5)
    .gesture(
      SwipeGesture({fingers: 1, direction:SwipeDirection.Horizontal})
        .onAction((event: GestureEvent) => {
          if(event.angle>0)
            AlertDialog.show({
              title: '你确定吗？',
              message: '这将永久删除:"'+this.todoItem.name+'".',
              primaryButton: {
                value: '取消',
                action: () => {
                  console.info('Callback when the first button is clicked')
                }
              },
              secondaryButton: {
                value: '删除',
                fontColor:Color.Red,
                action: () => {
                  console.info('Callback when the second button is clicked')
                  this.todoArray.splice(Number(this.todoItem.id),1)
                  console.info('swiped')
                }
              },
              cancel: () => {
                console.info('Closed callbacks')
              }
            })
          else
            this.dialogOfModifyController.open()
        })
    )
  }

  dialogOfModifyController: CustomDialogController = new CustomDialogController({
    builder: ModifyDialog(
      { cancel: this.onCancel,
        confirm: this.onAccept,
        dialogTodoItem: $todoItem,
        //        dialogTodoArray: $todoArray
      }),
    cancel: this.existApp,
    autoCancel: true
  })

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
//        Button('修改')
//          .margin({ right: 10 })
//          .useSizeType({
//            xs: { span: 2, offset: 6 },
//            sm: { span: 2, offset: 6 },
//            md: { span: 2, offset: 6 },
//            lg: { span: 2, offset: 6 },
//          })
//          .onClick(() => {
//            this.dialogOfModifyController.open()
//          })