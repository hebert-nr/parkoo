
	var app = angular.module('parkoo', ['ui.bootstrap','angular.filter']);
	
	app.controller('ListController',function($scope, $http) {
		$http.get('js/data1.json').success(function(park){
		  $scope.data = park;
		  $scope.parkOrder='parkName';
		  $scope.display = 10;		  
		});
			$scope.pageChangeHandler = function(num) {
			console.log('data page changed to ' + num);
			};
			$scope.parkIndex = function(i){
			$scope.parkDetail=i;
			};
			
		});

	app.controller('OtherController', function($scope) {
	  $scope.pageChangeHandler = function(num) {
		console.log('going to page ' + num);
	  };
	});	
			
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

	
	app.controller('PaginationDemoCtrl',function ($scope,  $window) {
        // Pagination variables
        $scope.totalItems = 100;
        $scope.currentPage = 1;
        $scope.maxSize = 8;
        $scope.itemsPerPage = 10;
        $scope.windowWidth = '';
        
         // Window resize event
         var w = angular.element($window);
         w.bind('resize', function () {
             
             // Get window width
             $scope.windowWidth = "innerWidth" in window ? window.innerWidth : document.documentElement.offsetWidth;
             
             // Change maxSize based on window width
             if($scope.windowWidth > 800) {
                 $scope.maxSize = 8;
             } else if($scope.windowWidth > 400) {
                 $scope.maxSize = 5;
             } else {
                 $scope.maxSize = 2;
             }
             $scope.$apply();
         });
});
	
	
	//filter Multiple...
	app.filter('filterMultiple',['$filter',function ($filter) {
		return function (items, keyObj) {
			var filterObj = {
								data:items,
								filteredData:[],
								applyFilter : function(obj,key){
									var fData = [];
									if(this.filteredData.length == 0)
										this.filteredData = this.data;
									if(obj){
										var fObj = {};
										if(angular.isString(obj)){
											fObj[key] = obj;
											fData = fData.concat($filter('filter')(this.filteredData,fObj));
										}else if(angular.isArray(obj)){
											if(obj.length > 0){	
												for(var i=0;i<obj.length;i++){
													if(angular.isString(obj[i])){
														fObj[key] = obj[i];
														fData = fData.concat($filter('filter')(this.filteredData,fObj));	
													}
												}
												
											}										
										}									
										if(fData.length > 0){
											this.filteredData = fData;
										}
									}
								}
					};

			if(keyObj){
				angular.forEach(keyObj,function(obj,key){
					filterObj.applyFilter(obj,key);
				});			
			}
			
			return filterObj.filteredData;
		}
	}]);

	app.filter('unique', function() {
		return function(input, key) {
			var unique = {};
			var uniqueList = [];
			for(var i = 0; i < input.length; i++){
				if(typeof unique[input[i][key]] == "undefined"){
					unique[input[i][key]] = "";
					uniqueList.push(input[i]);
				}
			}
			return uniqueList;
		};
	});
		
