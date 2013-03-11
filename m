From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: db8500: Fix missing mutex_unlock() in probe
 error paths
Date: Mon, 11 Mar 2013 23:02:14 +0800
Message-ID: <1363014134.2291.86.camel@rzhang1-mobl4>
References: <1362814294.30718.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:21895 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919Ab3CKPCU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Mar 2013 11:02:20 -0400
In-Reply-To: <1362814294.30718.1.camel@phoenix>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Hongbo Zhang <hongbo.zhang@stericsson.com>, Viresh Kumar <viresh.kumar@linaro.org>, Francesco Lavra <francescolavra.fl@gmail.com>, linux-pm@vger.kernel.org

On Sat, 2013-03-09 at 15:31 +0800, Axel Lin wrote:
> Fix missing mutex_unlock() in probe error paths.
> 
> Also fix checking return value of thermal_zone_device_register().
> thermal_zone_device_register() returns ERR_PTR on error, thus use
> IS_ERR rather than IS_ERR_OR_NULL to check return value.
> 
> This patch also includes a few cleanup to remove unnecessary initialization
> for *pzone, *ptrips and ret variables.
> 
well, this patch fixes
1. an important locking issue
2. a misuse of IS_ERR_OR_NULL()
3. several trivial cleanups
And the subject of this patch is misleading.

so why not separate them to three patches instead.

thanks,
rui
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/thermal/db8500_thermal.c |   25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
> index 61ce60a..6344084 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
> @@ -390,10 +390,10 @@ static inline struct db8500_thsens_platform_data*
>  
>  static int db8500_thermal_probe(struct platform_device *pdev)
>  {
> -	struct db8500_thermal_zone *pzone = NULL;
> -	struct db8500_thsens_platform_data *ptrips = NULL;
> +	struct db8500_thermal_zone *pzone;
> +	struct db8500_thsens_platform_data *ptrips;
>  	struct device_node *np = pdev->dev.of_node;
> -	int low_irq, high_irq, ret = 0;
> +	int low_irq, high_irq, ret;
>  	unsigned long dft_low, dft_high;
>  
>  	if (np)
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
> @@ -441,15 +443,16 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>  		"dbx500_temp_high", pzone);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to allocate temp high irq.\n");
> -		return ret;
> +		goto out_unlock;
>  	}
>  
>  	pzone->therm_dev = thermal_zone_device_register("db8500_thermal_zone",
>  		ptrips->num_trips, 0, pzone, &thdev_ops, NULL, 0, 0);
>  
> -	if (IS_ERR_OR_NULL(pzone->therm_dev)) {
> +	if (IS_ERR(pzone->therm_dev)) {
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


