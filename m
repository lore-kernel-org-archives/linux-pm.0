From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] thermal: db8500: Use of_match_ptr() macro in
 db8500_cpufreq_cooling.c
Date: Fri, 04 Jan 2013 15:36:14 +0800
Message-ID: <1357284974.2152.3.camel@rzhang1-mobl4>
References: <1355907059-28720-1-git-send-email-sachin.kamat@linaro.org>
	 <1355907059-28720-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37294 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346Ab3ADHgS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Jan 2013 02:36:18 -0500
In-Reply-To: <1355907059-28720-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, hongbo.zhang@linaro.org, patches@linaro.org, Hongbo Zhang <hongbo.zhang@stericsson.com>

On Wed, 2012-12-19 at 14:20 +0530, Sachin Kamat wrote:
> This eliminates having an #ifdef returning NULL for the case
> when OF is disabled.
> 
> Cc: Hongbo Zhang <hongbo.zhang@stericsson.com>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

applied to thermal-next.

thanks,
rui

> ---
> Compile tested on linux-next.
> ---
>  drivers/thermal/db8500_cpufreq_cooling.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/db8500_cpufreq_cooling.c b/drivers/thermal/db8500_cpufreq_cooling.c
> index 4cf8e72..2141985 100644
> --- a/drivers/thermal/db8500_cpufreq_cooling.c
> +++ b/drivers/thermal/db8500_cpufreq_cooling.c
> @@ -21,6 +21,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> @@ -73,15 +74,13 @@ static const struct of_device_id db8500_cpufreq_cooling_match[] = {
>  	{ .compatible = "stericsson,db8500-cpufreq-cooling" },
>  	{},
>  };
> -#else
> -#define db8500_cpufreq_cooling_match NULL
>  #endif
>  
>  static struct platform_driver db8500_cpufreq_cooling_driver = {
>  	.driver = {
>  		.owner = THIS_MODULE,
>  		.name = "db8500-cpufreq-cooling",
> -		.of_match_table = db8500_cpufreq_cooling_match,
> +		.of_match_table = of_match_ptr(db8500_cpufreq_cooling_match),
>  	},
>  	.probe = db8500_cpufreq_cooling_probe,
>  	.suspend = db8500_cpufreq_cooling_suspend,


