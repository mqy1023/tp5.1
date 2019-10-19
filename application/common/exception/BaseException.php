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

    public function __construct($message = '', $code = 500, $httpCode = 200) {
        $this->message = $message;
        $this->code = $code;
        $this->httpCode = $httpCode;
    }
}
