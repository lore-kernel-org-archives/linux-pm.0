From: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH v7 05/16] clk: tegra: Add DFLL DVCO reset control for
 Tegra124
Date: Fri, 13 Feb 2015 12:39:03 +0200
Message-ID: <54DDD447.8000404@kapsi.fi>
References: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi> <1420723339-30735-6-git-send-email-mikko.perttunen@kapsi.fi> <20150212141944.GK20811@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150212141944.GK20811-Rysk9IDjsxmJz7etNGeUX8VPkgjIgRvpAL8bYrjMMd8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tuomas.tynkkynen-X3B1VOXEql0@public.gmane.org, Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 02/12/2015 04:19 PM, Peter De Schrijver wrote:
> On Thu, Jan 08, 2015 at 03:22:08PM +0200, Mikko Perttunen wrote:
>> From: Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> The DVCO present in the DFLL IP block has a separate reset line,
>> exposed via the CAR IP block.  This reset line is asserted upon SoC
>> reset.  Unless something (such as the DFLL driver) deasserts this
>> line, the DVCO will not oscillate, although reads and writes to the
>> DFLL IP block will complete.
>>
>> Thanks to Aleksandr Frid <afrid-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> for identifying this and
>> saving hours of debugging time.
>>
>
> Should this be done as a reset driver?

Probably through the already existing CAR reset driver. This reset 
doesn't fit well with the existing numbering scheme there, though. 
Perhaps a magic high-valued constant that represents it.

>
>> Signed-off-by: Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> [ttynkkynen: ported to tegra124 from tegra114]
>> Signed-off-by: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
>> ---
>>   drivers/clk/tegra/clk-tegra124.c | 47 ++++++++++++++++++++++++++++++++++++++++
>>   drivers/clk/tegra/clk.h          |  3 +++
>>   2 files changed, 50 insertions(+)
>>
>> diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
>> index f5f9bac..623b77f 100644
>> --- a/drivers/clk/tegra/clk-tegra124.c
>> +++ b/drivers/clk/tegra/clk-tegra124.c
>> @@ -31,6 +31,9 @@
>>   #define CLK_SOURCE_CSITE 0x1d4
>>   #define CLK_SOURCE_EMC 0x19c
>>
>> +#define RST_DFLL_DVCO			0x2f4
>> +#define DVFS_DFLL_RESET_SHIFT		0
>> +
>>   #define PLLC_BASE 0x80
>>   #define PLLC_OUT 0x84
>>   #define PLLC_MISC2 0x88
>> @@ -1399,6 +1402,50 @@ static void __init tegra124_clock_apply_init_table(void)
>>   	tegra_init_from_table(init_table, clks, TEGRA124_CLK_CLK_MAX);
>>   }
>>
>> +/**
>> + * tegra124_car_barrier - wait for pending writes to the CAR to complete
>> + *
>> + * Wait for any outstanding writes to the CAR MMIO space from this CPU
>> + * to complete before continuing execution.  No return value.
>> + */
>> +static void tegra124_car_barrier(void)
>> +{
>> +	readl_relaxed(clk_base + RST_DFLL_DVCO);
>> +}
>> +
>> +/**
>> + * tegra124_clock_assert_dfll_dvco_reset - assert the DFLL's DVCO reset
>> + *
>> + * Assert the reset line of the DFLL's DVCO.  No return value.
>> + */
>> +void tegra124_clock_assert_dfll_dvco_reset(void)
>> +{
>> +	u32 v;
>> +
>> +	v = readl_relaxed(clk_base + RST_DFLL_DVCO);
>> +	v |= (1 << DVFS_DFLL_RESET_SHIFT);
>> +	writel_relaxed(v, clk_base + RST_DFLL_DVCO);
>> +	tegra124_car_barrier();
>> +}
>> +EXPORT_SYMBOL(tegra124_clock_assert_dfll_dvco_reset);
>> +
>> +/**
>> + * tegra124_clock_deassert_dfll_dvco_reset - deassert the DFLL's DVCO reset
>> + *
>> + * Deassert the reset line of the DFLL's DVCO, allowing the DVCO to
>> + * operate.  No return value.
>> + */
>> +void tegra124_clock_deassert_dfll_dvco_reset(void)
>> +{
>> +	u32 v;
>> +
>> +	v = readl_relaxed(clk_base + RST_DFLL_DVCO);
>> +	v &= ~(1 << DVFS_DFLL_RESET_SHIFT);
>> +	writel_relaxed(v, clk_base + RST_DFLL_DVCO);
>> +	tegra124_car_barrier();
>> +}
>> +EXPORT_SYMBOL(tegra124_clock_deassert_dfll_dvco_reset);
>> +
>>   static void __init tegra124_clock_init(struct device_node *np)
>>   {
>>   	struct device_node *node;
>> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
>> index 4e458aa..def0ea4 100644
>> --- a/drivers/clk/tegra/clk.h
>> +++ b/drivers/clk/tegra/clk.h
>> @@ -629,6 +629,9 @@ void tegra114_clock_tune_cpu_trimmers_init(void);
>>   void tegra114_clock_assert_dfll_dvco_reset(void);
>>   void tegra114_clock_deassert_dfll_dvco_reset(void);
>>
>> +void tegra124_clock_assert_dfll_dvco_reset(void);
>> +void tegra124_clock_deassert_dfll_dvco_reset(void);
>> +
>>   typedef void (*tegra_clk_apply_init_table_func)(void);
>>   extern tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
>>
>> --
>> 2.2.1
>>
