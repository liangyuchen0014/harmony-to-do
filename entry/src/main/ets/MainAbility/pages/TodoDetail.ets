import router from '@ohos.router';
import { TodoData } from '../model/TodoData'
import { initializeOnStartup ,finishItem} from '../model/TodoDataModels'

@Entry
@Component
struct Index {
  //  @State message: string = 'Hello World'
  @State todoItem: TodoData = router.getParams()['data']['todoDataa']
  @State thisDate:Date = router.getParams()['data']['todoDataa']['ddl']
  @State todoItems: TodoData[] = router.getParams()['data']['todoItems']
  @State thisID:string = router.getParams()['data']['todoDataa']['id']
  onCreate() {
    console.log(this.todoItem.name)
  }

  build() {
    Column() {
      Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Start }) {
        Image($r('app.media.back'))
          .width(22)
        Text('任务详情')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 20, top: 5 })
          .fontColor(Color.Black)
      }
      .height('10%')
      .backgroundColor('#FFf1f3f5')
      .padding({ left: 20, top: 13, bottom: 15 })
      .onClick(() => {
        router.back()
      })

      Column() {
        Text(this.todoItem.name)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .lineHeight(40)
          .textAlign(TextAlign.Start)
          .align(Alignment.Start)
          .width('85%')
          .margin({bottom:20})
//        Column() {
//          Text('任务详情').textAlign(TextAlign.Start).align(Alignment.Start).fontSize(20)
//        }.alignItems(HorizontalAlign.Start).width('85%').margin({bottom:10})
        Text(this.todoItem.description )
          .margin({bottom:20})
          .fontSize(22)
          .width('85%')
//        Column() {
//          Text('截止时间').textAlign(TextAlign.Start).align(Alignment.Start).fontSize(20)
//        }.alignItems(HorizontalAlign.Start).width('85%').margin({bottom:10})
//        Text(this.todoItem.name ).fontSize(22)
        Text('截止时间:'+this.todoItem.ddl.toString()).fontSize(22).lineHeight(40)
//        DatePicker({
//          start: new Date('1970-1-1'),
//          end: new Date('2100-1-1'),
//
//        })
//          .onChange((date: DatePickerResult) => {
////            this.todoItem.ddl.setFullYear(date['year'])
////            this.todoItem.ddl.setMonth(date['month'])
////            this.todoItem.ddl.setDate(date['day'])
//            this.thisDate.setFullYear(date['year'])
//            this.thisDate.setMonth(date['month'])
//            this.thisDate.setDate(date['day'])
//          })
//        TimePicker()
//        .onChange((date: TimePickerResult) => {
//          this.todoItem.ddl.setHours(date['hour'])
//          this.todoItem.ddl.setMinutes(date['minute'])
//
//        })
        //        Text(this.todoItem.ddl.getMonth().toString())
        //        [qjs_utils.cpp(JsStdDumpErrorAce)-(0)] [Engine Log] [DUMP] TypeError: not a function
        //        +'月'+this.todoItem.ddl.getDate().toString()+'日周' +this.todoItem.ddl.getDay().toString()+' '+this.todoItem.ddl.getHours().toString()+':' +this.todoItem.ddl.getMinutes().toString())
        //        Text('是否完成').fontSize(22).lineHeight(40)
        if (this.todoItem.finished)
        Text('已完成').fontSize(30).lineHeight(40).onClick(()=>{
          this.todoItem.finished=!this.todoItem.finished;
        })
        else
        Text('未完成').fontSize(30).lineHeight(40).onClick(()=>{
          this.todoItem.finished=!this.todoItem.finished;
        })
        if (this.todoItem.star)
        Text('已星标').fontSize(30).lineHeight(40).onClick(()=>{
          this.todoItem.star=!this.todoItem.star;
        })
        else
        Text('未星标').fontSize(30).lineHeight(40).onClick(()=>{
          this.todoItem.star=!this.todoItem.star;
        })
//        Text(' ').fontSize(30).lineHeight(40)
//        Text(this.todoItem.description).fontSize(18)
//        TextInput({ placeholder: this.todoItem.description })
//          .placeholderColor(Color.Grey)
//          .placeholderFont({ size: 18 })
//          .onChange((value: string) => {
//            this.todoItem.description = value
//          })
//        Image(this.todoItem.image).objectFit(ImageFit.Auto)
      }
      .height('90%')
      .margin({ top: 20 })
//      .backgroundColor(Color.White)
//      .opacity(0.9)
//      .borderRadius(5)

    }
    //    .backgroundImage($r('app.media.bg4'))
    //    .backgroundImageSize(ImageSize.Auto)

  }
}