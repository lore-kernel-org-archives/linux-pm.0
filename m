From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 3/8] clk: samsung: exynos5420: add cpu clock configuration
 data and instantiate cpu clock
Date: Wed, 22 Apr 2015 10:10:17 +0200
Message-ID: <20150422101017.25c3e53a@amdc2363>
References: <1429622278-12216-1-git-send-email-b.zolnierkie@samsung.com>
 <1429622278-12216-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:41720 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854AbbDVIK3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 04:10:29 -0400
In-reply-to: <1429622278-12216-4-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Kevin Hilman <khilman@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org

Hi Bartlomiej,

> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> With the addition of the new Samsung specific cpu-clock type, the
> arm clock can be represented as a cpu-clock type. Add the CPU clock
> configuration data and instantiate the CPU clock type for Exynos5420.
> 
> Changes by Bartlomiej:
> - split Exynos5420 support from the original patches
> - moved E5420_[EGL,KFC]_DIV0() macros to clk-exynos5420.c
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c   |   58
> ++++++++++++++++++++++++++++++--
> include/dt-bindings/clock/exynos5420.h |    2 ++ 2 files changed, 58
> insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c
> b/drivers/clk/samsung/clk-exynos5420.c index 07d666c..9398a2d 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -19,6 +19,7 @@
>  #include <linux/syscore_ops.h>
>  
>  #include "clk.h"
> +#include "clk-cpu.h"
>  
>  #define APLL_LOCK		0x0
>  #define APLL_CON0		0x100
> @@ -616,9 +617,11 @@ static struct samsung_mux_clock
> exynos5x_mux_clks[] __initdata = { MUX(0, "mout_mspll_kfc",
> mout_mspll_cpu_p, SRC_TOP7, 8, 2), MUX(0, "mout_mspll_cpu",
> mout_mspll_cpu_p, SRC_TOP7, 12, 2), 
> -	MUX(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
> +	MUX_F(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
> +	      CLK_SET_RATE_PARENT, 0),
>  	MUX(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
> -	MUX(0, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1),
> +	MUX_F(0, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1,
> +	      CLK_SET_RATE_PARENT, 0),
>  	MUX(0, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1),
>  
>  	MUX(0, "mout_aclk200", mout_group1_p, SRC_TOP0, 8, 2),
> @@ -1246,6 +1249,50 @@ static struct samsung_pll_clock
> exynos5x_plls[nr_plls] __initdata = { KPLL_CON0, NULL),
>  };
>  
> +#define E5420_EGL_DIV0(apll, pclk_dbg, atb,
> cpud)			\
> +		((((apll) << 24) | ((pclk_dbg) << 20) | ((atb) <<
> 16) |	\
> +		 ((cpud) << 4)))
> +
> +static const struct exynos_cpuclk_cfg_data exynos5420_eglclk_d[]
> __initconst = {
> +	{ 1800000, E5420_EGL_DIV0(3, 7, 7, 4), },
> +	{ 1700000, E5420_EGL_DIV0(3, 7, 7, 3), },
> +	{ 1600000, E5420_EGL_DIV0(3, 7, 7, 3), },
> +	{ 1500000, E5420_EGL_DIV0(3, 7, 7, 3), },
> +	{ 1400000, E5420_EGL_DIV0(3, 7, 7, 3), },
> +	{ 1300000, E5420_EGL_DIV0(3, 7, 7, 2), },
> +	{ 1200000, E5420_EGL_DIV0(3, 7, 7, 2), },
> +	{ 1100000, E5420_EGL_DIV0(3, 7, 7, 2), },
> +	{ 1000000, E5420_EGL_DIV0(3, 6, 6, 2), },
> +	{  900000, E5420_EGL_DIV0(3, 6, 6, 2), },
> +	{  800000, E5420_EGL_DIV0(3, 5, 5, 2), },
> +	{  700000, E5420_EGL_DIV0(3, 5, 5, 2), },
> +	{  600000, E5420_EGL_DIV0(3, 4, 4, 2), },
> +	{  500000, E5420_EGL_DIV0(3, 3, 3, 2), },
> +	{  400000, E5420_EGL_DIV0(3, 3, 3, 2), },
> +	{  300000, E5420_EGL_DIV0(3, 3, 3, 2), },
> +	{  200000, E5420_EGL_DIV0(3, 3, 3, 2), },
> +	{  0 },
> +};
> +
> +#define E5420_KFC_DIV(kpll, pclk,
> aclk)					\
> +		((((kpll) << 24) | ((pclk) << 20) | ((aclk) << 4)))
> +
> +static const struct exynos_cpuclk_cfg_data exynos5420_kfcclk_d[]
> __initconst = {
> +	{ 1300000, E5420_KFC_DIV(3, 5, 2), },
> +	{ 1200000, E5420_KFC_DIV(3, 5, 2), },
> +	{ 1100000, E5420_KFC_DIV(3, 5, 2), },
> +	{ 1000000, E5420_KFC_DIV(3, 5, 2), },
> +	{  900000, E5420_KFC_DIV(3, 5, 2), },
> +	{  800000, E5420_KFC_DIV(3, 5, 2), },
> +	{  700000, E5420_KFC_DIV(3, 4, 2), },
> +	{  600000, E5420_KFC_DIV(3, 4, 2), },
> +	{  500000, E5420_KFC_DIV(3, 4, 2), },
> +	{  400000, E5420_KFC_DIV(3, 3, 2), },
> +	{  300000, E5420_KFC_DIV(3, 3, 2), },
> +	{  200000, E5420_KFC_DIV(3, 3, 2), },
> +	{  0 },
> +};
> +
>  static const struct of_device_id ext_clk_match[] __initconst = {
>  	{ .compatible = "samsung,exynos5420-oscclk", .data = (void
> *)0, }, { },
> @@ -1310,6 +1357,13 @@ static void __init exynos5x_clk_init(struct
> device_node *np, ARRAY_SIZE(exynos5800_gate_clks));
>  	}
>  
> +	exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
> +		mout_cpu_p[0], mout_cpu_p[1], 0x200,
> +		exynos5420_eglclk_d,
> ARRAY_SIZE(exynos5420_eglclk_d), 0);
> +	exynos_register_cpu_clock(ctx, CLK_KFC_CLK, "kfcclk",
> +		mout_kfc_p[0], mout_kfc_p[1], 0x28200,
> +		exynos5420_kfcclk_d,
> ARRAY_SIZE(exynos5420_kfcclk_d), 0); +
>  	exynos5420_clk_sleep_init();
>  
>  	samsung_clk_of_add_provider(np, ctx);
> diff --git a/include/dt-bindings/clock/exynos5420.h
> b/include/dt-bindings/clock/exynos5420.h index 99da0d1..dde9664 100644
> --- a/include/dt-bindings/clock/exynos5420.h
> +++ b/include/dt-bindings/clock/exynos5420.h
> @@ -25,6 +25,8 @@
>  #define CLK_FOUT_MPLL		10
>  #define CLK_FOUT_BPLL		11
>  #define CLK_FOUT_KPLL		12
> +#define CLK_ARM_CLK		13
> +#define CLK_KFC_CLK		14
>  
>  /* gate for special clocks (sclk) */
>  #define CLK_SCLK_UART0		128

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
