const db = require('../config/db')
const mongoose = require('mongoose');
const UserModel = require('../model/user.model');
const {Schema} = mongoose;

const todoSchema = new Schema({
    userId:{
        type : Schema.Types.ObjectId,
        ref : UserModel.modelName
    },
    title:{
        type : String,
        required : true
    },
    description:{
        type : String
    }

});

const ToDoModel = db.model('todoList',todoSchema);

module.exports = ToDoModel