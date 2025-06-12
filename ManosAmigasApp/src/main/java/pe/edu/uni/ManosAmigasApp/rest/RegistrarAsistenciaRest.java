package pe.edu.uni.ManosAmigasApp.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.edu.uni.ManosAmigasApp.dto.RegistrarAsistenciaDto;
import pe.edu.uni.ManosAmigasApp.service.RegistrarAsistenciaService;

@RestController
@RequestMapping("/api/asistencias")
public class RegistrarAsistenciaRest {

    @Autowired
    private RegistrarAsistenciaService asistenciaService;

    @PostMapping("/registrar")
    public ResponseEntity<?> registrarAsistencia(@RequestBody RegistrarAsistenciaDto bean) {
        try {
            RegistrarAsistenciaDto result = asistenciaService.registrarAsistencia(bean);
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("/pendientes/{idEvento}")
    public ResponseEntity<?> listarPendientes(@PathVariable int idEvento) {
        try {
            var resultado = asistenciaService.listarPendientesDeAsistencia(idEvento);
            return ResponseEntity.ok(resultado);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
}

