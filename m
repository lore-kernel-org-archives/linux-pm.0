From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq:exynos-cpufreq - Fix for memory leak in case SOC
 name does not match.
Date: Mon, 25 May 2015 13:01:49 +0530
Message-ID: <20150525073149.GF9992@linux>
References: <1432519780-2910-1-git-send-email-shailendra.capricorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36414 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbEYHbx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2015 03:31:53 -0400
Received: by pdfh10 with SMTP id h10so64447650pdf.3
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2015 00:31:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432519780-2910-1-git-send-email-shailendra.capricorn@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On 25-05-15, 07:39, Shailendra Verma wrote:
> During probe free the memory allocated to "exynos_info" in case of
> unknown SOC type.
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> ---
>  drivers/cpufreq/exynos-cpufreq.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> index 82d2fbb..8682378 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -182,7 +182,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
>  		ret = exynos5250_cpufreq_init(exynos_info);
>  	} else {
>  		pr_err("%s: Unknown SoC type\n", __func__);
> -		return -ENODEV;
> +		ret = -ENODEV;
>  	}
>  
>  	if (ret)
> @@ -190,12 +190,14 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
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
> @@ -227,7 +229,7 @@ err_cpufreq_reg:
>  	regulator_put(arm_regulator);
>  err_vdd_arm:
>  	kfree(exynos_info);
> -	return -EINVAL;
> +	return ret;
>  }
>  
>  static struct platform_driver exynos_cpufreq_platdrv = {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
