From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v6 03/10] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
Date: Thu, 2 May 2019 16:23:04 +0200
Message-ID: <e280645a-3a7a-5bec-6372-5b46996a7a47@partner.samsung.com>
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141943eucas1p220d77bacfc4fcba8ec6a10f540e1a27d@eucas1p2.samsung.com>
        <1555683568-20882-4-git-send-email-l.luba@partner.samsung.com>
        <62f85c18-d3ac-3425-8ee3-538f8c677603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <62f85c18-d3ac-3425-8ee3-538f8c677603@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 5/2/19 7:15 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 4. 19. 오후 11:19, Lukasz Luba wrote:
>> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
>> Controller frequencies for driver's DRAM timings.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index d9e6653..ddee8bd 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -1323,6 +1323,17 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
>>   	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
>>   };
>>   
>> +static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
>> +	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
>> +	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
>> +	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
>> +	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
>> +	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
>> +	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
>> +	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
>> +	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
>> +};
>> +
>>   static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>>   	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
>>   	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
>> @@ -1465,7 +1476,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>>   		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>   		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>>   		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>> -		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>> +		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
> 
> According to your previous reply, the released odroid-xu3 board by hardkernel
> might be only CONFIG_SOC_EXYNOS5422_REV_0. Because the kernel configurattion
> from hardkernel has 'CONFIG_SOC_EXYNOS5422_REV_0=y'. I'm ok about adding bpll rate_table.
> 
> But, just I have one question. I think that this bpll rate_table is for
> only Exynos5422 series. Because the kernel of hardkernel used
> driver/clk/samsung/clk-exynos5422.c instead of clk-exynos5420.c commonn driver.
> It means that the clk-exynos5422.c of hardkernel's kernel support only Exynos5422
> without any considering the Exynos5420 series.
> 
> I think that it might need to check the soc version to use
> bpll rate_table as following:
Fair enough.
> 
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1438,7 +1438,10 @@ static void __init exynos5x_clk_init(struct device_node *np,
>                  exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>                  exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>                  exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> -               exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
> +
> +               if (soc == EXYNOS5800)
> +                       exynos5x_plls[bpll].rate_table
> +                               = exynos5422_bpll_rate_table;
>          }
> 
I will add this check. Thank you.

Regards,
Lukasz
> 
>>   	}
>>   
>>   	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
>>
> 
> 
