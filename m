From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 7/7] cpufreq: dt: Remove support for Exynos4212 SoCs
Date: Wed, 4 Oct 2017 12:16:29 +0530
Message-ID: <20171004064629.GB3002@vireshk-i7>
References: <20171004063828.22068-1-m.szyprowski@samsung.com>
 <CGME20171004063837eucas1p2a2c9dbc268fbb37da5253c329a0a8683@eucas1p2.samsung.com>
 <20171004063828.22068-8-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:46145 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdJDGqc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2017 02:46:32 -0400
Received: by mail-pf0-f171.google.com with SMTP id r68so5811929pfj.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Oct 2017 23:46:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171004063828.22068-8-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 04-10-17, 08:38, Marek Szyprowski wrote:
> Support for Exynos4212 SoCs has been removed by commit bca9085e0ae9 ("ARM:
> dts: exynos: remove Exynos4212 support (dead code)"), so there is no need
> to keep remaining dead code related to this SoC version.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index a753c50e9e41..4946ac528b72 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -48,7 +48,6 @@ static const struct of_device_id whitelist[] __initconst = {
>  
>  	{ .compatible = "samsung,exynos3250", },
>  	{ .compatible = "samsung,exynos4210", },
> -	{ .compatible = "samsung,exynos4212", },
>  	{ .compatible = "samsung,exynos5250", },
>  #ifndef CONFIG_BL_SWITCHER
>  	{ .compatible = "samsung,exynos5800", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
