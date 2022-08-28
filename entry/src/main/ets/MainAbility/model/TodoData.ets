let NextId = 0;

export class TodoData {
  id: string;
  name: string;
  image:Resource;
  ddl:Date;
  star:boolean;
  description:string;
  finished:boolean;
  constructor( name: string, image: Resource,ddl:Date,
  star:boolean,
  description:string,
  finished:boolean)
  {    this.name = name;
    this.image = image;
    this.ddl = ddl;
    this.star = star;
    this.description = description;
    this.finished = finished;
    this.id=`${NextId++}`;
  }
}

