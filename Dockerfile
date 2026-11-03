# ---------- Stage 1: Build ----------
FROM eclipse-temurin:25-jdk-alpine AS build
WORKDIR /app

COPY .mvn/ .mvn/
COPY mvnw mvnw.cmd pom.xml ./

# Fix potential line ending issues and make mvnw executable
RUN apk add --no-cache dos2unix && \
    dos2unix mvnw && \
    chmod +x mvnw

RUN ./mvnw -B dependency:go-offline

COPY src/ src/
RUN ./mvnw -B clean package -DskipTests

# ---------- Stage 2: Run ----------
FROM eclipse-temurin:25-jre-alpine
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]