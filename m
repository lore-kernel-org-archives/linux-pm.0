From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/5] cpufreq: Loongson1: Replace goto out with return in
 ls1x_cpufreq_probe()
Date: Tue, 12 Apr 2016 10:54:17 +0530
Message-ID: <20160412052417.GS16238@vireshk-i7>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
 <1460375759-20705-5-git-send-email-keguang.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32864 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbcDLFYY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 01:24:24 -0400
Received: by mail-pf0-f177.google.com with SMTP id 184so6814847pff.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2016 22:24:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1460375759-20705-5-git-send-email-keguang.zhang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 11-04-16, 19:55, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch replaces goto out with return in ls1x_cpufreq_probe(),
> and also includes some minor fixes.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  drivers/cpufreq/loongson1-cpufreq.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
> index 5074f5e..1bc90af 100644
> --- a/drivers/cpufreq/loongson1-cpufreq.c
> +++ b/drivers/cpufreq/loongson1-cpufreq.c
> @@ -1,7 +1,7 @@
>  /*
>   * CPU Frequency Scaling for Loongson 1 SoC
>   *
> - * Copyright (C) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
> + * Copyright (C) 2014-2016 Zhang, Keguang <keguang.zhang@gmail.com>

Actually you should fold above into the first patch of the series,
that renames this file. It makes much sense that way.

>   *
>   * This file is licensed under the terms of the GNU General Public
>   * License version 2. This program is licensed "as is" without any
> @@ -141,7 +141,8 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
>  	struct clk *clk;
>  	int ret;
>  
> -	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name)
> +	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name) {

You added a '{' here, but the closing '}' is added way down..
Something is wrong here I feel..

> +		dev_err(&pdev->dev, "platform data missing\n");
>  		return -EINVAL;
>  
>  	cpufreq =
> @@ -155,8 +156,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
>  	if (IS_ERR(clk)) {
>  		dev_err(&pdev->dev, "unable to get %s clock\n",
>  			pdata->clk_name);
> -		ret = PTR_ERR(clk);
> -		goto out;
> +		return PTR_ERR(clk);
>  	}

>  static struct platform_driver ls1x_cpufreq_platdrv = {
> -	.driver = {
> +	.probe	= ls1x_cpufreq_probe,
> +	.remove	= ls1x_cpufreq_remove,
> +	.driver	= {
>  		.name	= "ls1x-cpufreq",
>  	},
> -	.probe		= ls1x_cpufreq_probe,
> -	.remove		= ls1x_cpufreq_remove,

Why do this change at all? Do it in the first patch if you really want
to.

>  };
>  
>  module_platform_driver(ls1x_cpufreq_platdrv);
>  
>  MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
> -MODULE_DESCRIPTION("Loongson 1 CPUFreq driver");
> +MODULE_DESCRIPTION("Loongson1 CPUFreq driver");

This one as well, move it to the first patch.

>  MODULE_LICENSE("GPL");
> -- 
> 1.9.1

-- 
viresh
