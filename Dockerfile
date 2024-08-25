# Usa una imagen base con Maven y OpenJDK 17 para la construcción
FROM maven:3.9.0-openjdk-17 AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo pom.xml y los directorios necesarios
COPY pom.xml ./
COPY src ./src

# Construye la aplicación
RUN mvn clean package -DskipTests

# Cambia a una imagen más ligera de OpenJDK 17 para la ejecución
FROM openjdk:17-jdk-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo JAR de la etapa de construcción al contenedor
COPY --from=build /app/target/mi-aplicacion.jar .

# Exponer el puerto que utilizará la aplicación
EXPOSE 8080

# Define el comando de inicio de la aplicación
CMD ["java", "-jar", "mi-aplicacion.jar"]
