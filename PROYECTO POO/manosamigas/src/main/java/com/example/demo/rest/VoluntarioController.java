package com.example.demo.rest;

import com.example.demo.dto.VoluntarioRequest;
import com.example.demo.entity.Voluntario;
import com.example.demo.service.VoluntarioService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/voluntarios")
public class VoluntarioController {

    private final VoluntarioService service;

    public VoluntarioController(VoluntarioService service) {
        this.service = service;
    }

    @PostMapping
    public ResponseEntity<Voluntario> registrar(@RequestBody VoluntarioRequest request) {
        Voluntario creado = service.registrarVoluntario(request);
        return ResponseEntity.ok(creado);
    }
}