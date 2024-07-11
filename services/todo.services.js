const ToDoModel = require('../model/todo.model');


class ToDoServices{

    static async createTodo(userId,title,description){
        const createTodo = new ToDoModel({userId,title,description});
        return await createTodo.save();
    }

    static async getToDoData(Id){
        const getTodo = await ToDoModel.find(Id);
        // console.log("see the response of DataBase",getTodo);
        return getTodo;
    }

    static async deleteToDoItem(Id){
       
       console.log("I am reached the lat step i.e Todo service");
       try{
            await ToDoModel.findByIdAndDelete(Id);
            return true;
       }catch(error){
        console.log(`I am printing the error while deleting the element  ${error}`);
        return false;
       }

    }
    static async updateToDoItem(Id,item){
        console.log("I am todoservice updateToDoItem function from backend:- ",item);
        try{
            const response = await ToDoModel.findByIdAndUpdate(
                {_id:Id},
                {title : item['title'],description : item['description']}
            );
            console.log("Printing the previous result : - ",response);
            const update = await ToDoModel.find({"_id":Id});
            console.log("Printing the updated result : - ",update);

            return true;
        }catch(err){
            console.log("Error occur updateToDoItem from backend",err);
            return false;
        }
    }

    static async checkMarkDB(Id,_taskStatus){
            try{
                const response = await ToDoModel.findByIdAndUpdate(
                    {_id:Id},
                    {taskStatus:_taskStatus}
                );
                return true;

            }catch(error){
                console.log('error in checkMarkDB ',error);
            }
    }
}

module.exports = ToDoServices;