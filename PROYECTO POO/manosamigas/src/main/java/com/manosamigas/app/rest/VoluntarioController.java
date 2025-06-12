package com.manosamigas.app.rest;

import com.manosamigas.app.dto.VoluntarioRequestDto;
import com.manosamigas.app.entity.Voluntario;
import com.manosamigas.app.service.VoluntarioService;
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
    public ResponseEntity<Voluntario> registrar(@RequestBody VoluntarioRequestDto request) {
        Voluntario creado = service.registrarVoluntario(request);
        return ResponseEntity.ok(creado);
    }
}