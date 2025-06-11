package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Intereses")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Interes {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_interes")
    private Integer idInteres;

    private String nombre;
}
