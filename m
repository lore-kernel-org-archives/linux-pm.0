From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v7 3/6] clk: exynos: use cpu-clock provider type to represent
 arm clock
Date: Sat, 19 Jul 2014 15:06:44 +0200
Message-ID: <53CA6D64.90908@gmail.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com> <1405345118-4269-4-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:54047 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbaGSNHF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 19 Jul 2014 09:07:05 -0400
In-Reply-To: <1405345118-4269-4-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com

Hi Thomas,

Please see my comments inline.

On 14.07.2014 15:38, Thomas Abraham wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> Register cpu clocks using the new cpu-clock provider type for exynos platforms.
> The differnt clock blocks that are now encapsulated within the cpu-clock can be
> marked with read-only attribute.
> 
> Cc: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Tested-by: Arjun K.V <arjun.kv@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c      |   25 +++++++++++++++++--------
>  drivers/clk/samsung/clk-exynos5250.c   |   16 +++++++++++-----
>  drivers/clk/samsung/clk-exynos5420.c   |   32 +++++++++++++++++++++++---------
>  include/dt-bindings/clock/exynos5250.h |    1 +
>  include/dt-bindings/clock/exynos5420.h |    2 ++
>  5 files changed, 54 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
> index 75573a4..10f1818 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -471,7 +471,8 @@ static struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
>  	MUX(0, "mout_fimd1", group1_p4210, E4210_SRC_LCD1, 0, 4),
>  	MUX(0, "mout_mipi1", group1_p4210, E4210_SRC_LCD1, 12, 4),
>  	MUX(CLK_SCLK_MPLL, "sclk_mpll", mout_mpll_p, SRC_CPU, 8, 1),
> -	MUX(CLK_MOUT_CORE, "mout_core", mout_core_p4210, SRC_CPU, 16, 1),
> +	MUX_F(CLK_MOUT_CORE, "mout_core", mout_core_p4210, SRC_CPU, 16, 1, 0,
> +			CLK_MUX_READ_ONLY),
>  	MUX(CLK_SCLK_VPLL, "sclk_vpll", sclk_vpll_p4210, SRC_TOP0, 8, 1),
>  	MUX(CLK_MOUT_FIMC0, "mout_fimc0", group1_p4210, SRC_CAM, 0, 4),
>  	MUX(CLK_MOUT_FIMC1, "mout_fimc1", group1_p4210, SRC_CAM, 4, 4),
> @@ -530,7 +531,8 @@ static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
>  	MUX(0, "mout_jpeg", mout_jpeg_p, E4X12_SRC_CAM1, 8, 1),
>  	MUX(CLK_SCLK_MPLL, "sclk_mpll", mout_mpll_p, SRC_DMC, 12, 1),
>  	MUX(CLK_SCLK_VPLL, "sclk_vpll", mout_vpll_p, SRC_TOP0, 8, 1),
> -	MUX(CLK_MOUT_CORE, "mout_core", mout_core_p4x12, SRC_CPU, 16, 1),
> +	MUX_F(CLK_MOUT_CORE, "mout_core", mout_core_p4x12, SRC_CPU, 16, 1, 0,
> +			CLK_MUX_READ_ONLY),
>  	MUX(CLK_MOUT_FIMC0, "mout_fimc0", group1_p4x12, SRC_CAM, 0, 4),
>  	MUX(CLK_MOUT_FIMC1, "mout_fimc1", group1_p4x12, SRC_CAM, 4, 4),
>  	MUX(CLK_MOUT_FIMC2, "mout_fimc2", group1_p4x12, SRC_CAM, 8, 4),
> @@ -572,8 +574,10 @@ static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
>  
>  /* list of divider clocks supported in all exynos4 soc's */
>  static struct samsung_div_clock exynos4_div_clks[] __initdata = {
> -	DIV(0, "div_core", "mout_core", DIV_CPU0, 0, 3),
> -	DIV(0, "div_core2", "div_core", DIV_CPU0, 28, 3),
> +	DIV_F(0, "div_core", "mout_core", DIV_CPU0, 0, 3,
> +			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
> +	DIV_F(0, "div_core2", "div_core", DIV_CPU0, 28, 3,
> +			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
>  	DIV(0, "div_fimc0", "mout_fimc0", DIV_CAM, 0, 4),
>  	DIV(0, "div_fimc1", "mout_fimc1", DIV_CAM, 4, 4),
>  	DIV(0, "div_fimc2", "mout_fimc2", DIV_CAM, 8, 4),
> @@ -619,8 +623,10 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
>  	DIV(0, "div_spi_pre2", "div_spi2", DIV_PERIL2, 8, 8),
>  	DIV(0, "div_audio1", "mout_audio1", DIV_PERIL4, 0, 4),
>  	DIV(0, "div_audio2", "mout_audio2", DIV_PERIL4, 16, 4),
> -	DIV(CLK_ARM_CLK, "arm_clk", "div_core2", DIV_CPU0, 28, 3),
> -	DIV(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
> +	DIV_F(CLK_ARM_CLK, "arm_clk", "div_core2", DIV_CPU0, 28, 3,
> +			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
> +	DIV_F(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3,
> +			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
>  	DIV_F(0, "div_mipi_pre0", "div_mipi0", DIV_LCD0, 20, 4,
>  			CLK_SET_RATE_PARENT, 0),
>  	DIV_F(0, "div_mmc_pre0", "div_mmc0", DIV_FSYS1, 8, 8,
> @@ -1016,7 +1022,6 @@ static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
>  
>  static struct samsung_clock_alias exynos4_aliases[] __initdata = {
>  	ALIAS(CLK_MOUT_CORE, NULL, "moutcore"),
> -	ALIAS(CLK_ARM_CLK, NULL, "armclk"),
>  	ALIAS(CLK_SCLK_APLL, NULL, "mout_apll"),
>  };

These aliases are used only by the old cpufreq driver. If we are
removing support for it, we should also drop them.

However I wonder if we shouldn't rather initially allow both drivers to
coexist with the old still being the default for one release. We want to
avoid regressions so we should first test the new driver for a while and
then, if it proves to be fine, we could drop the old one.

This would probably mean some ifdefs in clock drivers until the old
driver gets removed, but I don't think it's a problem.

>  
> @@ -1255,6 +1260,8 @@ static void __init exynos4_clk_init(struct device_node *np,
>  			ARRAY_SIZE(exynos4210_gate_clks));
>  		samsung_clk_register_alias(ctx, exynos4210_aliases,
>  			ARRAY_SIZE(exynos4210_aliases));
> +		exynos_register_cpu_clock(ctx, 0, CLK_ARM_CLK, "armclk",
> +			mout_core_p4210[0], mout_core_p4210[1], np);
>  	} else {
>  		samsung_clk_register_mux(ctx, exynos4x12_mux_clks,
>  			ARRAY_SIZE(exynos4x12_mux_clks));
> @@ -1264,6 +1271,8 @@ static void __init exynos4_clk_init(struct device_node *np,
>  			ARRAY_SIZE(exynos4x12_gate_clks));
>  		samsung_clk_register_alias(ctx, exynos4x12_aliases,
>  			ARRAY_SIZE(exynos4x12_aliases));
> +		exynos_register_cpu_clock(ctx, 0, CLK_ARM_CLK, "armclk",
> +			mout_core_p4x12[0], mout_core_p4x12[1], np);
>  	}
>  
>  	samsung_clk_register_alias(ctx, exynos4_aliases,
> @@ -1278,7 +1287,7 @@ static void __init exynos4_clk_init(struct device_node *np,
>  		exynos4_soc == EXYNOS4210 ? "Exynos4210" : "Exynos4x12",
>  		_get_rate("sclk_apll"),	_get_rate("sclk_mpll"),
>  		_get_rate("sclk_epll"), _get_rate("sclk_vpll"),
> -		_get_rate("arm_clk"));
> +		_get_rate("armclk"));
>  }
>  
>  
> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
> index 5861183..2f78bb0 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -292,7 +292,8 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
>  	 */
>  	MUX_FA(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
>  					CLK_SET_RATE_PARENT, 0, "mout_apll"),
> -	MUX_A(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1, "mout_cpu"),
> +	MUX_FA(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1,
> +			0, CLK_MUX_READ_ONLY, "mout_cpu"),
>  

Similar comment about aliases here and for few clocks below.

Otherwise the patch looks fine.

Best regards,
Tomasz
