package com.example.demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserResource {

    @Value("${app.version}")
    private String version;

    @Value("${db.password}")
    private String password;

    @GetMapping("hello/{name}")
    public String hello(@PathVariable("name") String name) {
        System.out.println("Service invoked by :" + name);
        System.out.println("Password : " + password);

        return "Hey " + name + "!" + "  version - " + version;
    }

}
