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

// token
Route::post('api/:version/token/user', 'api/:version.Token/getToken');
Route::post('api/:version/token/verify', 'api/:version.Token/verifyToken');

// product
//Route::get('api/:version/product/:id', 'api/:version.Product/getOne');
Route::get('api/:version/product/:id', 'api/:version.Product/getOne', [], ['id' => '\d+']);
Route::get('api/:version/product/recent', 'api/:version.Product/getRecent');

// address
Route::group('api/:version/address', function () {
    Route::get('', 'api/:version.Address/getUserAllAddress');
    Route::post('', 'api/:version.Address/createOrUpdateAddress');
    Route::get('/default', 'api/:version.Address/getUserDefaultAddress');
    Route::delete(':id', 'api/:version.Address/deleteAddress');
});


// category
Route::group('api/:version/category', function () {
    Route::get('/tree', 'api/:version.Category/getCategoryTree');
    Route::get('/all', 'api/:version.Category/getCategoryAll');
    Route::post('', 'api/:version.Category/createOrUpdateCategory');
});


/**
 * 免权限验证路由
 */
Route::group('admin', [
    'login$'=>'admin/Login/login',                                         //登录
    'editPassword'=>'admin/User/editPassword',                             //重置密码
    'logout$'=>'admin/Login/logout',                                       //退出
    'check$'=>'admin/User/check',                                          //验证用户是否存在
    'unlock'=>'admin/Login/unlock',                                        //验证用户是否存在
    'verify'=>'admin/Login/verify',                                        //获取验证码
])->ext('html');


/**
 * 需要权限验证路由
 */
Route::group('admin', [

    //首页
    'index$'=>'admin/Index/index',                                           //首页
    'home'=>'admin/Index/home',                                              //系统信息

    //用户管理
    'userList$'=>'admin/User/userList',                                      //用户列表
    'userInfo$'=>'admin/User/userInfo',                                      //用户信息
    'edit$'=>'admin/User/edit',                                              //添加/编辑用户
    'delete$'=>'admin/User/delete',                                          //删除用户
    'groupList$'=>'admin/User/groupList',                                    //用户组列表
    'editGroup$'=>'admin/User/editGroup',                                    //添加编辑用户组
    'disableGroup$'=>'admin/User/disableGroup',                              //禁用用户组
    'ruleList$'=>'admin/User/ruleList',                                      //用户组规则列表
    'editRule$'=>'admin/User/editRule',                                      //修改用户组规则

    //系统管理
    'cleanCache$'=>'admin/System/cleanCache',                                //清除缓存
    'log$'=>'admin/System/loginLog',                                         //登录日志
    'downlog$'=>'admin/System/downLoginLog',                                 //下载登录日志
    'menu$'=>'admin/System/menu',                                            //系统菜单
    'editMenu$'=>'admin/System/editMenu',                                    //编辑菜单
    'deleteMenu$'=>'admin/System/deleteMenu',                                //删除菜单
    'config'=>'admin/System/config',                                         //系统配置
    'siteConfig'=>'admin/System/siteConfig',                                 //站点配置
    'noticeConfig'=>'admin/System/noticeConfig',                             //公告配置
    //上传管理
    'upload'=>'admin/Upload/index',                                    //上传图片
])->middleware(app\admin\middleware\CheckAuth::class)->ext('html');          //使用中间件验证

return [

];
