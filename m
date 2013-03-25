From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] thermal: db8500: Fix missing mutex_unlock() in
 probe error paths
Date: Mon, 25 Mar 2013 16:09:39 +0800
Message-ID: <1364198979.2465.42.camel@rzhang1-mobl4>
References: <1363102940.3160.2.camel@phoenix>
	 <1363103009.3160.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:54248 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754825Ab3CYIJu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Mar 2013 04:09:50 -0400
In-Reply-To: <1363103009.3160.3.camel@phoenix>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Hongbo Zhang <hongbo.zhang@stericsson.com>, Viresh Kumar <viresh.kumar@linaro.org>, Francesco Lavra <francescolavra.fl@gmail.com>, linux-pm@vger.kernel.org

On Tue, 2013-03-12 at 23:43 +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

applied to thermal -next.

thanks,
rui

> ---
>  drivers/thermal/db8500_thermal.c |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
> index 6bdcec4..1e3b3bf 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
> @@ -419,7 +419,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>  	low_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_LOW");
>  	if (low_irq < 0) {
>  		dev_err(&pdev->dev, "Get IRQ_HOTMON_LOW failed.\n");
> -		return low_irq;
> +		ret = low_irq;
> +		goto out_unlock;
>  	}
>  
>  	ret = devm_request_threaded_irq(&pdev->dev, low_irq, NULL,
> @@ -427,13 +428,14 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>  		"dbx500_temp_low", pzone);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to allocate temp low irq.\n");
> -		return ret;
> +		goto out_unlock;
>  	}
>  
>  	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
>  	if (high_irq < 0) {
>  		dev_err(&pdev->dev, "Get IRQ_HOTMON_HIGH failed.\n");
> -		return high_irq;
> +		ret = high_irq;
> +		goto out_unlock;
>  	}
>  
>  	ret = devm_request_threaded_irq(&pdev->dev, high_irq, NULL,
> @@ -441,7 +443,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>  		"dbx500_temp_high", pzone);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to allocate temp high irq.\n");
> -		return ret;
> +		goto out_unlock;
>  	}
>  
>  	pzone->therm_dev = thermal_zone_device_register("db8500_thermal_zone",
> @@ -449,7 +451,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>  
>  	if (IS_ERR(pzone->therm_dev)) {
>  		dev_err(&pdev->dev, "Register thermal zone device failed.\n");
> -		return PTR_ERR(pzone->therm_dev);
> +		ret = PTR_ERR(pzone->therm_dev);
> +		goto out_unlock;
>  	}
>  	dev_info(&pdev->dev, "Thermal zone device registered.\n");
>  
> @@ -461,9 +464,11 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pzone);
>  	pzone->mode = THERMAL_DEVICE_ENABLED;
> +
> +out_unlock:
>  	mutex_unlock(&pzone->th_lock);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int db8500_thermal_remove(struct platform_device *pdev)


