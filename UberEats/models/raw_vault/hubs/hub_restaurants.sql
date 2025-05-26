WITH source AS (
  SELECT * FROM {{ source('uber_eats', 'v_stg_restaurants') }}
),

deduplicated AS (
  SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['cnpj']) }} AS hash_hub_cnpj,
    cnpj,
    'trn-restaurant-mysql' AS bkcc,
    'tenant-br' AS multi_tenant_id,
    load_dts,
    rec_src AS record_source
  FROM source
)

SELECT * FROM deduplicated
