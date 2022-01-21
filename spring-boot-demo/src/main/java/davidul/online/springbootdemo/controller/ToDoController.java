package davidul.online.springbootdemo.controller;

import davidul.online.springbootdemo.TodoRepository;
import davidul.online.springbootdemo.model.Todo;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Optional;

@RestController
public class ToDoController {

    private final TodoRepository todoRepository;

    public ToDoController(TodoRepository todoRepository) {
        this.todoRepository = todoRepository;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Todo> todoById(@PathVariable("id") String id){
        Optional<Todo> byId = this.todoRepository.findById(Long.valueOf(id));
        return byId.map(ResponseEntity::ok).orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @GetMapping("/hello")
    public String sample(){
        return "Hello";
    }

    @PostMapping
    public void addTodo(@RequestBody Todo todo){
        this.todoRepository.save(todo);
    }
}
