From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq:exynos-cpufreq - Fix for memory leak in case SOC
 name does not match.
Date: Sat, 23 May 2015 10:12:02 +0530
Message-ID: <20150523044202.GA5751@linux>
References: <1432350171-2414-1-git-send-email-shailendra.capricorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34565 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbbEWEmG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 May 2015 00:42:06 -0400
Received: by pabru16 with SMTP id ru16so34203687pab.1
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2015 21:42:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432350171-2414-1-git-send-email-shailendra.capricorn@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On 23-05-15, 08:32, Shailendra Verma wrote:
> During probe free the memory allocated to "exynos_info" in case of
> unknown SOC type.
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> ---
>  drivers/cpufreq/exynos-cpufreq.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> index 82d2fbb..5b57a0f 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -182,20 +182,25 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
>  		ret = exynos5250_cpufreq_init(exynos_info);
>  	} else {
>  		pr_err("%s: Unknown SoC type\n", __func__);
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err_vdd_arm;

Because we are going to check ret again, don't add the goto here. The
below code will take care of this.

>  	}
>  
> -	if (ret)
> +	if (ret) {
> +		ret = -EINVAL;

Why update ret here ?

>  		goto err_vdd_arm;
> +	}
>  
>  	if (exynos_info->set_freq == NULL) {
>  		dev_err(&pdev->dev, "No set_freq function (ERR)\n");
> +		ret = -EINVAL;
>  		goto err_vdd_arm;
>  	}
>  
>  	arm_regulator = regulator_get(NULL, "vdd_arm");
>  	if (IS_ERR(arm_regulator)) {
>  		dev_err(&pdev->dev, "failed to get resource vdd_arm\n");
> +		ret = -EINVAL;
>  		goto err_vdd_arm;
>  	}
>  
> @@ -203,8 +208,10 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
>  	locking_frequency = clk_get_rate(exynos_info->cpu_clk) / 1000;
>  
>  	ret = cpufreq_register_driver(&exynos_driver);
> -	if (ret)
> +	if (ret) {
> +		ret = -EINVAL;

Wrong again.

>  		goto err_cpufreq_reg;
> +	}
>  
>  	cpu0 = of_get_cpu_node(0, NULL);
>  	if (!cpu0) {
> @@ -227,7 +234,7 @@ err_cpufreq_reg:
>  	regulator_put(arm_regulator);
>  err_vdd_arm:
>  	kfree(exynos_info);
> -	return -EINVAL;
> +	return ret;
>  }

-- 
viresh
