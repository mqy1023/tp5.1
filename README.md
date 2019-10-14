
##### 一、开发规范
[开发规范](https://www.kancloud.cn/zhanghongbean/tp51_bbs/1303152)

##### 二、配置信息
* 1、在项目根目录创建 .env，配置环境
```
[APP]
NAME=ThinkBBS
HOST=bbs.test
DEBUG=true
TRACE=true

[DB]
HOST=localhost
NAME=think_bbs
USERNAME=homestead
PASSWORD=secret
PORT=3306
PREFIX=bbs_
```
* 2、框架提供的助手函数 env() 是用来读取环境变量的，所以我们接下来使用该方法把 config/app.php 和 config/database.php 里的配置值改成读取以上配置信息。
项目配置：`config/app.php`
```
<?php
return [
// 应用名称
'app_name'               => env('app.name', 'theScoreONE'),
// 应用地址
'app_host'               => env('app.host', 'http://bbs.test'),
// 应用调试模式
'app_debug'              => env('app.debug', false),
// 应用Trace
'app_trace'              => env('app.trace', false),
.
.
```
* 3、数据库配置：`config/database.php`
```
<?php
return [
// 数据库类型
'type'            => 'mysql',
// 服务器地址
'hostname'        => env('db.host', '127.0.0.1'),
// 数据库名
'database'        => env('db.name', ''),
// 用户名
.
.
```
##### 三、验证器Validate
* 1、验证类的基类：`app\api\validate\BaseValidate` 

* 2、继承基类创建新的验证类：`app\api\validate\IDMustBePositiveInt`

* 3、自定义验证规则
```php
protected function isPositiveInteger($value, $rule='', $data='', $field='')
{
    if (is_numeric($value) && is_int($value + 0) && ($value + 0) > 0) {
        return true;
    }
    return $field . '必须是正整数';
}
```

* 4、独立验证器的使用
```php
$validate = new IDMustBePositiveInt();
$validate->goCheck();
```

##### 四、AOP和全局异常处理

* 1、自定义异常类的基类：`app\common\exception\BaseException`

* 2、重写Handle的render方法，实现自定义异常消息：`app\common\exception\ExceptionHandler`

* 3、修改默认的配置，`config\app.php`配置文件
```php
// 异常处理handle类 留空使用 \think\exception\Handle
'exception_handle'       => '\app\common\exception\ExceptionHandler',
```

* 4、继承`BaseException`异常基类创建新的异常类
```php
/**
 * Class ParameterException
 * 通用参数类异常错误
 */
class ParameterException extends BaseException
{
    public $code = 0;
    public $message = 'invalid parameters';
    public $httpCode = 500;

}
```

* 5、使用自定义异常
```php
// 抛出一个自定义异常
throw new ParameterException('参数中包含有非法的参数名user_id或者uid');
```