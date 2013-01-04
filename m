From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] thermal: db8500: Use of_match_ptr() macro in
 db8500_thermal.c
Date: Fri, 04 Jan 2013 15:36:38 +0800
Message-ID: <1357284998.2152.4.camel@rzhang1-mobl4>
References: <1355907059-28720-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:1042 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346Ab3ADHgm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Jan 2013 02:36:42 -0500
In-Reply-To: <1355907059-28720-1-git-send-email-sachin.kamat@linaro.org>
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
>  drivers/thermal/db8500_thermal.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
> index ec71ade..61ce60a 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
> @@ -508,15 +508,13 @@ static const struct of_device_id db8500_thermal_match[] = {
>  	{ .compatible = "stericsson,db8500-thermal" },
>  	{},
>  };
> -#else
> -#define db8500_thermal_match NULL
>  #endif
>  
>  static struct platform_driver db8500_thermal_driver = {
>  	.driver = {
>  		.owner = THIS_MODULE,
>  		.name = "db8500-thermal",
> -		.of_match_table = db8500_thermal_match,
> +		.of_match_table = of_match_ptr(db8500_thermal_match),
>  	},
>  	.probe = db8500_thermal_probe,
>  	.suspend = db8500_thermal_suspend,


