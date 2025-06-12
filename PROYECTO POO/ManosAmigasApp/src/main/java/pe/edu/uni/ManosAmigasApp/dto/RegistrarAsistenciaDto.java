package pe.edu.uni.ManosAmigasApp.dto;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString

public class RegistrarAsistenciaDto {
    private int idUsuario;
    private int idAsignacion;
    private Boolean asistio;
    private int horasTrabajadas;
}

