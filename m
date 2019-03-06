From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v5 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
Date: Wed, 6 Mar 2019 10:31:20 +0900
Message-ID: <a35136da-79b1-17fe-3c97-8eb06da39cd6@samsung.com>
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101926eucas1p158d6241bd6851b3d98ed9aae6cba502c@eucas1p1.samsung.com>
        <1551781151-5562-4-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551781151-5562-4-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

I'm talking about it repeatedly. How many times already, I mentioned
that you have to resend the patch after completed the discussion.


I replied this v3 patch[2]. But, you didn't reply or answer anything
and then just send the same patch without any consent.

- Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos 5422 SoC
[2] https://lkml.org/lkml/2019/2/11/198



On 19. 3. 5. 오후 7:19, Lukasz Luba wrote:
> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
> Controller frequencies for driver's DRAM timings.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 6da5875..6f5db70 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1331,6 +1331,17 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
>  	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
>  };
>  
> +static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
> +	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
> +	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
> +	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
> +	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
> +	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
> +	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
> +	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
> +	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
> +};
> +
>  static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>  	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
>  	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
> @@ -1473,7 +1484,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>  		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>  		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>  		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> -		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> +		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
>  	}
>  
>  	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
