# TIMAG 2025 - PROYECTO FINAL - PROCESAMIENTO DE IMAGENES DE NANOLIVE

Este repositorio contiene el código y la documentación del proyecto dedicado a la estimación de la Función de Dispersión Puntual (PSF) y la deconvolución de stacks de imágenes adquiridos con el sistema de microscopía Nanolive 3D Cell Explorer. El objetivo es mejorar la resolución axial y la calidad de las reconstrucciones tridimensionales de células vivas sin necesidad de tinciones.


## 2. Enlaces principales

[Repositorio del proyecto](https://gitlab.fing.edu.uy/timag/2025/proyectos/2025-proyecto-grupo-15)
  
[Página web del proyecto](https://2025-proyecto-grupo-15-7ddae5.pages.fing.edu.uy/)

## 3. Directorios clave
- `data/`  
  - `stack_imagenes.zip` (imágenes de entrada)  
  - `resultados_deconvoluciones.zip` (salidas de ejemplo)  
- `docs/`  
  - `index.md`, `methods.md`, `conclusions.md`, `anexo.md`, `datasets.md`  
- `src/`  
  - `nanolive_PSF.ipynb`  
  - `macro_deconvoluciones.ijm`  
- Archivos raíz: `.gitlab-ci.yml`, `mkdocs.yml`, `README.md`

## 4. Instalación
- Requisitos mínimos:
  - Python 3.7+  
  - Fiji (https://fiji.sc/)  
  - Plugin DeconvolutionLab2 (https://bigwww.epfl.ch/deconvolution/)  
- Dependencias Python (versión mínima):
  ```bash
  pip install numpy pandas matplotlib scipy scikit-image tifffile opencv-python imageio tqdm

## 5. Uso

1. Descomprimir `stack_imagenes.zip` y `resultados_deconvoluciones.zip` en `data/`.  
2. Abrir y ejecutar `src/nanolive_PSF.ipynb` en Jupyter Notebook o Google Colab.  
3. Para la deconvolución en FIJI:
   - Iniciar Fiji con el plugin **DeconvolutionLab2** instalado.  
   - Cargar y ejecutar `macro_deconvoluciones.ijm`.

## 6. Estructura del proyecto

```text
2025-PROYECTO-GRUPO-15/
├─ data/
│  ├─ stack_imagenes.zip
│  └─ resultados_deconvoluciones.zip
├─ docs/
│  ├─ index.md
│  ├─ methods.md
│  ├─ conclusions.md
│  └─ anexo.md
├─ src/
│  ├─ nanolive_PSF.ipynb
│  └─ macro_deconvoluciones.ijm
├─ .gitlab-ci.yml
├─ mkdocs.yml
└─ README.md
```

## Autor y contacto

**Juan Manuel Ruiz-Esquide**  
Email: [ju4nmaruiz@gmail.com](mailto:ju4nmaruiz@gmail.com)
