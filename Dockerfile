# Usa una imagen base con OpenJDK 17 y Gradle
FROM gradle:7.4.0-jdk17 AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo build.gradle y los directorios necesarios
COPY build.gradle settings.gradle ./
COPY src ./src

# Construye la aplicación
RUN gradle build --no-daemon

# Cambia a una imagen más ligera de OpenJDK 17 para la ejecución
FROM openjdk:17-jdk-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo JAR de la etapa de construcción al contenedor
COPY --from=build /app/build/libs/mi-aplicacion.jar .

# Exponer el puerto que utilizará la aplicación
EXPOSE 8080

# Define el comando de inicio de la aplicación
CMD ["java", "-jar", "miNombre.jar"]