package com.manosamigas.app.repository;

import com.manosamigas.app.entity.Voluntario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VoluntarioRepository extends JpaRepository<Voluntario, Integer> {
    boolean existsByEmail(String email);
}
