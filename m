From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/5] thermal: int340x_thermal: int3400_thermal: simplify
 getting .driver_data
Date: Mon, 5 Nov 2018 16:04:17 +0100
Message-ID: <6a8727da-66d6-8be2-6fd0-ad0984f819d9@linaro.org>
References: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
 <20181021200053.2194-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021200053.2194-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 21/10/2018 22:00, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> 
> Build tested only. buildbot is happy.
> 
>  drivers/thermal/int340x_thermal/int3400_thermal.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
> index e26b01c05e82..61ca7ce3624e 100644
> --- a/drivers/thermal/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
> @@ -48,8 +48,7 @@ static ssize_t available_uuids_show(struct device *dev,
>  				    struct device_attribute *attr,
>  				    char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
> +	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
>  	int i;
>  	int length = 0;
>  
> @@ -68,8 +67,7 @@ static ssize_t available_uuids_show(struct device *dev,
>  static ssize_t current_uuid_show(struct device *dev,
>  				 struct device_attribute *devattr, char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
> +	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
>  
>  	if (priv->uuid_bitmap & (1 << priv->current_uuid_index))
>  		return sprintf(buf, "%s\n",
> @@ -82,8 +80,7 @@ static ssize_t current_uuid_store(struct device *dev,
>  				  struct device_attribute *attr,
>  				  const char *buf, size_t count)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
> +	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
>  	int i;
>  
>  	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; ++i) {
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
