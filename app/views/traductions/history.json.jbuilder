json.array!(@traductions) do |traduction|
  json.extract! traduction, :fr, :en
  json.url traduction_url(traduction, format: :json)
end
