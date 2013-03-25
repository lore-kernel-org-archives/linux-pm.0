From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] thermal: db8500: Fix checking return value of
 thermal_zone_device_register
Date: Mon, 25 Mar 2013 16:09:18 +0800
Message-ID: <1364198958.2465.41.camel@rzhang1-mobl4>
References: <1363102940.3160.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27670 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754825Ab3CYIJW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Mar 2013 04:09:22 -0400
In-Reply-To: <1363102940.3160.2.camel@phoenix>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Hongbo Zhang <hongbo.zhang@stericsson.com>, Viresh Kumar <viresh.kumar@linaro.org>, Francesco Lavra <francescolavra.fl@gmail.com>, linux-pm@vger.kernel.org

On Tue, 2013-03-12 at 23:42 +0800, Axel Lin wrote:
> thermal_zone_device_register() returns ERR_PTR on error, thus use
> IS_ERR rather than IS_ERR_OR_NULL to check return value.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

applied to thermal -next.

thanks,
rui
> ---
>  drivers/thermal/db8500_thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
> index 61ce60a..6bdcec4 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
> @@ -447,7 +447,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>  	pzone->therm_dev = thermal_zone_device_register("db8500_thermal_zone",
>  		ptrips->num_trips, 0, pzone, &thdev_ops, NULL, 0, 0);
>  
> -	if (IS_ERR_OR_NULL(pzone->therm_dev)) {
> +	if (IS_ERR(pzone->therm_dev)) {
>  		dev_err(&pdev->dev, "Register thermal zone device failed.\n");
>  		return PTR_ERR(pzone->therm_dev);
>  	}


