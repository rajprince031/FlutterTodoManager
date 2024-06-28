const ToDoModel = require('../model/todo.model');


class ToDoServices{

    static async createTodo(userId,title,description){
        const createTodo = new ToDoModel({userId,title,description});
        return await createTodo.save();
    }

    static async getToDoData(Id){
        const getTodo = await ToDoModel.find({Id});
        return getTodo;
    }
}

module.exports = ToDoServices;