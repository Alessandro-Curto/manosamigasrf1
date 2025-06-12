package pe.edu.uni.ManosAmigasApp.dto;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString

public class PendienteAsistenciaDto {
    private int idAsignacion;
    private String voluntario;
    private String evento;
}
