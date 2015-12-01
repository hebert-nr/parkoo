
	var app = angular.module('parkoo', ['angularUtils.directives.dirPagination','ui.bootstrap']);
	
	function ListController($scope, $http, $window) {
		$http.get('js/data1.json').success(function(park){
		  $scope.data = park;
		  $scope.parkOrder='parkName';
		  $scope.currentPage = 1;
		  $scope.pageSize = 20;
		});
			$scope.pageChangeHandler = function(num) {
			console.log('data page changed to ' + num);
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