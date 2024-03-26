
<p align="center"><img src="logo-with-text.png" alt="drawing" width="250"/></p>

<p align="center">Slings from a data source to a data target.</p>


## How To Use

1. Somewhere in your repo, create a [Replication YAML file](https://docs.slingdata.io/sling-cli/replication), something like this:

```yaml
source: MY_POSTGRES
target: MY_SNOWFLAKE

# default config options which apply to all streams
defaults:
  mode: full-refresh # valid choices: incremental, truncate, full-refresh, snapshot

  # specify pattern to use for object naming in target connection, see below for options
  object: '{target_schema}.{stream_schema}_{stream_table}'

  # source_options: # optional for more advanced options for source connection
  # target_options: # optional for more advanced options for target connection

streams:
  finance.accounts:
  finance.users:
    disabled: true
  finance.departments:
    object: '{target_schema}.finance_departments_old' # overwrite default object
    source_options:
      empty_as_null: false
  finance."Transactions":
    mode: incremental # overwrite default mode
    primary_key: id
    update_key: last_updated_at
```
2. Add your Connection credentials to your Github Secrets. In our example above, we need to set the connection URL strings as secrets in `MY_POSTGRES` and `MY_SNOWFLAKE`. See [here](https://docs.slingdata.io/sling-cli/environment#environment-variables) for examples.

3. Add this step to your Github Actions workflow:

```yaml
steps:
  - uses: slingdata-io/sling-action@v2
    with:
      command: run -r my-replication.yaml
    env:
      MY_POSTGRES: ${{ secrets.MY_POSTGRES }}
      MY_SNOWFLAKE: ${{ secrets.MY_SNOWFLAKE }}
```

4. Run your action! Reach out to `support@slingdata.io` if facing any issues.
