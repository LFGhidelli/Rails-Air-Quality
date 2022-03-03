class HomeController < ApplicationController
  require 'json'
  require 'net/http'

  def index
    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=90401&distance=0&API_KEY=3882AA8D-2016-4057-AD48-B293F276254F'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    # Check for empty return result

    @final_output = if @output.empty?
                      'Error'
                    else
                      @output[0]['AQI']
                    end

    if @final_output == 'Error'
      @api_color = 'grey'
      @api_description = 'No data'
    elsif @final_output <= 50
      @api_color = 'green'
      @api_description = 'Good (0 - 50) - Air quality considered satisfatory and air pollution poses little risk'
    elsif @final_output >= 51 && @final_output <= 100
      @api_color = 'yellow'
      @api_description = 'Moderate (51-100) - Air quality acceptable, however, for some pollutants there may be a moderate health concern for a vary small number of people'
    elsif @final_output >= 101 && @final_output <= 150
      @api_color = 'orange'
      @api_description = 'Unhealthy for Sensitive Groups (101 - 150) - Peopla with lung disease, older adults and childres are at a greater risk from exposure to ozone'
    elsif @final_output >= 151 && @final_output <= 200
      @api_color = 'red'
      @api_description = 'Unhealthy (151 - 200) - Everyone maybe experience health effects '
    elsif @final_output >= 201 && @final_output <= 300
      @api_color = 'purple'
      @api_description = 'Very Unhealthy (201 - 250) - People may experience more serious health effects'
    elsif @final_output >= 301 && @final_output <= 500
      @api_color = 'maroon'
      @api_description = 'Hazardous (251 - 300) - Health warnings of emergency conditions. All population is more likely to be affected'
    end
  end

  def zipcode
    @info = params[:zipcode]

    if params[:zipcode] == ''
      @info = 'You forgot to enter a zipcode!'
    elsif params[:zipcode]
      # API stuff
      require 'json'
      require 'net/http'
      @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' + @info + '&distance=0&API_KEY=3882AA8D-2016-4057-AD48-B293F276254F'
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)

      # Check for empty return result

      @final_output = if @output.empty?
                        'Error'
                      else
                        @output[1]['AQI']
                      end

      if @final_output == 'Error'
        @api_color = 'grey'
        @api_description = 'No data'
      elsif @final_output <= 50
        @api_color = 'green'
        @api_description = 'Good (0 - 50) - Air quality considered satisfatory and air pollution poses little risk'
      elsif @final_output >= 51 && @final_output <= 100
        @api_color = 'yellow'
        @api_description = 'Moderate (51-100) - Air quality acceptable, however, for some pollutants there may be a moderate health concern for a very small number of people'
      elsif @final_output >= 101 && @final_output <= 150
        @api_color = 'orange'
        @api_description = 'Unhealthy for Sensitive Groups (101 - 150) - Peopla with lung disease, older adults and childres are at a greater risk from exposure to ozone'
      elsif @final_output >= 151 && @final_output <= 200
        @api_color = 'red'
        @api_description = 'Unhealthy (151 - 200) - Everyone maybe experience health effects '
      elsif @final_output >= 201 && @final_output <= 300
        @api_color = 'purple'
        @api_description = 'Very Unhealthy (201 - 250) - People may experience more serious health effects'
      elsif @final_output >= 301 && @final_output <= 500
        @api_color = 'maroon'
        @api_description = 'Hazardous (251 - 300) - Health warnings of emergency conditions. All population is more likely to be affected'
      end
    end
  end
end
