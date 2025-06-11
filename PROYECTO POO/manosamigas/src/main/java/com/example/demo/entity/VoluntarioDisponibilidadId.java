package com.example.demo.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
@Data
@NoArgsConstructor
@AllArgsConstructor
public class VoluntarioDisponibilidadId implements Serializable {

    @Column(name = "id_voluntario")
    private Integer idVoluntario;

    @Column(name = "id_dia")
    private Integer idDia;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        VoluntarioDisponibilidadId that = (VoluntarioDisponibilidadId) o;
        return Objects.equals(idVoluntario, that.idVoluntario) && Objects.equals(idDia, that.idDia);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idVoluntario, idDia);
    }
}