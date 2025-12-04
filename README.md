# README

## ¡Hey! Les quiero presentar mi solución a la prueba técnica para la empresa Flex.

## ¿Qué tecnología se utilizó?
- Ruby 3.3.6
- Rails 8.1
- PostgresSQL

### ¿Qué Gemas se utilizaron?
- JWT y Bcrypt para la autenticación
- Active model Serializer para serilizar los objetos de Manifest y Stop.

## Esquema de la base de datos

Para la base de datos se necesitaron las siguientes entidades.

- Employee -> Usuario que puede crear el manifiesto e iniciar sesión
- Manifest -> Registro Operativo
- Location -> Ubicación del punto de origen, destino o parada.
- Driver -> Usuario que se encarga en conducir el vehículo requerido
- Vehicle -> Vehículo utilizado para realizar el viaje solicitado
- VehicleType -> Ya que se puede utilizar diferentes tipos de vehículos para distintos viajes solicitados (moto, carro, camión, etc.)

En el siguiente link podremos encontrar el esquema de la base de datos, donde se verán las relaciones, los atributos de cada entidad y sus tipos de datos.

https://dbdiagram.io/d/69306358d6676488ba7549c4

## End Points
En este proyecto se utilizan 7 end points, los cuales son:

#### End Point para poder autenticarse en la aplicación
- POST /login

#### End points para listar, crear y ver manifiestos.
- GET /api/v1/manifests
- POST /api/v1/manifests
- GET /api/v1/manifests/:id

#### End Point para crear paradas intermedias
- POST /api/v1/stops

#### Métodos para empezar un menifiesto y completar una parada intermedia.
- PATCH /api/v1/manifests/:id/start
- PATCH /api/v1/stops/:id/complete

### Consulta SQL
Si se requiere consultar los manifiestos que están en estado **in_route** y que su última parada esté en estado **complete**, se puede utilizar la siguiente consulta SQL

```bash
SELECT m.*
FROM manifests m
INNER JOIN (
  SELECT DISTINCT ON (manifest_id) 
    manifest_id, 
    id, 
    status
  FROM stops
  ORDER BY manifest_id, position DESC
) last_stop ON m.id = last_stop.manifest_id
WHERE m.status = 1
  AND last_stop.status = 2
```
En esta consulta estaremos utilizando 3 índices principales:

- Manifest status
- Stop status
- Stop position


Se utiliza un INNER JOIN para obtener la información requerida. Por medio del campo position del stop y su campo status, podemos tomar las últimas paradas que están en estado **completada**

Ya por último validamos con un INNER JOIN en Manifest que hayan manifiestos con las paradas optinidas en la consulta anterior y luego validamos que esos manifiestos estén es estado **in_route**

En este caso la consulta es bastante optimizada, sigue siendo funcional cuando el volumen de registros sea muy alto.

### Job para detectar menifiestos sin cambios por más de 2 horas.

Se debe crear un Job por medio de Sidekiq donde se lea la siguiente información:

- El campo Updated_at de Manifest, tiene actualización de hace más de 2 horas.
- la última parada fue actualizada hace más de dos horas.

con el job creado se puede utilizar la gema llamada Clockwork, para poder agendar la llamada del Job cada minuto, y así ir detectando cuáles son los manifiestos que no tienen cambios en más de 2 horas.



