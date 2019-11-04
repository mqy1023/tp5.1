<?php
/**
 * Created by PhpStorm.
 * User: eric
 * Date: 2019-10-13
 * Time: 16:03
 */

namespace app\common\exception;

use think\Exception;


/**
 * Class BaseException
 * 自定义异常类的基类
 */
class BaseException extends Exception
{
    public $code = 500;
    public $message = 'invalid parameters';
    public $httpCode = 200;

    public function __construct($params=[]) {
        if(!is_array($params)){
            return;
        }
        if(array_key_exists('code',$params)){
            $this->code = $params['code'];
        }
        if(array_key_exists('message',$params)){
            $this->message = $params['message'];
        }
        if(array_key_exists('httpCode',$params)){
            $this->httpCode = $params['httpCode'];
        }
    }
}
