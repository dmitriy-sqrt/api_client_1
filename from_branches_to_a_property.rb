require './client.rb'

#get all branches, that you have access to
branches = ApiClient::Branch.all

#pick first branch
branch = branches.first

#and retrieve its data
branch_detailed = ApiClient::Branch.find(branch.id)

#now get branch landlords list
landlords = ApiClient::Branch::Landlord.where(branch_id: branch.id).all
landlord = landlords.first

#and retrieve details for the last one
landlord_detailed = ApiClient::Landlord.find(landlord.id)

#go get his properties
properties = ApiClient::Landlord::Property.where(landlord_id: landlord.id).all
#raise properties.inspect
#check if we`ve got the one from Franzburgh
target_property = properties.detect do
  |property| property.town == "Franzburgh"
end

#@todo see if this can work
unless target_property.present?
  #and add a new property for the landlord
  # property = ApiClient::Landlord::Property.where(landlord_id: landlord.id)
  #   .new(
  #     address_1: "#{rand(350)} Langosh Viaduct",
  #     town: "Franzburgh",
  #     post_code: "WGE 123S",
  #     create_status: "vacant"
  #   )
  # property.save
end

