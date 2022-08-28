import router from '@ohos.router';
import { TodoData } from '../model/TodoData'
import { initializeOnStartup ,finishItem} from '../model/TodoDataModels'

@Component
struct TodoListItem {
  @State todoItem: TodoData = {id:'0',name:' ',image:null,ddl:new Date(),star:true,description: ' ',finished:false}
//  @State Starred:boolean = this.todoItem.star
//  @State res:Resource =this.todoItem.star===true ? $r('app.media.starFilled') : $r('app.media.star')
 todoArray: Array<TodoData>
  build() {

//    Navigator({ target: 'pages/TodoDetail' }) {

    GridContainer({ columns: 6, gutter: 10, margin: 20 }) {
        Row() {
          if (this.todoItem.finished === true) {
            Image($r('app.media.CheckCircleRegular')).objectFit(ImageFit.ScaleDown).width(27).height(27).useSizeType({
              xs: { span: 1, offset: 0 },
              sm: { span: 1, offset: 0 },
              md: { span: 1, offset: 0 },
              lg: { span: 1, offset: 0 },
            })
            .onClick(()=>{
//              finishItem(this.todoArray,this.todoItem.id,this.todoItem.finished)
//              console.log(this.todoArray.toString())
//              router.push({
//                url:'pages/TodoCategoryList'
//              })
              this.todoItem.finished= !this.todoItem.finished
            })
          }
          else {
            Image($r('app.media.CircleRegular')).objectFit(ImageFit.ScaleDown).width(27).height(27).useSizeType({
              xs: { span: 1, offset: 0 },
              sm: { span: 1, offset: 0 },
              md: { span: 1, offset: 0 },
              lg: { span: 1, offset: 0 },
            }).onClick(()=>{
//              this.todoItem.finished = !this.todoItem.finished
//              console.log(this.todoItem.finished.toString())
//              router.push({
//                url:'pages/TodoCategoryList'
//              })
              this.todoItem.finished= !this.todoItem.finished
            })
          }
          Column() {
            Text(this.todoItem.name)
              .fontSize(14)
            .textAlign(TextAlign.Center)
            .maxLines(3)
            .lineHeight(20)
            .textOverflow({overflow:TextOverflow.Ellipsis})
              .onClick(()=>{
                console.log(this.todoItem.name)
                router.push({
                  url:'pages/TodoDetail',

                  params:{
                    data:{todoDataa:this.todoItem},
                  }
                })
              })
            Text(this.todoItem.ddl.getMonth().toString()+'月'+this.todoItem.ddl.getDate().toString()+'日周'
            +this.todoItem.ddl.getDay().toString()+' '+this.todoItem.ddl.getHours().toString()+':'
            +this.todoItem.ddl.getMinutes().toString())
              .fontSize(14)
              .onClick(()=>{
                console.log(this.todoItem.name)
                router.push({
                  url:'pages/TodoDetail',

                  params:{
                    data:{todoDataa:this.todoItem},
                  }
                })
              })
          }.useSizeType({
            xs: { span: 4, offset: 1 },
            sm: { span: 4, offset: 1 },
            md: { span: 4, offset: 1 },
            lg: { span: 4, offset: 1 },
          })

//          Image(this.res).objectFit(ImageFit.ScaleDown).width(27).height(27).useSizeType({
//            xs: { span: 1, offset: 5 },
//            sm: { span: 1, offset: 5 },
//            md: { span: 1, offset: 5 },
//            lg: { span: 1, offset: 5 },
//          })
//            .onClick(()=>{
//            this.todoItem.star= !this.todoItem.star
//          })
          if (this.todoItem.star === true) {
            Image($r('app.media.starFilled')).objectFit(ImageFit.ScaleDown).width(27).height(27).useSizeType({
              xs: { span: 1, offset: 5 },
              sm: { span: 1, offset: 5 },
              md: { span: 1, offset: 5 },
              lg: { span: 1, offset: 5 },
            })
//              .onClick(()=>{
////              this.todoItem.star = !this.todoItem.star
////              console.log(this.todoItem.star.toString())
//                this.todoItem.star= !this.todoItem.star
//              })
          }
          else {
            Image($r('app.media.star')).objectFit(ImageFit.ScaleDown).width(27).height(27).useSizeType({
              xs: { span: 1, offset: 5 },
              sm: { span: 1, offset: 5 },
              md: { span: 1, offset: 5 },
              lg: { span: 1, offset: 5 },
            })
//              .onClick(()=>{
////              this.todoItem.star = !this.todoItem.star
////              console.log(this.todoItem.star.toString())
//                this.todoItem.star= !this.todoItem.star
//
//              })
          }
        }

      }.margin({ top: 8 }).backgroundColor(Color.White).opacity(0.8).borderRadius(8).padding(5)

//}
//          .params({ TodoData: this.todoItem })
  }
}

@Entry
@Component
struct TodoList {
  @State todoItems: TodoData[] = initializeOnStartup();

  build() {
    Column() {
      Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
        Text('我的任务')
          .fontSize(25)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 20 ,top:20})
        .fontColor(Color.White)
      }
      .height('7%')
//      .backgroundColor('#FFf1f3f5')

      List() {
        ForEach(this.todoItems, item => {
          ListItem() {
            TodoListItem({ todoItem: item,todoArray:this.todoItems })
          }
        }, item => item.id.toString())

      }
      .height('93%')
      Button('+').type(ButtonType.Circle).position({x: 280, y: 700}).borderRadius(25).fontSize(25).fontWeight(FontWeight.Bold).onClick(()=>{
//        router.push({url:'pages/addTodoItem'})
        this.todoItems.push(new TodoData('新任务',null,new Date(),false,'请输入描述',false))
      })

    }.backgroundImage($r('app.media.bg4'))
    .backgroundImageSize(ImageSize.Contain)


  }
}