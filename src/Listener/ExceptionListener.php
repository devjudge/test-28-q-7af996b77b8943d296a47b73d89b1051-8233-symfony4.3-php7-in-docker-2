<?php

namespace App\Listener;

use App\Http\ApiResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Event\GetResponseForExceptionEvent;
use Symfony\Component\HttpKernel\Exception\HttpExceptionInterface;

class ExceptionListener
{
    /**
     * @param GetResponseForExceptionEvent $event
     */
    public function onKernelException(GetResponseForExceptionEvent $event)
    {
        $exception = $event->getException();

        $response = $this->createApiResponse($exception);
        $event->setResponse($response);
    }
    
    /**
     * Creates the ApiResponse from any Exception
     *
     * @param \Exception $exception
     *
     * @return ApiResponse
     */
    private function createApiResponse(\Exception $exception)
    {
        $statusCode = $exception instanceof HttpExceptionInterface ? $exception->getStatusCode() : Response::HTTP_INTERNAL_SERVER_ERROR;
        $errors     = [];

        return new ApiResponse($exception->getMessage(), null, $errors, $statusCode);
    }
}