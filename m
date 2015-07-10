From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2 4/7] clk: samsung: exynos4x12: add cpu clock
 configuration data and instantiate cpu clock
Date: Fri, 10 Jul 2015 09:12:18 -0700
Message-ID: <559FEEE2.6060608@osg.samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-5-git-send-email-b.zolnierkie@samsung.com>
 <559F82AE.8070108@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <559F82AE.8070108@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Krzysztof,

On 07/10/2015 01:30 AM, Krzysztof Kozlowski wrote:
> On 10.07.2015 00:43, Bartlomiej Zolnierkiewicz wrote:
>> With the addition of the new Samsung specific cpu-clock type, the
>> arm clock can be represented as a cpu-clock type. Add the CPU clock
>> configuration data and instantiate the CPU clock type for Exynos4x12.
>>
>> Based on the earlier work by Thomas Abraham.
>>
>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: Javier Martinez Canillas <javier@dowhile0.org>
>> Cc: Thomas Abraham <thomas.ab@samsung.com>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos4.c | 50 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
>> index cae2c048..3071260 100644
>> --- a/drivers/clk/samsung/clk-exynos4.c
>> +++ b/drivers/clk/samsung/clk-exynos4.c
>> @@ -1396,6 +1396,45 @@ static const struct exynos_cpuclk_cfg_data e4210_armclk_d[] __initconst = {
>>  	{  0 },
>>  };
>>  
>> +static const struct exynos_cpuclk_cfg_data e4212_armclk_d[] __initconst = {
>> +	{ 1500000, E4210_CPU_DIV0(2, 1, 6, 0, 7, 3), E4210_CPU_DIV1(2, 6), },
>> +	{ 1400000, E4210_CPU_DIV0(2, 1, 6, 0, 7, 3), E4210_CPU_DIV1(2, 6), },
>> +	{ 1300000, E4210_CPU_DIV0(2, 1, 5, 0, 7, 3), E4210_CPU_DIV1(2, 5), },
>> +	{ 1200000, E4210_CPU_DIV0(2, 1, 5, 0, 7, 3), E4210_CPU_DIV1(2, 5), },
>> +	{ 1100000, E4210_CPU_DIV0(2, 1, 4, 0, 6, 3), E4210_CPU_DIV1(2, 4), },
>> +	{ 1000000, E4210_CPU_DIV0(1, 1, 4, 0, 5, 2), E4210_CPU_DIV1(2, 4), },
>> +	{  900000, E4210_CPU_DIV0(1, 1, 3, 0, 5, 2), E4210_CPU_DIV1(2, 3), },
>> +	{  800000, E4210_CPU_DIV0(1, 1, 3, 0, 5, 2), E4210_CPU_DIV1(2, 3), },
>> +	{  700000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
>> +	{  600000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
>> +	{  500000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
>> +	{  400000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
>> +	{  300000, E4210_CPU_DIV0(1, 1, 2, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
>> +	{  200000, E4210_CPU_DIV0(1, 1, 1, 0, 3, 1), E4210_CPU_DIV1(2, 3), },
>> +	{  0 },
>> +};
>> +
>> +#define E4412_CPU_DIV1(cores, hpm, copy)				\
>> +		(((cores) << 8) | ((hpm) << 4) | ((copy) << 0))
>> +
>> +static const struct exynos_cpuclk_cfg_data e4412_armclk_d[] __initconst = {
>> +	{ 1500000, E4210_CPU_DIV0(2, 1, 6, 0, 7, 3), E4412_CPU_DIV1(7, 0, 6), },
>> +	{ 1400000, E4210_CPU_DIV0(2, 1, 6, 0, 7, 3), E4412_CPU_DIV1(6, 0, 6), },
>> +	{ 1300000, E4210_CPU_DIV0(2, 1, 5, 0, 7, 3), E4412_CPU_DIV1(6, 0, 5), },
>> +	{ 1200000, E4210_CPU_DIV0(2, 1, 5, 0, 7, 3), E4412_CPU_DIV1(5, 0, 5), },
>> +	{ 1100000, E4210_CPU_DIV0(2, 1, 4, 0, 6, 3), E4412_CPU_DIV1(5, 0, 4), },
>> +	{ 1000000, E4210_CPU_DIV0(1, 1, 4, 0, 5, 2), E4412_CPU_DIV1(4, 0, 4), },
>> +	{  900000, E4210_CPU_DIV0(1, 1, 3, 0, 5, 2), E4412_CPU_DIV1(4, 0, 3), },
>> +	{  800000, E4210_CPU_DIV0(1, 1, 3, 0, 5, 2), E4412_CPU_DIV1(3, 0, 3), },
>> +	{  700000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4412_CPU_DIV1(3, 0, 3), },
>> +	{  600000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4412_CPU_DIV1(2, 0, 3), },
>> +	{  500000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4412_CPU_DIV1(2, 0, 3), },
>> +	{  400000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4412_CPU_DIV1(1, 0, 3), },
>> +	{  300000, E4210_CPU_DIV0(1, 1, 2, 0, 4, 2), E4412_CPU_DIV1(1, 0, 3), },
>> +	{  200000, E4210_CPU_DIV0(1, 1, 1, 0, 3, 1), E4412_CPU_DIV1(0, 0, 3), },
>> +	{  0 },
>> +};
> 
> Numbers look fine!
> 
>> +
>>  /* register exynos4 clocks */
>>  static void __init exynos4_clk_init(struct device_node *np,
>>  				    enum exynos4_soc soc)
>> @@ -1489,6 +1528,17 @@ static void __init exynos4_clk_init(struct device_node *np,
>>  		samsung_clk_register_fixed_factor(ctx,
>>  			exynos4x12_fixed_factor_clks,
>>  			ARRAY_SIZE(exynos4x12_fixed_factor_clks));
>> +		if (of_machine_is_compatible("samsung,exynos4412")) {
> 
> The driver uses here enum exynos4_soc to differentiate between SoC
> (unless I missed some changes). This of_machine_is_compatible() makes
> sense but introduces inconsistency. I would prefer sticking to one
> convention: always enum or switch everything (before this patch) to
> of_compatible.
>

When reviewing this patch I also ran into the same thing because as you
said, it's not consistent. But digging a little bit I found that is not
that easy since the two are not checking exactly the same.

The enum is to differentiate between "samsung,exynos4412-clock" and
"samsung,exynos4210-clock" while the of_machine_is_compatible() is for
"samsung,exynos4412" and "samsung,exynos4212".

The problem is that both exynos4412 and exynos4212 use the same
"samsung,exynos4412-clock" compatible for their clock controller nodes.
But there are differences so it would had been better to also have a
"samsung,exynos4212-clock" to avoid the of_machine_is_compatible() but
that is not possible anymore without breaking DT backward compatibility.

On the other hand, if of_machine_is_compatible() is used for everything,
then there is no point anymore to have both "samsung,exynos4412-clock"
and "samsung,exynos4210-clock". A single "samsung,exynos4-clock" plus
checking the SoC would had been enough.

That's why I thought that Bart's approach was sensible although is true
that the of_compatible() check can be moved to exynos4412_clk_init()
and the enum be extended so at least exynos4_clk_init() is consistent.

> Best regards,
> Krzysztof

Best regards,

-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
