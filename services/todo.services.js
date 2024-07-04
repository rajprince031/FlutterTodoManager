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
}

module.exports = ToDoServices;