do $$
begin
  assert (
    select exists (
      select 1
      from information_schema.schemata
      where schema_name = 'api'
    )
  );
end;
$$ language plpgsql;
