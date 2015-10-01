# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  regex = /#{e1}.*#{e2}/m
  expect(page.body).to match(regex)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  if uncheck == "un"							#Condition for unchecked movies
    rating_list.split(', ').each {|x| step %{I uncheck "ratings_#{x}"}} #splitting the ratings on the basis of comma
  else									#Conition for checked movies
    rating_list.split(', ').each {|x| step %{I check "ratings_#{x}"}}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  expect(page).to have_css("table#movies tbody tr", count: Movie.count)
  #rows = page.all('#movies tr').size - 1
  #assert rows == Movie.count()
end
