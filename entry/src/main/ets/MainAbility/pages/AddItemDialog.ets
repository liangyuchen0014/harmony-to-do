import { TodoData } from '../model/TodoData';

@CustomDialog
export struct AddItemDialog {
  @Link tempName: string
  @Link tempImage: Resource
  //  @Link tempStar: boolean
  @Link tempDesc: string
  @Link tempFinished: boolean
  @Link todoItems: TodoData[]
  controller: CustomDialogController
  cancel: () => void
  confirm: () => void
  dateDdl: Date = new Date()
  @State starInDialog: boolean = false

  build() {
    Column() {
      Text('创建任务').fontSize(20).margin({ top: 25, bottom: 25 })
      TextInput({ placeholder: '任务名称', text: this.tempName })
        .width('90%')
        .margin({ bottom: 25 })
        .onChange((value: string) => {
          this.tempName = value
        })
      TextArea({ placeholder: '任务描述', text: this.tempDesc })
        .height(120)
        .width('90%')
        .margin({ bottom: 25 })
        .onChange((value: string) => {
          this.tempDesc = value
        })
      Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center,
        justifyContent: FlexAlign.Center }) {
        Text('是否星标')
          .fontSize(20)
        Checkbox({ name: '是否星标' }).height(20)
          .onChange((value: boolean) => {
            this.starInDialog = value
            console.log(this.starInDialog.toString() + ' ' + value.toString())
          })
      }.height(28)
      .margin({ bottom: 10 })


      Button("设置截止日期")
        .margin({ bottom: 15 })
        .onClick(() => {
          DatePickerDialog.show({
            start: new Date("2020-1-1"),
            end: new Date("2030-1-1"),
            selected: new Date("2022-9-12"),
            lunar: false,
            onAccept: (value: DatePickerResult) => {
              this.dateDdl.setFullYear(value.year, value.month + 1, value.day)
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
              this.dateDdl.setHours(value.hour, value.minute)
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
      //      Text('按创建来创建新任务').fontSize(16).margin({ bottom: 20 })
      Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center,
        justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            this.controller.close()
            this.cancel()
          })
          .backgroundColor(0xffffff)
          .fontColor(Color.Black)
        Button('创建')
          .onClick(() => {
            //            this.inputValue = this.textValue
            if (this.tempName == "" || this.tempDesc == "") {
              AlertDialog.show(
                {
                  //                  title: '',
                  message: '任务名称、任务描述不能为空',
                  confirm: {
                    value: '确认',
                    action: () => {
                      console.info('Button-clicking callback')
                    }
                  },
                  cancel: () => {
                    console.info('Closed callbacks')
                  }
                }
              )
            }
            else {
              console.log(this.starInDialog.toString())
              this.todoItems.push(new TodoData(this.tempName, this.tempImage, this.dateDdl, this.starInDialog, this.tempDesc, this.tempFinished))
              this.controller.close()
              this.confirm()
            }
          })
          .backgroundColor(0xffffff)
          .fontColor(Color.Red)
      }
    }
  }
}
