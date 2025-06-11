package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "VoluntarioDisponibilidad")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class VoluntarioDisponibilidad {

    @EmbeddedId
    private VoluntarioDisponibilidadId id;

    @JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("idVoluntario") // Mapea el campo idVoluntario de la clave compuesta
    @JoinColumn(name = "id_voluntario")
    private Voluntario voluntario;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("idDia") // Mapea el campo idDia de la clave compuesta
    @JoinColumn(name = "id_dia")
    private DiasDisponibilidad dia;

    private String turno;

    // Constructor para facilitar la creación en el servicio
    public VoluntarioDisponibilidad(Voluntario voluntario, DiasDisponibilidad dia, String turno) {
        this.id = new VoluntarioDisponibilidadId(voluntario.getIdVoluntario(), dia.getIdDia());
        this.voluntario = voluntario;
        this.dia = dia;
        this.turno = turno;
    }
}