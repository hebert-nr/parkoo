
	var app = angular.module('parkoo', ['angularUtils.directives.dirPagination']);
	
	function ListController($scope, $http) {
		$http.get('js/data1.json').success(function(park){
		  $scope.currentPage = 1;
		  $scope.pageSize = 10;
		  $scope.data = park;
		});
		  $scope.pageChangeHandler = function(num) {
			  console.log('meals page changed to ' + num);
		  };
		  $scope.parkIndex = function(i){
			$scope.parkDetail=i;
		};
	}

	function OtherController($scope) {
	  $scope.pageChangeHandler = function(num) {
		   console.log('going to page ' + num);
	  };
	}
			
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

	app.controller('ListController', ListController);
	app.controller('OtherController', OtherController);