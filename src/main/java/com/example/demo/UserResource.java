package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserResource {

    @GetMapping("hello/{name}")
    public String hello(@PathVariable("name") String name) {
        System.out.println("Service invoked by :" + name);

        return "Hey " + name + "!";
    }

}
