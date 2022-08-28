import { TodoData } from './TodoData';


export function initializeOnStartup():Array<TodoData> {
  let TodoDataArray:Array<TodoData> = [];
  TodoComposition.forEach(item=>{
    TodoDataArray.push(new TodoData(item.name, item.image,item.ddl,item.star,item.description, item.finished))
  })
  return TodoDataArray
};

export function addItem(TodoDataArray : Array<TodoData>, name: string, image: Resource,ddl:Date,
                        star:boolean,
                        description:string,
                        finished:boolean):Array<TodoData> {
  TodoDataArray.push(new TodoData(name,image,ddl,star,description,finished))
  return TodoDataArray
}
export function finishItem(TodoDataArray : Array<TodoData>,id:string,
                        finished:boolean):Array<TodoData> {
  TodoDataArray.find(item=>item.id===id).finished = !finished
  return TodoDataArray
}
let TodoComposition: any[]=[
  {
    name: '点击以查看任务',
    ddl:new Date(2022, 8, 1, 19, 30, 0, 0),
    star:true,
    description:'点击以查看任务详情，此处将会显示任务简介',
    image:$r('app.media.icon'),
    finished:true
  },
  {
    name: '点击下方加号按钮可以新建任务',
    ddl:new Date(2022, 8, 31, 15, 30, 0, 0),
    star:false,
    description:'点击加号可以新建任务并编辑任务详情',
    image:$r('app.media.ava'),
    finished:false
  },
  {
    name: '你可以设置任务的完成期限、添加简介和图片，还可以添加星标',
    ddl:new Date(2022, 8, 31, 15, 30, 0, 0),
    star:true,
    description:'点击加号可以新建任务并编辑任务详情',
    image:$r('app.media.ava'),
    finished:false
  },
]