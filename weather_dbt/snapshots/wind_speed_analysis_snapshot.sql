{% snapshot snapshot_wind_speed %}

{{
  config(
    target_schema='snapshot',
    unique_key='DAY',
    strategy='timestamp',
    updated_at='DAY',
    invalidate_hard_deletes=True
  )
}}

WITH WindSpeedData AS (
    SELECT 
        w.WIND_SPEED,
        c.city_name AS CITY_NAME,
        w.DATE_TIME,
        DATE_TRUNC('DAY', w.DATE_TIME) AS DAY
    FROM
        {{ source('openweather', 'WEATHER_FACT_TABLE') }} w
    JOIN
        {{ source('openweather', 'CITY_DIMENSION_TABLE') }} c
    ON
        w.CITY_ID = c.CITY_ID
    WHERE
        w.WIND_SPEED IS NOT NULL
)
SELECT 
    CITY_NAME,
    DAY,
    AVG(WIND_SPEED) AS AVG_WIND_SPEED
FROM WindSpeedData
GROUP BY 
    CITY_NAME,
    DAY
ORDER BY 
    CITY_NAME,
    DAY

{% endsnapshot %}
