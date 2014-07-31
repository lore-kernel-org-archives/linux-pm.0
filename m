From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v9 6/6] clk: samsung: remove unused clock aliases and
 update clock flags
Date: Thu, 31 Jul 2014 16:13:46 +0200
Message-ID: <53DA4F1A.5040604@gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com> <1406707663-16656-7-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:59557 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbaGaONz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Jul 2014 10:13:55 -0400
In-Reply-To: <1406707663-16656-7-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com

On 30.07.2014 10:07, Thomas Abraham wrote:
> With some of the Exynos SoCs switched over to use the generic CPUfreq drivers,
> the unused clock aliases can be removed. In addition to this, the individual
> clock blocks which are now encapsulated with the consolidate CPU clock type
> can now be marked with read-only flags.

[snip]

> @@ -1500,6 +1499,7 @@ static void __init exynos4_clk_init(struct device_node *np,
>  		exynos4_soc == EXYNOS4210 ? "Exynos4210" : "Exynos4x12",
>  		_get_rate("sclk_apll"),	_get_rate("sclk_mpll"),
>  		_get_rate("sclk_epll"), _get_rate("sclk_vpll"),
> +		exynos4_soc == EXYNOS4210 ? _get_rate("armclk") :
>  		_get_rate("div_core2"));

I believe "div_core2" should work fine here for all SoCs without the
need for this if.

>  }
>  
> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
> index e19e365..1d958f1 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c

[snip]

> @@ -848,6 +851,6 @@ static void __init exynos5250_clk_init(struct device_node *np)
>  	samsung_clk_of_add_provider(np, ctx);
>  
>  	pr_info("Exynos5250: clock setup completed, armclk=%ld\n",
> -			_get_rate("div_arm2"));
> +			_get_rate("armclk"));

Similarly here, no need for this change.

Best regards,
Tomasz
