package com.manosamigas.app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VoluntarioRequest {
    private String nombre;
    private String email;
    private String telefono;
    private List<Integer> idsInteres;
    private List<DisponibilidadDTO> disponibilidad;
}
