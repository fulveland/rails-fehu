angular.module "FehuApp", [
   # Libs
   "ngRoute"
   "ngTouch"
   
   # Components
   "Product"
   "ProductInfo"
   "Variations"
   
   # Pages
   "About"
   "Events"
   "Locations"
   "Shop"
   
   # Scripts
   "bimg"
   "PageStyle"
   "Products"
   "Routes"
   "StubProducts"
   "StubLocations"
]

.config new Array "$locationProvider", ($locationProvider)->
  $locationProvider.html5Mode enabled:true, requireBase:false
