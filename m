From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: dt: Create platform device from generic code
Date: Thu, 24 Mar 2016 19:36:00 +0530
Message-ID: <20160324140600.GM22062@vireshk-i7>
References: <cover.1458801338.git.viresh.kumar@linaro.org>
 <5800397.rNERvs0XYE@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32799 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbcCXOGR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 10:06:17 -0400
Received: by mail-pf0-f182.google.com with SMTP id 4so58358063pfd.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Mar 2016 07:06:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5800397.rNERvs0XYE@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, kgene.kim@samsung.com, heiko@sntech.de, xf@rock-chips.com, mmcclint@codeaurora.org, linux-pm@vger.kernel.org

On 24-03-16, 14:36, Arnd Bergmann wrote:
> I've tried implementing something similar when we last discussed it,
> but didn't get far enough to test it our properly, and I had trouble
> integrating some of the more complex platforms (omap, imx, sunxi)
> that have lots of root compatible strings to fit in nicely.
> 
> I think having a lookup table as in your patch 2 makes sense here,
> but I still would prefer not having a device at all. See the patch

We don't have any other option really. The platform-device logic was
added to make -EPROBE-DEFER work :)

> Another idea I had was to make dt_cpufreq_init() a global function
> that can simply be called by platforms that pass non-NULL platform
> data today, avoiding the need for the pdata in a global location.

I think its high time that we kill platform data if we don't care
about old DT compatibility with new kernel for mvebu platform, if it
hasn't gone into product already. We can do everything with opp-v2
now, and pdata doesn't do anything special.

> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index f951f911786e..b3817cc86597 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -356,7 +356,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
>  	.suspend = cpufreq_generic_suspend,
>  };
>  
> -static int dt_cpufreq_probe(struct platform_device *pdev)
> +static int 	(void *data)

dt_cpufreq_init ? :)

>  {
>  	int ret;
>  
> @@ -371,15 +371,22 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
> +	dt_cpufreq_driver.driver_data = data;
>  
>  	ret = cpufreq_register_driver(&dt_cpufreq_driver);
>  	if (ret)
> -		dev_err(&pdev->dev, "failed register driver: %d\n", ret);
> +		pr_err("failed register driver: %d\n", ret);
>  
>  	return ret;
>  }
>  
> +/* a minimal fake platform device for platforms that still call
> + * platform_device_create(). Don't use */
> +static int dt_cpufreq_probe(struct platform_device *pdev)
> +{
> +	return dt_cpufreq_init(dev_get_platdata(&pdev->dev));
> +}
> +
>  static int dt_cpufreq_remove(struct platform_device *pdev)
>  {
>  	cpufreq_unregister_driver(&dt_cpufreq_driver);
> @@ -393,7 +400,24 @@ static struct platform_driver dt_cpufreq_platdrv = {
>  	.probe		= dt_cpufreq_probe,
>  	.remove		= dt_cpufreq_remove,
>  };
> -module_platform_driver(dt_cpufreq_platdrv);
> +
> +static int __init cpufreq_dt_init(void)
> +{
> +	if (of_machine_is_compatible("marvell,berlin"))
> +		return dt_cpufreq_init(NULL);
> +
> +	return platform_driver_register(&dt_cpufreq_platdrv);
> +}
> +module_init(cpufreq_dt_init);
> +
> +static void cpufreq_dt_exit(void)
> +{
> +	if (dt_cpufreq_platdrv.driver.bus)

I didn't like this as well :(

-- 
viresh
