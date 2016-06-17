require_relative 'test_helper'
class AriadneTest < MiniTest::Test
  def test_insert_data
    app_name = 'test'
    data = {
      id:        123,
      state:    'active'
    }

    out = Ariadne.insert_data(data)
    assert_equal Redis::Future, out.class
  end

  def test_get_data
    data = {
      id:        123,
      state:    'active'
    }
    Ariadne.insert_data(data)
    out = Ariadne.get_data
    assert_equal JSON.parse(out[0])['id'], data[:id]
  end

  def test_get_data_with_time_diff_without_delay_should_be_empty
    data = {
      id:        123,
      state:    'active'
    }

    Ariadne.insert_data(data)
    out = Ariadne.get_data_with_time_difference
    assert_empty JSON.parse(out)
  end

  def test_get_data_with_time_diff_with_delay_should_not_be_empty
    delay_interval = 2
    data = {
      id:             123,
      state:          'active',
      delay_interval: delay_interval
    }

    Ariadne.insert_data(data)
    sleep delay_interval
    out = Ariadne.get_data_with_time_difference
    assert_equal JSON.parse(out)[0]['id'], data[:id]
  end

  def test_get_data_with_id
    data = {
      id:        123,
      state:    'active'
    }

    Ariadne.insert_data(data)
    out = Ariadne.get_data(id: data[:id])
    assert_equal JSON.parse(out[0])['id'], data[:id]
  end

  def test_get_data_with_time_diff_with_id_without_delay_should_be_empty
    data = {
      id:        123,
      state:    'active'
    }

    Ariadne.insert_data(data)
    out = Ariadne.get_data_with_time_difference(id: data[:id])
    assert_empty JSON.parse(out)
  end

  def test_get_data_with_time_diff_with_id_with_delay_should_not_be_empty
    delay_interval = 2
    data = {
      id:             123,
      state:          'active',
      delay_interval: delay_interval
    }

    Ariadne.insert_data(data)
    sleep delay_interval
    out = Ariadne.get_data_with_time_difference(id: data[:id])
    assert_equal JSON.parse(out)[0]['id'], data[:id]
  end
end