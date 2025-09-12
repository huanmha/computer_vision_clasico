// === CONFIGURACIÓN DE RUTAS ===

base_path = "C:/Users/ju4nm/Desktop/maestria_CDAA/timag/nanolive/pre_deconvolucion/";

subvol_folder = base_path + "subvolumenes/";
psf_folder    = base_path + "psfs/";
resultados_base = base_path + "resultados/";

// Crear carpeta base de resultados
File.makeDirectory(resultados_base);

// === OBTENER LISTA DE ARCHIVOS ===

subvol_files = getFileList(subvol_folder);
psf_files = getFileList(psf_folder);

// === MÉTODOS A PROBAR ===

metodos = newArray("RL", "TRIF", "RLTV");
logText = ""; // Acumulador del log

for (m = 0; m < metodos.length; m++) {

    metodo = metodos[m];
    metodo_output = resultados_base + metodo + "/";
    File.makeDirectory(metodo_output); // Crear subcarpeta para el método

    // Parámetros específicos para cada método
    if (metodo == "RL") {
        params = newArray(5, 10, 20); // iteraciones
    } else if (metodo == "TRIF") {
        params = newArray(0.001, 0.01, 0.1); // lambda
    } else if (metodo == "RLTV") {
        params = newArray("5:0.005", "10:0.005"); // iteraciones:TV_weight
    }

    // Recorremos subvolumenes
    for (s = 0; s < subvol_files.length; s++) {
        subvol = subvol_files[s];
        if (!endsWith(subvol, ".tif")) continue;
        image_path = subvol_folder + subvol;

        for (p = 0; p < psf_files.length; p++) {
            psf = psf_files[p];
            if (!endsWith(psf, ".tif")) continue;
            psf_path = psf_folder + psf;

            for (k = 0; k < params.length; k++) {

                // Construir argumentos según método
                if (metodo == "RL") {
                    iter = params[k];
                    algorithm = " -algorithm RL " + iter;
                    suffix = "_RL_iter" + iter;
                    param_str = "iter=" + iter;
                }
                else if (metodo == "TRIF") {
                    lambda = params[k];
                    algorithm = " -algorithm TRIF " + lambda;
                    suffix = "_TRIF_lambda" + lambda;
                    param_str = "lambda=" + lambda;
                }
                else if (metodo == "RLTV") {
                    parts = split(params[k], ":");
                    iter = parts[0];
                    tv = parts[1];
                    algorithm = " -algorithm RLTV " + iter + " " + tv;
                    suffix = "_RLTV_iter" + iter + "_tv" + tv;
                    param_str = "iter=" + iter + ";tv=" + tv;
                }

                // Mensaje de control
                print("📂 " + metodo + ": " + subvol + " × " + psf + " → " + suffix);

                // Ejecutar deconvolución
                run("DeconvolutionLab2 Run",
                    " -image file " + image_path +
                    " -psf file " + psf_path +
                    algorithm +
                    " -monitor no");

                wait(10000); // suficiente para stacks pequeños

                // NO convertir a 16-bit
                // Guardar directamente en formato original (float32)
                subname = replace(subvol, ".tif", "");
                psfname = replace(psf, ".tif", "");
                output_name = subname + "_" + psfname + suffix + ".tif";

                saveAs("Tiff", metodo_output + output_name);
                close();

                // Agregar al log
                logText += subname + "," + psfname + "," + metodo + "," + param_str + "," + output_name + "\n";
            }
        }
    }
}

// === GUARDAR LOG AL FINAL ===

log_path = resultados_base + "log_deconvoluciones.csv";
File.saveString("Subvolumen,PSF,Metodo,Parametro,Archivo\n" + logText, log_path);
print("✅ Log guardado en: " + log_path);
