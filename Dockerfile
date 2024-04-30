FROM maven:3.9.6 as builder
COPY . /service-registry/app
WORKDIR /service-registry/app
RUN mvn clean package -DskipTests

FROM openjdk:17
WORKDIR /service-registry/app
COPY --from=builder /service-registry/app/target/*.jar app.jar
EXPOSE 8086
ENTRYPOINT ["java", "-jar", "app.jar"]