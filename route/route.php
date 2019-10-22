<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

Route::get('think', function () {
    return 'hello,ThinkPHP5!';
});

Route::get('api/:version/banner', 'api/:version.Banner/getBanner');

// Token
Route::post('api/:version/token/user', 'api/:version.Token/getToken');
Route::post('api/:version/token/verify', 'api/:version.Token/verifyToken');

// product
//Route::get('api/:version/product/:id', 'api/:version.Product/getOne');
Route::get('api/:version/product/:id', 'api/:version.Product/getOne',[],['id'=>'\d+']);
Route::get('api/:version/product/recent', 'api/:version.Product/getRecent');

//Address
Route::group('api/:version/address',function(){
    Route::get('', 'api/:version.Address/getUserAllAddress');
    Route::post('', 'api/:version.Address/createOrUpdateAddress');
    Route::get('/default', 'api/:version.Address/getUserDefaultAddress');
    Route::delete(':id', 'api/:version.Address/deleteAddress');
});

Route::get('api/:version/category', 'api/:version.Category/getCategory');



return [

];
