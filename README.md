# Docker PHP-FPM 7.3 & Nginx 1.16 on Alpine Linux
Example PHP-FPM 7.3 & Nginx 1.16 setup for Docker, build on [Alpine Linux](http://www.alpinelinux.org/).
The image is only +/- 35MB large.

Repository: https://github.com/leyume/apn


* Built on the lightweight and secure Alpine Linux distribution
* Very small Docker image size (+/-35MB)
* Uses PHP 7.3 for better performance, lower cpu usage & memory footprint
* Optimized for 100 concurrent users
* Optimized to only use resources when there's traffic (by using PHP-FPM's ondemand PM)
* The servers Nginx, PHP-FPM and supervisord run under a non-privileged user (nobody) to make it more secure
* The logs of all the services are redirected to the output of the Docker container (visible with `docker logs -f <container name>`)
* Follows the KISS principle (Keep It Simple, Stupid) to make it easy to understand and adjust the image
