package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "DiasDisponibilidad")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DiasDisponibilidad {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_dia")
    private Integer idDia;

    private String nombre;
}
