const router = require('express').Router();
const ToDoController = require('../controller/todo.controller')


router.post('/storeTodo',ToDoController.createTodo);

module.exports = router;