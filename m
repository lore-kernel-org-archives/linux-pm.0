From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
Date: Mon, 11 Feb 2019 19:34:58 +0900
Message-ID: <790ea13b-7a44-2452-a6b2-51102e60c290@samsung.com>
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
        <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
        <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
        <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
        <CAGTfZH05zn_FiNt3zSHZJfspvo4RXWPrAtWLUq5xsqKoB3qxBA@mail.gmail.com>
        <59a5e9bc-a5de-9f98-5710-4cd48cb5b239@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <59a5e9bc-a5de-9f98-5710-4cd48cb5b239@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, cwchoi00@gmail.com
Cc: devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 2. 11. 오후 7:21, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 2/3/19 8:54 AM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> 2019년 2월 1일 (금) 오후 11:22, Lukasz Luba <l.luba@partner.samsung.com>님이 작성:
>>
>>>
>>> Hi Chanwoo,
>>>
>>> On 2/1/19 9:44 AM, Chanwoo Choi wrote:
>>>> Hi,
>>>>
>>>> On 19. 1. 31. 오후 5:49, Lukasz Luba wrote:
>>>>> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
>>>>> Controller frequencies for driver's DRAM timings.
>>>>>
>>>>> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>>>> CC: Chanwoo Choi <cw00.choi@samsung.com>
>>>>> CC: Michael Turquette <mturquette@baylibre.com>
>>>>> CC: Stephen Boyd <sboyd@kernel.org>
>>>>> CC: Kukjin Kim <kgene@kernel.org>
>>>>> CC: Krzysztof Kozlowski <krzk@kernel.org>
>>>>> CC: linux-samsung-soc@vger.kernel.org
>>>>> CC: linux-clk@vger.kernel.org
>>>>> CC: linux-arm-kernel@lists.infradead.org
>>>>> CC: linux-kernel@vger.kernel.org
>>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>>> ---
>>>>>    drivers/clk/samsung/clk-exynos5420.c | 15 ++++++++++++++-
>>>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>>>>> index 3e87421..8bf9579 100644
>>>>> --- a/drivers/clk/samsung/clk-exynos5420.c
>>>>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>>>>> @@ -1325,6 +1325,19 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
>>>>>       PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
>>>>>    };
>>>>>
>>>>> +static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
>>>>> +    PLL_35XX_RATE(24 * MHZ, 933000000, 311, 4, 1),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 138000000, 184, 2, 4),
>>>>
>>>> Except for 825Mhz, I can't find the target frequency
>>>> on Exynos5422 TRM document. Usually, Exynos TRM specified
>>>> the supported stable clocks. It means that undefined clocks
>>>> are not stable as I knew. Where do you find them?
>>>>
>>>> When I calculated the PLL frequency with PMS value, it is correct.
>>>> But, just we need to check the reference of undefined clocks on TRM
>>>> in order to guarantee the stable operation.
>>> They values live in vendor code for Android.
>>> I have tested the DMC & DDR with these ratios in stress scenarios
>>> for a few days and it was stable.
>>
>> If possible, please share the url of original vendor code.
> Here is the vendor code for the BPLL values:
> https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y-android/drivers/clk/samsung/clk-exynos5422.c#L2026

Thanks for sharing.

bpll_rate_table has two different supported frequency
according to exynos5422 revision as following:
But, this patch only has only one frequency set
for CONFIG_SOC_EXYNOS5422_REV_0.

Could you guarantee that all Exynos5422-based Odroid-xu3 board
has CONFIG_SOC_EXYNOS5422_REV_0 ersion? If not guaranteed,
some board might be fault because of using the unsupported
frequencies.

It is dangerous and unstable to use the unsupported frequencies to SoC.

struct samsung_pll_rate_table bpll_rate_table[] = {
	/* rate		p	m	s	k */
#ifdef CONFIG_SOC_EXYNOS5422_REV_0
	{ 933000000U,   4,  311,    1,  0},
	{ 925000000U,   4,  307,    1,  0},
	{ 825000000U,   4,  275,    1,  0},
	{ 728000000U,   3,  182,    1,  0},
	{ 633000000U,   4,  211,    1,  0},
	{ 543000000U,   2,  181,    2,  0},
	{ 413000000U,   6,  413,    2,  0},
	{ 275000000U,   3,  275,    3,  0},
	{ 206000000U,   3,  206,    3,  0},
	{ 165000000U,   2,  110,    3,  0},
	{ 138000000U,   2,  184,    4,  0},
#else
	{ 933000000U,   4,  311,    1,  0},
	{ 800000000U,   3,  200,    1,  0},
	{ 733000000U,   2,  122,    1,  0},
	{ 667000000U,   2,  111,    1,  0},
	{ 533000000U,   3,  266,    2,  0},
	{ 400000000U,   3,  200,    2,  0},
	{ 266000000U,   3,  266,    3,  0},
	{ 200000000U,   3,  200,    3,  0},
	{ 160000000U,   3,  160,    3,  0},
#endif
};


> 
> Regards,
> Lukasz
>>
>>>
>>>>
>>>> Remove 933/138Mhz because exynos5433-dmc.c doesn't use 933Mhz and 138Mhz
>>>> and also Exynos5422 TRM doesn't define 933/138Mhz on pll table.
>>> OK, I will remove them.
>>>>
>>>>> +};
>>>>> +
>>>>>    static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>>>>>       PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
>>>>>       PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
>>>>> @@ -1467,7 +1480,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>>>>>               exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>>>>               exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>>>>>               exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>>>> -            exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>>>> +            exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
>>>>
>>>> Exynos5422 used the same PLL table for apll, kpll, bpll and so on.
>>>> You don't need to make the separate pll table. Just add new entries
>>>> to exynos5420_pll2550x_24mhz_tbl table.
>>> OK, I will extend the exynos5420_pll2550x_24mhz_tbl table.
>>>
>>> In v4 patch set, it will be fixed.
>>>
>>> Regards,
>>> Lukasz
>>>>
>>>>>       }
>>>>>
>>>>>       samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
>>>>>
>>>>
>>
>>
>>
>> --
>> Best Regards,
>> Chanwoo Choi
>> Samsung Electronics
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
