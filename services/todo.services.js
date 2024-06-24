const ToDoModel = require('../model/todo.model');


class ToDoServices{

    static async createTodo(userId,title,description){
        const createTodo = new ToDoModel({userId,title,description});
        return await createTodo.save();
    }

    static async getUserData(userId){
        const getUserData = await ToDoModel.find({userId});
        return getUserData;
    }
}

module.exports = ToDoServices;