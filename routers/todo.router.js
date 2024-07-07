const router = require('express').Router();
const ToDoController = require('../controller/todo.controller')


router.post('/storeTodo',ToDoController.createTodo);

router.get('/getUserData',ToDoController.getUserData)

router.delete('/deleteItem/:Id',ToDoController.deleteItem);

router.put('/updateItem/:Id',ToDoController.updateItem);

module.exports = router;