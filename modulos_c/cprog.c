#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "cJSON/cJSON.h" // Importamos 

void buscarLibroPorAutor(char *nombreArchivo, char *autor) {
  // Abre el archivo en modo lectura
  FILE *archivo = fopen(nombreArchivo, "r");
  if (archivo == NULL) {
    printf("Error al abrir el archivo\n");
    return;
  }
  // Leer el contenido del archivo JSON
  fseek(archivo, 0, SEEK_END); //Esta línea mueve el puntero del archivo al final del mismo. SEEK_END es una constante que representa el final del archivo.
  long fileSize = ftell(archivo); // Devuelve la posición actual del puntero del archivo. Como acabamos de mover el puntero al final del archivo, esta línea nos da el tamaño total del archivo en bytes.
  fseek(archivo, 0, SEEK_SET); // Esta línea mueve el puntero de nuevo al principio del archivo (SEEK_SET es una constante que representa el inicio del archivo) para que podamos empezar a leer desde el principio.
  char *jsonBuffer = (char *)malloc(fileSize + 1); // Aquí estamos reservando espacio en la memoria para almacenar el contenido del archivo JSON. Usamos fileSize + 1 para dejar espacio para un carácter nulo al final de la cadena.
  fread(jsonBuffer, 1, fileSize, archivo); // Esta línea lee el contenido del archivo y lo guarda en jsonBuffer. Estamos leyendo fileSize elementos de tamaño 1.
  fclose(archivo); // Esta línea cierra el archivo después de haber terminado de leerlo.
  jsonBuffer[fileSize] = '\0'; // Finalmente, agregamos un carácter nulo al final de la cadena para indicar el final de la cadena cuando la usemos más tarde.

  // Analizar el json
  cJSON *root = cJSON_Parse(jsonBuffer); // Analiza el JSON en un objeto cJSON
  free(jsonBuffer); // Libera la memoria del buffer
  if (root == NULL){
    printf("Error al analizar el JSON\n");
    return;
  }

  // Comprobar si es un array
  if (cJSON_IsArray(root)){
    int nroLibros = cJSON_GetArraySize(root);
    cJSON *libro;

    printf("Libros por %s:\n", autor); // EMPEZAR DOCUMENTACION

    for (int i = 0; i < nroLibros; i++) {
      libro = cJSON_GetArrayItem(root, i);
      cJSON *jsonAutor = cJSON_GetObjectItem(libro, "autor");

      if (jsonAutor != NULL && cJSON_IsString(jsonAutor)) {
        char *autorEnJson = jsonAutor -> valuestring; // Obtiene el valor de "autor" como cadena
        if (strcmp(autorEnJson, autor) == 0) { // Compara el autor con el valor en el JSON
          // Encontramos al autor
          cJSON *jsonTitulo = cJSON_GetObjectItem(libro, "titulo");
          if (jsonTitulo != NULL && cJSON_IsString(jsonTitulo)) {
            char *tituloEnJson = jsonTitulo -> valuestring; // Obtiene el valor de "titulo" como cadena 
            printf("- %s\n", tituloEnJson);
          }
        }
      }
    }
  }
  cJSON_Delete(root); // Libera la memoria utilizada por el objeto cJSON
}

int main(int argc, char const *argv[])
{
    if(argc <= 1) return -1;

    char *autor = argv[1];

    char *nombreArchivo = "data_material\\libros.json";

    buscarLibroPorAutor(nombreArchivo, autor);

    return 0;
}
