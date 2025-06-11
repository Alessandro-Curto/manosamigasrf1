package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "Voluntarios")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Voluntario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_voluntario")
    private Integer idVoluntario;

    private String nombre;

    @Column(unique = true)
    private String email;

    private String telefono;

    @ManyToMany(fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(
            name = "VoluntarioIntereses",
            joinColumns = @JoinColumn(name = "id_voluntario"),
            inverseJoinColumns = @JoinColumn(name = "id_interes")
    )
    private List<Interes> intereses;

    @JsonManagedReference
    @OneToMany(mappedBy = "voluntario", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<VoluntarioDisponibilidad> disponibilidad;
}