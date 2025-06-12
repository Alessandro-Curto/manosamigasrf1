package com.manosamigas.app.service;

import com.manosamigas.app.dto.VoluntarioRequest;
import com.manosamigas.app.entity.DiasDisponibilidad;
import com.manosamigas.app.entity.Interes;
import com.manosamigas.app.entity.Voluntario;
import com.manosamigas.app.entity.VoluntarioDisponibilidad;
import com.manosamigas.app.repository.DiasDisponibilidadRepository;
import com.manosamigas.app.repository.InteresRepository;
import com.manosamigas.app.repository.VoluntarioRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class VoluntarioService {

    private final VoluntarioRepository voluntarioRepo;
    private final InteresRepository interesRepo;
    private final DiasDisponibilidadRepository diaRepo;

    public VoluntarioService(VoluntarioRepository voluntarioRepo, InteresRepository interesRepo, DiasDisponibilidadRepository diaRepo) {
        this.voluntarioRepo = voluntarioRepo;
        this.interesRepo = interesRepo;
        this.diaRepo = diaRepo;
    }
    @Transactional
    public Voluntario registrarVoluntario(VoluntarioRequest request) {
        if (voluntarioRepo.existsByEmail(request.getEmail())) {
            throw new IllegalArgumentException("El email ya está registrado.");
        }
        Voluntario voluntario = new Voluntario();
        voluntario.setNombre(request.getNombre());
        voluntario.setEmail(request.getEmail());
        voluntario.setTelefono(request.getTelefono());
        Voluntario voluntarioGuardado = voluntarioRepo.save(voluntario);
        List<Interes> intereses = interesRepo.findAllById(request.getIdsInteres());
        voluntarioGuardado.setIntereses(intereses);
        List<VoluntarioDisponibilidad> disponibilidad = request.getDisponibilidad().stream().map(d -> {
            DiasDisponibilidad dia = diaRepo.findById(d.getIdDia())
                    .orElseThrow(() -> new IllegalArgumentException("Día no válido: " + d.getIdDia()));
            return new VoluntarioDisponibilidad(voluntarioGuardado, dia, d.getTurno());
        }).collect(Collectors.toList());
        voluntarioGuardado.setDisponibilidad(disponibilidad);
        return voluntarioRepo.save(voluntarioGuardado);
    }
}