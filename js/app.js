//api key for android  AIzaSyCDal7Kp5XfR87QBXViXtpn8deSN3newrI


	var app = angular.module('parkoo', ['angularUtils.directives.dirPagination', 'ui.bootstrap','angular.filter']);
	
	app.controller('ListController',function($scope, $http) {
		$http.get('js/data1.json').success(function(park){
		  $scope.data = park;
		  $scope.parkOrder='parkName';
		  $scope.display = 10;
		});
		$http.get('js/features.json').success(function(feats){
			$scope.feat = feats;
		});
			$scope.pageChangeHandler = function(num) {
			  console.log('parks page changed to ' + num);
		  };

			$scope.parkIndex = function(i){
			$scope.parkDetail=i;
			};
			$scope.$on('$destroy', function() {
				window.onbeforeunload = undefined;
			});			
	});
	
	app.controller('MapController',function($scope){
		var ins = this;
		this.lat = '';
		this.long = '';
		var mapOptions = {
        zoom: 15,
        center: new google.maps.LatLng(this.lat, this.long),
        mapTypeId: google.maps.MapTypeId.TERRAIN
    };

    this.map = new google.maps.Map(document.getElementById('map'), mapOptions);
	 
	});
	
	app.controller('OtherController',function($scope) {
		$scope.pageChangeHandler = function(num) {
			console.log('going to page ' + num);
		};
	});	
	
	//search whole string. space delimit it. jquery with space return array of strings to compare 
	// 
	
	
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
	
