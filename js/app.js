
	var app = angular.module('parkoo', ['ngAnimate', 'ui.bootstrap' ]);
	
	app.controller('ListController', ['$scope', '$http', function($scope, $http) {
		//this is where we will populate our list for search functionality using data.json
		$http.get('js/data1.json').success(function(park){
		 $scope.data = park;
		});

		//transfers ALL data onto detail page (needs to be modified to return FILTERED data.)
		$scope.parkIndex = function(i){
			$scope.parkDetail=i;
		};
			
	}]);	
			
	app.controller('NavController', function(){
		this.tab = 1;
		
		this.selectTab = function(setTab){
			this.tab = setTab;
		};
		
		this.isSelected= function(checkTab){
			return this.tab === checkTab;
		};
		
		});	
	
	
	
	app.config(function($compileProvider){
		$compileProvider.aHrefSanitizationWhitelist(/^\s*(geo|https?|ftp|mailto|file|ghttps?|ms-appx|x-wmapp0):/);
	}); 	

