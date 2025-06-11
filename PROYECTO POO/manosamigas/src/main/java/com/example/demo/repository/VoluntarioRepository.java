package com.example.demo.repository;

import com.example.demo.entity.Voluntario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VoluntarioRepository extends JpaRepository<Voluntario, Integer> {
    boolean existsByEmail(String email);
}
