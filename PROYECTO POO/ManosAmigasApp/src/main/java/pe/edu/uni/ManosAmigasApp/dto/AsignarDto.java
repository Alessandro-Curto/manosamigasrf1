package pe.edu.uni.ManosAmigasApp.dto;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder

public class AsignarDto {
    private int idUsuario;
    private int idVoluntario;
    private int idEvento;
}
