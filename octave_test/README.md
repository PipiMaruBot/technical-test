### Archivos
- **`Data_package_Input.json`**: parámetros de entrada del problema (constantes y elementos orbitales).
- **`Data_package_Output.json`**: algunas muestras de salida del algoritmo (latitud y longitud) para validar la implementación.

### Significado de los datos
- A partir de las entradas de `Data_package_Input.json`, el algoritmo calcula, para distintos instantes de tiempo:
  - **`lat_deg`**: latitud del subsatélite, en grados.
  - **`lon_deg`**: longitud del subsatélite, en grados.
- En `Data_package_Output.json` se incluyen solo unas pocas muestras para facilitar la comparación.

### Cómo usar
- Leer `Data_package_Input.json` y reconstruir los inputs.
- Implementar el algoritmo.
- Calcular `lat_deg` y `lon_deg` para los mismos instantes de tiempo que aparecen en `Data_package_Output.json`.
- Comparar los resultados obtenidos con los del JSON de salida.