From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 4/7] clk: samsung: exynos4x12: add cpu clock
 configuration data and instantiate cpu clock
Date: Fri, 10 Jul 2015 17:30:38 +0900
Message-ID: <559F82AE.8070108@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-5-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:10639 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbbGJIal (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2015 04:30:41 -0400
In-reply-to: <1436456621-29839-5-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 10.07.2015 00:43, Bartlomiej Zolnierkiewicz wrote:
> With the addition of the new Samsung specific cpu-clock type, the
> arm clock can be represented as a cpu-clock type. Add the CPU clock
> configuration data and instantiate the CPU clock type for Exynos4x12.
> 
> Based on the earlier work by Thomas Abraham.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c | 50 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
> index cae2c048..3071260 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -1396,6 +1396,45 @@ static const struct exynos_cpuclk_cfg_data e4210_armclk_d[] __initconst = {
>  	{  0 },
>  };
>  
> +static const struct exynos_cpuclk_cfg_data e4212_armclk_d[] __initconst = {
> +	{ 1500000, E4210_CPU_DIV0(2, 1, 6, 0, 7, 3), E4210_CPU_DIV1(2, 6), },
> +	{ 1400000, E4210_CPU_DIV0(2, 1, 6, 0, 7, 3), E4210_CPU_DIV1(2, 6), },
> +	{ 1300000, E4210_CPU_DIV0(2, 1, 5, 0, 7, 3), E4210_CPU_DIV1(2, 5), },
> +	{ 1200000, E4210_CPU_DIV0(2, 1, 5, 0, 7, 3), E4210_CPU_DIV1(2, 5), },
> +	{ 1100000, E4210_CPU_DIV0(2, 1, 4, 0, 6, 3), E4210_CPU_DIV1(2, 4), },
> +	{ 1000000, E4210_CPU_DIV0(1, 1, 4, 0, 5, 2), E4210_CPU_DIV1(2, 4), },
> +	{  900000, E4210_CPU_DIV0(1, 1, 3, 0, 5, 2), E4210_CPU_DIV1(2, 3), },
> +	{  800000, E4210_CPU_DIV0(1, 1, 3, 0, 5, 2), E4210_CPU_DIV1(2, 3), },
> +	{  700000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
> +	{  600000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
> +	{  500000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
> +	{  400000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
> +	{  300000, E4210_CPU_DIV0(1, 1, 2, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
> +	{  200000, E4210_CPU_DIV0(1, 1, 1, 0, 3, 1), E4210_CPU_DIV1(2, 3), },
> +	{  0 },
> +};
> +
> +#define E4412_CPU_DIV1(cores, hpm, copy)				\
> +		(((cores) << 8) | ((hpm) << 4) | ((copy) << 0))
> +
> +static const struct exynos_cpuclk_cfg_data e4412_armclk_d[] __initconst = {
> +	{ 1500000, E4210_CPU_DIV0(2, 1, 6, 0, 7, 3), E4412_CPU_DIV1(7, 0, 6), },
> +	{ 1400000, E4210_CPU_DIV0(2, 1, 6, 0, 7, 3), E4412_CPU_DIV1(6, 0, 6), },
> +	{ 1300000, E4210_CPU_DIV0(2, 1, 5, 0, 7, 3), E4412_CPU_DIV1(6, 0, 5), },
> +	{ 1200000, E4210_CPU_DIV0(2, 1, 5, 0, 7, 3), E4412_CPU_DIV1(5, 0, 5), },
> +	{ 1100000, E4210_CPU_DIV0(2, 1, 4, 0, 6, 3), E4412_CPU_DIV1(5, 0, 4), },
> +	{ 1000000, E4210_CPU_DIV0(1, 1, 4, 0, 5, 2), E4412_CPU_DIV1(4, 0, 4), },
> +	{  900000, E4210_CPU_DIV0(1, 1, 3, 0, 5, 2), E4412_CPU_DIV1(4, 0, 3), },
> +	{  800000, E4210_CPU_DIV0(1, 1, 3, 0, 5, 2), E4412_CPU_DIV1(3, 0, 3), },
> +	{  700000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4412_CPU_DIV1(3, 0, 3), },
> +	{  600000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4412_CPU_DIV1(2, 0, 3), },
> +	{  500000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4412_CPU_DIV1(2, 0, 3), },
> +	{  400000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4412_CPU_DIV1(1, 0, 3), },
> +	{  300000, E4210_CPU_DIV0(1, 1, 2, 0, 4, 2), E4412_CPU_DIV1(1, 0, 3), },
> +	{  200000, E4210_CPU_DIV0(1, 1, 1, 0, 3, 1), E4412_CPU_DIV1(0, 0, 3), },
> +	{  0 },
> +};

Numbers look fine!

> +
>  /* register exynos4 clocks */
>  static void __init exynos4_clk_init(struct device_node *np,
>  				    enum exynos4_soc soc)
> @@ -1489,6 +1528,17 @@ static void __init exynos4_clk_init(struct device_node *np,
>  		samsung_clk_register_fixed_factor(ctx,
>  			exynos4x12_fixed_factor_clks,
>  			ARRAY_SIZE(exynos4x12_fixed_factor_clks));
> +		if (of_machine_is_compatible("samsung,exynos4412")) {

The driver uses here enum exynos4_soc to differentiate between SoC
(unless I missed some changes). This of_machine_is_compatible() makes
sense but introduces inconsistency. I would prefer sticking to one
convention: always enum or switch everything (before this patch) to
of_compatible.

Best regards,
Krzysztof


> +			exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
> +				mout_core_p4x12[0], mout_core_p4x12[1], 0x14200,
> +				e4412_armclk_d, ARRAY_SIZE(e4412_armclk_d),
> +				CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1);
> +		} else {
> +			exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
> +				mout_core_p4x12[0], mout_core_p4x12[1], 0x14200,
> +				e4212_armclk_d, ARRAY_SIZE(e4212_armclk_d),
> +				CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1);
> +		}
>  	}
>  
>  	samsung_clk_register_alias(ctx, exynos4_aliases,
> 

