From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
Date: Fri, 1 Feb 2019 17:44:14 +0900
Message-ID: <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
        <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 19. 1. 31. 오후 5:49, Lukasz Luba wrote:
> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
> Controller frequencies for driver's DRAM timings.
> 
> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
> CC: Chanwoo Choi <cw00.choi@samsung.com>
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: Kukjin Kim <kgene@kernel.org>
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> CC: linux-samsung-soc@vger.kernel.org
> CC: linux-clk@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 3e87421..8bf9579 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1325,6 +1325,19 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
>  	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
>  };
>  
> +static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
> +	PLL_35XX_RATE(24 * MHZ, 933000000, 311, 4, 1),
> +	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
> +	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
> +	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
> +	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
> +	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
> +	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
> +	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
> +	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
> +	PLL_35XX_RATE(24 * MHZ, 138000000, 184, 2, 4),

Except for 825Mhz, I can't find the target frequency
on Exynos5422 TRM document. Usually, Exynos TRM specified
the supported stable clocks. It means that undefined clocks
are not stable as I knew. Where do you find them?

When I calculated the PLL frequency with PMS value, it is correct.
But, just we need to check the reference of undefined clocks on TRM
in order to guarantee the stable operation.

Remove 933/138Mhz because exynos5433-dmc.c doesn't use 933Mhz and 138Mhz
and also Exynos5422 TRM doesn't define 933/138Mhz on pll table.

> +};
> +
>  static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>  	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
>  	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
> @@ -1467,7 +1480,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>  		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>  		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>  		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> -		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> +		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;

Exynos5422 used the same PLL table for apll, kpll, bpll and so on.
You don't need to make the separate pll table. Just add new entries
to exynos5420_pll2550x_24mhz_tbl table.

>  	}
>  
>  	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
