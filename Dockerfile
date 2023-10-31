FROM openjdk:11
RUN groupadd -r ttrend && useradd -r -g ttrend ttrend
ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar ttrend.jar
RUN chown ttrend:ttrend ttrend.jar
USER ttrend
ENTRYPOINT ["java", "-jar", "ttrend.jar"]
