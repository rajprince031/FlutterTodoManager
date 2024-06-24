const router = require('express').Router();
const ToDoController = require('../controller/todo.controller')


router.post('/storeTodo',ToDoController.createTodo);

router.get('/getUserData',ToDoController.getUserData)

module.exports = router;