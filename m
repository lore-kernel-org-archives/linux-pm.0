From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH v7 07/16] clk: tegra: Save/restore CCLKG_BURST_POLICY on
 suspend
Date: Thu, 12 Feb 2015 16:24:40 +0200
Message-ID: <20150212142440.GL20811@tbergstrom-lnx.Nvidia.com>
References: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi>
 <1420723339-30735-8-git-send-email-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7990 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048AbbBLOZE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Feb 2015 09:25:04 -0500
Content-Disposition: inline
In-Reply-To: <1420723339-30735-8-git-send-email-mikko.perttunen@kapsi.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Tuomas Tynkkynen <ttynkkynen@nvidia.com>

On Thu, Jan 08, 2015 at 03:22:10PM +0200, Mikko Perttunen wrote:
> From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> 
> Save and restore this register since the LP1 restore assembly routines
> fiddle with it. Otherwise the CPU would keep running on PLLX after
> resume from suspend even when DFLL was the original clocksource.
> 
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

> ---
>  drivers/clk/tegra/clk-tegra124.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
> index 623b77f..9354c42 100644
> --- a/drivers/clk/tegra/clk-tegra124.c
> +++ b/drivers/clk/tegra/clk-tegra124.c
> @@ -89,6 +89,8 @@
>  #define PMC_PLLM_WB0_OVERRIDE 0x1dc
>  #define PMC_PLLM_WB0_OVERRIDE_2 0x2b0
>  
> +#define CCLKG_BURST_POLICY 0x368
> +
>  #define UTMIP_PLL_CFG2 0x488
>  #define UTMIP_PLL_CFG2_STABLE_COUNT(x) (((x) & 0xffff) << 6)
>  #define UTMIP_PLL_CFG2_ACTIVE_DLY_COUNT(x) (((x) & 0x3f) << 18)
> @@ -121,6 +123,8 @@
>  #ifdef CONFIG_PM_SLEEP
>  static struct cpu_clk_suspend_context {
>  	u32 clk_csite_src;
> +	u32 cclkg_burst;
> +	u32 cclkg_divider;
>  } tegra124_cpu_clk_sctx;
>  #endif
>  
> @@ -1331,12 +1335,22 @@ static void tegra124_cpu_clock_suspend(void)
>  	tegra124_cpu_clk_sctx.clk_csite_src =
>  				readl(clk_base + CLK_SOURCE_CSITE);
>  	writel(3 << 30, clk_base + CLK_SOURCE_CSITE);
> +
> +	tegra124_cpu_clk_sctx.cclkg_burst =
> +				readl(clk_base + CCLKG_BURST_POLICY);
> +	tegra124_cpu_clk_sctx.cclkg_divider =
> +				readl(clk_base + CCLKG_BURST_POLICY + 4);
>  }
>  
>  static void tegra124_cpu_clock_resume(void)
>  {
>  	writel(tegra124_cpu_clk_sctx.clk_csite_src,
>  				clk_base + CLK_SOURCE_CSITE);
> +
> +	writel(tegra124_cpu_clk_sctx.cclkg_burst,
> +					clk_base + CCLKG_BURST_POLICY);
> +	writel(tegra124_cpu_clk_sctx.cclkg_divider,
> +					clk_base + CCLKG_BURST_POLICY + 4);
>  }
>  #endif
>  
> -- 
> 2.2.1
> 
