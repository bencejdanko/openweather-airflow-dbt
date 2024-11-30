-- full join city and weather table to display all columns from both tables
SELECT
    w.CITY_ID,
    c."Name" AS CITY_NAME,
    c."Latitude" AS CITY_LATITUDE,
    c."Longitude" AS CITY_LONGITUDE,
    w.DATE_TIME,
    ((w.TEMP - 273.15) * 9/5 + 32) AS TEMP_FAHRENHEIT, -- converting Kelvin to Fahrenheit
    ((w.FEELS_LIKE - 273.15) * 9/5 + 32) AS FEELS_LIKE_FAHRENHEIT, -- converting K to F
    w.PRESSURE,
    w.HUMIDITY,
    w.WIND_SPEED,
    w.CLOUD_COVERAGE,
    w.WEATHER_MAIN,
    w.WEATHER_DET
FROM
    {{ source('openweather', 'WEATHER_FACT_TABLE') }} w
JOIN
    {{ source('openweather', 'CITY_DIMENSION_TABLE') }} c
ON
    w.CITY_ID = c.CITY_ID
