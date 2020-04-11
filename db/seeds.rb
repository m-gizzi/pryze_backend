# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

fundraisers = [
    {name: "Saved By The Max", url: "https://www.gofundme.com/f/helpuskeeppoppingup", address: "7100 Santa Monica Blvd #185, West Hollywood, CA 90046", latitude: 34.090750, longitude: -118.344520},
    {name: "Stefani Restaurant Group", url: "https://www.gofundme.com/f/stefani-restaurant-group-employee-relief-fund", address: "1033 W Van Buren St # 5, Chicago, IL 60607", latitude: 41.876390, longitude: -87.653060},
    {name: "Footman Hospitality", url: "https://www.gofundme.com/f/footman-hospitality-employee-relief-fund", address: "2363 N Milwaukee Ave. Chicago", latitude: 41.924250, longitude: -87.699230},
    {name: "Heisler Hospitality", url: "https://www.gofundme.com/f/heisler-hospitality-employee-fund", address: "2450 N Milwaukee Ave, Chicago, IL 60647", latitude: 41.925690, longitude: -87.702060},
    {name: "4 Star Restaurant Group", url: "https://www.gofundme.com/f/4-star-restaurant-group-virtual-tip-jar", address: "3636 N Clark St, Chicago, IL 60613", latitude: 41.947982, longitude: -87.6597407},
    {name: "Hammock Hospitality", url: "https://www.gofundme.com/f/hammock-hospitality-employee-relief", address: "459 N Ogden Ave, Chicago, IL 60642", latitude: 41.8905021, longitude: -87.6613615},
    {name: "Farmhouse Chicago", url: "https://www.gofundme.com/f/farmhouse-amp-farm-bar-staff", address: "228 W Chicago Ave, Chicago, IL 60654", latitude: 41.8967165, longitude: -87.6375766},
    {name: "Gage Hospitality", url: "https://www.gofundme.com/f/gage-hospitality-group-emloyee-relief-fund", address: "18 S Michigan Ave, Chicago, IL 60603", latitude: 41.8814882, longitude: -87.6271897},
    {name: "Heritage Coffee", url: "https://www.gofundme.com/f/1xhn5n9rw0", address: "1325 W Wilson Ave, Chicago, IL 60640", latitude: 41.9651916, longitude: -87.6655386},
    {name: "Lettuce Entertain You", url: "https://www.gofundme.com/f/LEYEemployeerelief", address: "5419 N Sheridan Rd, Chicago, IL 60640", latitude: 41.9803466, longitude: -87.6565158},
    {name: "Hogsalt", url: "https://www.gofundme.com/f/hogsalt-employee-emergency-relief-fund", address: "936 W Huron St, Chicago, IL 60642", latitude: 41.895248, longitude: -87.6538167},
    {name: "Bokeh", url: "https://www.gofundme.com/f/bokeh-bar-amp-staff-fund", address: "4716 N Kedzie Ave, Chicago, IL 60625", latitude: 41.9671648, longitude: -87.7108187},
    {name: "Hot Dog Station", url: "https://www.gofundme.com/f/help-hot-dog-station-survive-covid19-virus", address: "4742 N Kimball Ave, Chicago, IL 60625", latitude: 41.9678496, longitude: -87.7157613},
    {name: "The Sofo Tap", url: "https://www.gofundme.com/f/2bears-tavern-group-staff-assitance-fund", address: "4923 N Clark St 1st floor, Chicago, IL 60640", latitude: 41.9724237, longitude: -87.6698123},
    {name: "Lost Larson", url: "https://www.gofundme.com/f/lost-larson-employee-relief", address: "5318 N Clark St, Chicago, IL 60640", latitude: 41.9786254, longitude: -87.6708362},
    {name: "A Taste of Heaven", url: "https://www.gofundme.com/f/help-a-taste-of-heaven-servers", address: "5401 N Clark St, Chicago, IL 60640", latitude: 41.9799916, longitude: -87.6702083},
    {name: "The Bongo Room", url: "https://www.gofundme.com/f/bongo-room-employees-relief-fund", address: "5022 N Clark St, Chicago, IL 60640", latitude: 41.9731806, longitude: -87.6705684},
    {name: "Hopleaf", url: "https://www.gofundme.com/f/hopleaf-staffers-fund", address: "5148 N Clark St, Chicago, IL 60640", latitude: 41.9758184, longitude: -87.6707483},
    {name: "La Colombe Coffee", url: "https://www.gofundme.com/f/la-colombe-andersonville-pandemic-relief", address: "5158 N Clark St, Chicago, IL 60640", latitude: 41.9760303, longitude: -87.670764},
    {name: "Little Bad Wolf", url: "https://www.gofundme.com/f/helping-support-little-bad-wolf", address: "1541 W Bryn Mawr Ave, Chicago, IL 60660", latitude: 41.9833527, longitude: -87.6712523}
]

fundraisers.each do |fundraiser|
    Fundraiser.create(fundraiser)
end