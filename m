From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: exynos5440: Fix inconsistent indenting
Date: Thu, 8 Jun 2017 09:17:09 +0530
Message-ID: <20170608034709.GA4634@vireshk-i7>
References: <20170607181324.32199-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36476 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbdFHDrN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 23:47:13 -0400
Received: by mail-pg0-f54.google.com with SMTP id a70so11609310pge.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2017 20:47:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170607181324.32199-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On 07-06-17, 20:13, Krzysztof Kozlowski wrote:
> Fix inconsistent indenting and unneeded white space in assignment.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/cpufreq/exynos5440-cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
> index 9180d34cc9fc..b6b369c22272 100644
> --- a/drivers/cpufreq/exynos5440-cpufreq.c
> +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> @@ -173,12 +173,12 @@ static void exynos_enable_dvfs(unsigned int cur_frequency)
>  	/* Enable PSTATE Change Event */
>  	tmp = __raw_readl(dvfs_info->base + XMU_PMUEVTEN);
>  	tmp |= (1 << PSTATE_CHANGED_EVTEN_SHIFT);
> -	 __raw_writel(tmp, dvfs_info->base + XMU_PMUEVTEN);
> +	__raw_writel(tmp, dvfs_info->base + XMU_PMUEVTEN);
>  
>  	/* Enable PSTATE Change IRQ */
>  	tmp = __raw_readl(dvfs_info->base + XMU_PMUIRQEN);
>  	tmp |= (1 << PSTATE_CHANGED_IRQEN_SHIFT);
> -	 __raw_writel(tmp, dvfs_info->base + XMU_PMUIRQEN);
> +	__raw_writel(tmp, dvfs_info->base + XMU_PMUIRQEN);
>  
>  	/* Set initial performance index */
>  	cpufreq_for_each_entry(pos, freq_table)
> @@ -330,7 +330,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
>  	struct resource res;
>  	unsigned int cur_frequency;
>  
> -	np =  pdev->dev.of_node;
> +	np = pdev->dev.of_node;
>  	if (!np)
>  		return -ENODEV;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
