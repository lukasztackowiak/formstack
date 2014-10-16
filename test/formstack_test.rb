require 'helper'

class FormstackTest < Minitest::Test
  
  context "Formstack API" do
    
    setup do
      @client = Formstack::Client.new("OU812")
    end
    
    should "list forms for an account" do
      stub_get("/forms?type=json&api_key=OU812", "forms.json")
      forms = @client.forms

      assert_equal forms.size, 1
      assert_equal forms.first.name, 'Contact'
    end
    
    should "get details for a form" do
      stub_get("/form?id=1234&type=json&api_key=OU812", "form.json")
      form = @client.form(1234)

      assert_equal form.fields.size, 5
      assert_equal form.fields.first.section_heading, 'Contact Information'
    end
    
    should "get submitted data for a form" do
      stub_get("/data?id=1234&page=1&type=json&api_key=OU812", "data.json")
      submissions = @client.data(1234, :page => 1).submissions

      assert_equal submissions.size, 2
      assert_equal submissions.first['1111'], 'John Smith'
      assert_equal submissions.first.timestamp.year, 2007
    end
    
    should "return a single submission collected for a form" do
      stub_get("/submission?id=1001&type=json&api_key=OU812", "submission.json")
      submission = @client.submission(1001)

      assert_equal submission['2222'], 'Apple'
      assert_equal submission.timestamp.year, 2007
    end
    
    should "prepare data for form submission" do
      stub_get("/form?id=1234&type=json&api_key=OU812", "form.json")
      params = {:page => 3, :data => {:name => "Wynn Netherland", :phone => "940-867-5309", '123' => 'foo'}}
      prepared = @client.prepare_params(1234, params)

      assert_equal prepared['field_7344054'], 'Wynn Netherland'
      assert_equal prepared['field_7344057'], '940-867-5309'
      assert_equal prepared['field_123'], 'foo'
    end
    
    should "submit data for a form" do
      stub_post("/submit?type=json&api_key=OU812", "submit.json")
      id = @client.submit(1234, :data => {:foo => 'bar'})

      assert_equal id, 10001
    end
    
    should "update submitted data for a form" do
      stub_post("/edit?type=json&api_key=OU812", "submit.json")
      id = @client.edit(1234, :data => {:foo => 'bar'})

      assert_equal id, 10001
    end
    
    should "delete submitted data for a form" do
      stub_post("/delete?type=json&api_key=OU812", "submit.json")
      id = @client.delete(1234)

      assert_equal id, 10001
    end

  end

end
