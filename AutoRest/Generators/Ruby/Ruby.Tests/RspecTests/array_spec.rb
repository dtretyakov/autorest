require 'rspec'
require 'msrest'
require_relative 'Array/sdk_requirements'
require_relative './helper'
include MyNamespace

describe Array do

  before(:all) do
    @base_url = ENV['StubServerURI']
    client = AutoRestSwaggerBATArrayService.new(@base_url)
    @array_client = MyNamespace::Array.new(client)
    @arr_bool = [true, false, false, true]
    @arr_string = ["foo1", "foo2", "foo3"]
    @arr_int = [1, -1, 3, 300]
    @arr_float = [0, -0.01, -1.2e20]
    @arr_date = [Date.new(2000, 12, 01, 0), Date.new(1980, 1, 2, 0),Date.new(1492, 10, 12, 0)]
    @arr_date_nil = [Date.new(2012, 1, 1, 0), nil, Date.new(1776, 7, 4, 0)]
    @arr_dateTime = [DateTime.new(2000, 12, 01, 0, 0, 1), DateTime.new(1980, 1, 2, 0, 11, 35),DateTime.new(1492, 10, 12, 10, 15, 1)]
    @arr_dateTime_nil = [DateTime.new(2000, 12, 01, 0, 0, 1), nil]

    @product1 = Models::Product.new
    @product2 = Models::Product.new
    @product3 = Models::Product.new
    @product1.string = "2"
    @product1.integer = 1
    @product2.string = "4"
    @product2.integer = 3
    @product3.string = "6"
    @product3.integer = 5
    @arr_complex = [@product1, @product2, @product3]

    @arr_complex_empty = [@product1, Models::Product.new, @product3]

    @arr_complex_nil = [@product1, nil, @product3]

    @arr_byte = [[0x0FF, 0x0FF, 0x0FF, 0x0FA],[0x01, 0x02, 0x03],[0x025, 0x029, 0x043]]
    @arr_byte_nil = [[0x0AB, 0x0AC, 0x0AD], nil]
    @arr_array= [['1', '2', '3'], ['4', '5', '6'], ['7', '8', '9']]
    @arr_dict = [{'1'=> 'one', '2' => 'two', '3' => 'three'}, {'4'=> 'four', '5' => 'five', '6' => 'six'}, {'7'=> 'seven', '8' => 'eight', '9' => 'nine'}]
  end

  it 'should create test service' do
    expect{AutoRestSwaggerBATArrayService.new(@base_url)}.not_to raise_error
  end

  it 'should get null' do
    result = @array_client.get_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to be_nil
  end

  it 'should get empty' do
    result = @array_client.get_empty().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([])
  end

  it 'should put empty' do
    result = @array_client.put_empty([]).value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
  end

  # Boolean tests
  it 'should get boolean tfft' do
    result = @array_client.get_boolean_tfft().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(@arr_bool)
  end

  it 'should put boolean tfft' do
    result = @array_client.put_boolean_tfft(@arr_bool).value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
  end

  it 'should get boolean invalid null' do
    result = @array_client.get_boolean_invalid_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([true, nil, false])
  end

  it 'should get boolean invalid string' do
    result = @array_client.get_boolean_invalid_string().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([true, "boolean", false])
  end

  #Integer tests
  it 'should get integer valid' do
    result = @array_client.get_integer_valid().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(@arr_int)
  end

  it 'should put integer valid' do
    result = @array_client.put_integer_valid(@arr_int).value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
  end

  it 'should get int invalid null' do
    result = @array_client.get_int_invalid_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([1, nil, 0])
  end

  it 'should get int invalid string' do
    result = @array_client.get_int_invalid_string().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([1, "integer", 0])
  end

  #Long integer tests. Ruby automtically converts int to long int, so there is no
  # special data type.
  it 'should get long valid' do
    result = @array_client.get_long_valid().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(@arr_int)
  end

  it 'should put long valid' do
    result = @array_client.put_long_valid(@arr_int).value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
  end

  it 'should get long invalid null' do
    result = @array_client.get_long_invalid_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([ 1, nil, 0 ])
  end

  it 'should get long invalid string' do
    result = @array_client.get_long_invalid_string().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([1, "integer", 0])
  end

  #Float tests
  it 'should get float valid' do
    result = @array_client.get_float_valid().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(@arr_float)
  end

  it 'should put float valid' do
    result = @array_client.put_float_valid(@arr_float).value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
  end

  it 'should get float invalid null' do
    result = @array_client.get_float_invalid_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([ 0.0, nil, -1.2e20 ])
  end

  it 'should get float invalid string' do
    result = @array_client.get_float_invalid_string().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([1, "number", 0])
  end

  #Double tests
  it 'should get double valid' do
    result = @array_client.get_double_valid().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(@arr_float)
  end

  it 'should put double valid' do
    result = @array_client.put_double_valid(@arr_float).value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
  end

  it 'should get double invalid null' do
    result = @array_client.get_double_invalid_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([ 0.0, nil, -1.2e20 ])
  end

  it 'should get double invalid string' do
    result = @array_client.get_double_invalid_string().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([1, "number", 0])
  end

  #String tests
  it 'should get string valid' do
    result = @array_client.get_string_valid().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(@arr_string)
  end

  it 'should put string valid' do
    result = @array_client.put_string_valid(@arr_string).value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
  end

  it 'should get string invalid null' do
    result = @array_client.get_string_with_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([ "foo", nil, "foo2"])
  end

  it 'should get string invalid' do
    result = @array_client.get_string_with_invalid().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(["foo", 123, "foo2"])
  end

  #Date tests
  it 'should get date valid' do
    result = @array_client.get_date_valid().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(@arr_date)
  end

  it 'should put date valid' do
    result = @array_client.put_date_valid(@arr_date).value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
  end

  it 'should get date invalid null' do
    result = @array_client.get_date_invalid_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(@arr_date_nil)
  end

  it 'should get date invalid chars' do
    expect { @array_client.get_date_invalid_chars().value! }.to raise_exception(ClientRuntime::DeserializationError)
  end

  #DateTime tests
  it 'should get dateTime valid' do
    result = @array_client.get_date_time_valid().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(@arr_dateTime)
  end

  it 'should put dateTime valid' do
    result = @array_client.put_date_time_valid(@arr_dateTime).value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
  end

  it 'should get dateTime invalid null' do
    result = @array_client.get_date_time_invalid_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(@arr_dateTime_nil)
  end

  it 'should get dateTime invalid string' do
    expect { @array_client.get_date_time_invalid_chars().value! }.to raise_exception(ClientRuntime::DeserializationError)
  end

  #Byte tests
  it 'should get byte valid' do
    result = @array_client.get_byte_valid().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(@arr_byte)
  end

  it 'should put byte valid' do
    result = @array_client.put_byte_valid(@arr_byte).value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
  end

  it 'should get byte invalid null' do
    result = @array_client.get_byte_invalid_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(@arr_byte_nil)
  end

  #Complex tests
  it 'should get complex null' do
    result = @array_client.get_complex_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to be_nil
  end

  it 'should get empty null' do
    result = @array_client.get_complex_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to be_nil
  end

  it 'should get сomplex item null' do
    result = @array_client.get_complex_item_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body.count).to eq(@arr_complex_nil.count)
    @arr_complex_nil.each_with_index do |item, index|
      expect(result.body[index]).to be_equal_objects(item)
    end
  end

  it 'should get complex item empty' do
    result = @array_client.get_complex_item_empty().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body.count).to eq(@arr_complex_empty.count)
    @arr_complex_empty.each_with_index do |item, index|
      expect(result.body[index]).to be_equal_objects(item)
    end
  end

  it 'should get complex valid' do
    result = @array_client.get_complex_valid().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body.count).to eq(@arr_complex.count)
    @arr_complex.each_with_index do |item, index|
      expect(result.body[index]).to be_equal_objects(item)
    end
  end

  it 'should put complex valid' do
    result = @array_client.put_complex_valid(@arr_complex).value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
  end

  #Array tests
  it 'should get array null' do
    result = @array_client.get_array_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to be_nil
  end

  it 'should get array empty' do
    result = @array_client.get_array_empty().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([])
  end

  it 'should get array item null' do
    result = @array_client.get_array_item_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([["1", "2", "3"], nil, ["7", "8", "9"]])
  end

  it 'should get array item empty' do
    result = @array_client.get_array_item_empty().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([["1", "2", "3"], [], ["7", "8", "9"]])
  end

  it 'should get array valid' do
    result = @array_client.get_array_valid().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(@arr_array)
  end

  it 'should put array valid' do
    result = @array_client.put_array_valid(@arr_array).value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
  end

  #Dictionary tests
  it 'should get dictionary null' do
    result = @array_client.get_dictionary_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to be_nil
  end

  it 'should get dictionary empty' do
    result = @array_client.get_dictionary_empty().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([])
  end

  it 'should get dictionary item null' do
    result = @array_client.get_dictionary_item_null().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([{'1'=> 'one', '2' => 'two', '3' => 'three'}, nil, {'7'=> 'seven', '8' => 'eight', '9' => 'nine'}])
  end

  it 'should get dictionary item empty' do
    result = @array_client.get_dictionary_item_empty().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq([{'1'=> 'one', '2' => 'two', '3' => 'three'}, {}, {'7'=> 'seven', '8' => 'eight', '9' => 'nine'}])
  end

  it 'should get dictionary valid' do
    result = @array_client.get_dictionary_valid().value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
    expect(result.body).to eq(@arr_dict)
  end

  it 'should put dictionary valid' do
    result = @array_client.put_dictionary_valid(@arr_dict).value!
    expect(result.response).to be_an_instance_of(Net::HTTPOK)
  end
end