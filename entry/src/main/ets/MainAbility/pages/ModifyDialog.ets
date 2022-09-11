import { TodoData } from '../model/TodoData';
/**
 * 用来修改任务的对话框
 */
@CustomDialog
export struct ModifyDialog {
  @Link dialogTodoItem: TodoData
  //  @Link todoArray: Array<TodoData>
  controller: CustomDialogController
  cancel: () => void
  confirm: () => void

  build() {
    Column() {
      Text('编辑任务').fontSize(20).margin({ top: 20, bottom: 10 }).fontWeight(FontWeight.Bold)
      Column() {
        Text('任务名称').textAlign(TextAlign.Start).height('5%').align(Alignment.Start).fontSize(16)
      }.alignItems(HorizontalAlign.Start).width('85%')

      TextArea({ text: this.dialogTodoItem.name }).height(60).width('90%').margin({ bottom: 10 })
        .onChange((value: string) => {
          this.dialogTodoItem.name = value
        })
      Column() {
        Text('任务描述').textAlign(TextAlign.Start).height('5%').align(Alignment.Start).fontSize(16)
      }.alignItems(HorizontalAlign.Start).width('85%')

      TextArea({ text: this.dialogTodoItem.description }).height(60).width('90%').margin({ bottom: 10 })
        .onChange((value: string) => {
          this.dialogTodoItem.description = value
        })

      Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center,
        justifyContent: FlexAlign.Center })
      //      Row()
      {
        Text('是否星标')
          .fontSize(20)
        Checkbox({ name: '是否星标' })
          .height(20)
          .select(this.dialogTodoItem.star)
          .onChange((value: boolean) => {
            this.dialogTodoItem.star = value
            console.log(this.dialogTodoItem.star.toString() + ' ' + value.toString())
          })
      }.height(28)
      .margin({ bottom: 10 })

      Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center,
        justifyContent: FlexAlign.Center }) {
        Text('是否完成')
          .fontSize(20)
        Checkbox({ name: '是否完成' })
          .height(20)
          .select(this.dialogTodoItem.finished)
          .onChange((value: boolean) => {
            this.dialogTodoItem.finished = value
            console.log(this.dialogTodoItem.finished.toString() + ' ' + value.toString())
          })
      }.height(28)
      .margin({ bottom: 10 })

      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button("设置截止日期")
          .margin({ bottom: 15 })
          .onClick(() => {
            DatePickerDialog.show({
              start: new Date("2020-1-1"),
              end: new Date("2030-1-1"),
              selected: new Date("2022-9-12"),
              lunar: false,
              onAccept: (value: DatePickerResult) => {
                this.dialogTodoItem.ddl.setFullYear(value.year, value.month + 1, value.day)
                console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
              },
              onCancel: () => {
                console.info("DatePickerDialog:onCancel()")
              },
              onChange: (value: DatePickerResult) => {
                console.info("DatePickerDialog:onChange()" + JSON.stringify(value))
              }
            })
          })
        Button("设置截止时分")
          .margin({ bottom: 15 })
          .onClick(() => {
            TimePickerDialog.show({
              useMilitaryTime: true,
              onAccept: (value: TimePickerResult) => {
                this.dialogTodoItem.ddl.setHours(value.hour, value.minute)
                console.info("TimePickerDialog:onAccept()" + JSON.stringify(value))

              },
              onCancel: () => {
                console.info("TimePickerDialog:onCancel()")
              },
              onChange: (value: TimePickerResult) => {
                console.info("TimePickerDialog:onChange()" + JSON.stringify(value))
              }
            })
          })
      }

      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            this.controller.close()
            this.cancel()
          })
          .backgroundColor(0xffffff)
          .fontColor(Color.Black)
        Button('确认')
          .onClick(() => {
            //            this.inputValue = this.textValue
            this.controller.close()
            this.confirm()
          })
          .backgroundColor(0xffffff)
          .fontColor(Color.Red)
      }
    }
  }
}
