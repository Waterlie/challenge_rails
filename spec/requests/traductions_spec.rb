require 'spec_helper'

describe "Traductions" do

  describe "GET /traductions/home" do
    it "should show 'Challenge Rails'" do
      visit '/home'
      expect(page).to have_content('Challenge Rails')
    end
  end
end
