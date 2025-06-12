package com.manosamigas.app.dto;

import lombok.Data;
import java.util.List;

@Data
public class VoluntarioRequestDto {
    private String nombre;
    private String email;
    private String telefono;
    private List<Long> idsInteres;
    private List<DisponibilidadDto> disponibilidad;
}