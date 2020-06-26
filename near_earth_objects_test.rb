# require 'minitest/autorun'
# require 'minitest/pride'
# require 'pry'
# require_relative 'near_earth_objects'

# class NearEarthObjectsTest < Minitest::Test
#   def test_a_date_returns_a_list_of_neos
#     results = NearEarthObjects.find_neos_by_date('2019-03-30')
#     assert_equal '(2019 GD4)', results[:astroid_list][0][:name]
#   end
# end
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'json'
require_relative 'near_earth_objects'

class NearEarthObjectsTest < Minitest::Test
  def setup
    @near_earth_objects = NearEarthObjects.new("2000-06-21")
  end

  def test_it_can_exist
    assert_instance_of NearEarthObjects, @near_earth_objects
  end

  def test_it_has_attributes
    parsed_asteroid_data = @near_earth_objects.parsed_asteroid_data("2000-06-21")

    assert_equal parsed_asteroid_data, @near_earth_objects.asteroids
  end

  def test_it_can_parse_asteroid_data
    assert_instance_of Array, @near_earth_objects.parsed_asteroid_data("2000-06-21")
    assert_instance_of Hash, @near_earth_objects.parsed_asteroid_data("2000-06-21")[0]
    assert_equal "2067381", @near_earth_objects.parsed_asteroid_data("2000-06-21")[0][:id]
  end

  def test_it_can_format_asteroid_data
    expected = [
      {name:"67381 (2000 OL8)", diameter:"2138 ft", miss_distance: "26773987 miles"}, 
      {name:"480885 (2002 AC29)", diameter:"5128 ft", miss_distance: "6887181 miles"}, 
      {name:"(2019 JC47)", diameter:"1698 ft", miss_distance: "29793119 miles"}, 
      {name:"(2002 AC29)", diameter:"5888 ft", miss_distance: "6887333 miles"}, 
      {name:"52761 (1998 MN14)", diameter:"5370 ft", miss_distance: "41098152 miles"}, 
      {name:"(2013 ND15)", diameter:"295 ft", miss_distance: "9221690 miles"}, 
      {name:"(2020 HV4)", diameter:"431 ft", miss_distance: "19074544 miles"}
    ]

    assert_equal expected, @near_earth_objects.formatted_asteroid_data
  end

  def test_it_can_find_the_largest_asteroid_diameter
    assert_equal 5888.7759358124, @near_earth_objects.largest_asteroid_diameter
  end

  def test_it_can_find_the_total_number_of_asteroids
    assert_equal 7, @near_earth_objects.total_number_of_asteroids
  end

  def test_it_can_list_asteroid_details
    expected = {asteroid_list: 
      [
        {name: "67381 (2000 OL8)", diameter: "2138 ft", miss_distance: "26773987 miles"}, 
        {name: "480885 (2002 AC29)", diameter: "5128 ft", miss_distance: "6887181 miles"}, 
        {name: "(2019 JC47)", diameter: "1698 ft", miss_distance: "29793119 miles"}, 
        {name: "(2002 AC29)", diameter: "5888 ft", miss_distance: "6887333 miles"}, 
        {name: "52761 (1998 MN14)", diameter: "5370 ft", miss_distance: "41098152 miles"}, 
        {name: "(2013 ND15)", diameter: "295 ft", miss_distance: "9221690 miles"}, 
        {name: "(2020 HV4)", diameter: "431 ft", miss_distance: "19074544 miles"}
      ], 
      biggest_asteroid: 5888.7759358124, 
      total_number_of_asteroids: 7}

    assert_equal expected, @near_earth_objects.asteroid_details
  end
end