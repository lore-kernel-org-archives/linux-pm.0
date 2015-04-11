From: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH v8 10/18] clk: tegra: Initialize PLL_X before CCLK_G to
 ensure it has a parent
Date: Sat, 11 Apr 2015 14:00:24 +0300
Message-ID: <5528FEC8.3080103@kapsi.fi>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi> <1425213881-5262-11-git-send-email-mikko.perttunen@kapsi.fi> <20150410210832.14369.65901@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150410210832.14369.65901@quantum>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tuomas.tynkkynen-X3B1VOXEql0@public.gmane.org, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 04/11/2015 12:08 AM, Michael Turquette wrote:
> Quoting Mikko Perttunen (2015-03-01 04:44:33)
>> This patch moves the initialization of PLL_X to be slightly before
>> that of CCLK_G. This ensures that at boot, CCLK_G will immediately
>> have a parent and the common clock framework can determine its
>> clock rate correctly.
>>
>> Without this patch, calling clk_put on CCLK_G could cause the CCF
>> to set its rate to zero, hanging the system.
>
> Hi Mikko,
>
> Patch looks fine to me but I wanted to get more info on the behavior you
> mentioned above about clk_put. Is there some special circumstance that
> causes this for you? Why does calling clk_put adjust the rate of your
> clock?
>
> Thanks,
> Mike

Hi Mike,

this is the chain of events:
- CCLK_G is registered. CCF stores its current rate, but since it 
doesn't have a parent at this point, the rate is assumed zero.
- tegra cpufreq driver tries to probe, and clk_gets CCLK_G
- tegra dfll driver tries to probe, but fails
- tegra cpufreq driver's probe fails, and during unwinding clk_puts CCLK_G
- CCF attempts to restore CCLK_G's rate to what it was prior to the 
clk_get (to revert possible changes due to clock constraints)
- the stored rate was zero, so CCLK_G is set to zero.

We did discuss it a bit on IRC with Tomeu and Peter and agreed that some 
fix in CCF should be done, but we didn't get much further than that.

Mikko

>
>>
>> Signed-off-by: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
>> ---
>> v8:
>> - Added
>>
>>   drivers/clk/tegra/clk-tegra-super-gen4.c | 46 ++++++++++++++++++--------------
>>   1 file changed, 26 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/clk/tegra/clk-tegra-super-gen4.c b/drivers/clk/tegra/clk-tegra-super-gen4.c
>> index f1f4410..c5ea9ee 100644
>> --- a/drivers/clk/tegra/clk-tegra-super-gen4.c
>> +++ b/drivers/clk/tegra/clk-tegra-super-gen4.c
>> @@ -104,6 +104,32 @@ void __init tegra_super_clk_gen4_init(void __iomem *clk_base,
>>          struct clk *clk;
>>          struct clk **dt_clk;
>>
>> +       /*
>> +        * Register PLL_X first so that CCLK_G has a parent at registration
>> +        * time. This ensures that the common clock framework knows CCLK_G's
>> +        * rate.
>> +        */
>> +
>> +#if defined(CONFIG_ARCH_TEGRA_114_SOC) || defined(CONFIG_ARCH_TEGRA_124_SOC)
>> +       /* PLLX */
>> +       dt_clk = tegra_lookup_dt_id(tegra_clk_pll_x, tegra_clks);
>> +       if (!dt_clk)
>> +               return;
>> +
>> +       clk = tegra_clk_register_pllxc("pll_x", "pll_ref", clk_base,
>> +                       pmc_base, CLK_IGNORE_UNUSED, params, NULL);
>> +       *dt_clk = clk;
>> +
>> +       /* PLLX_OUT0 */
>> +
>> +       dt_clk = tegra_lookup_dt_id(tegra_clk_pll_x_out0, tegra_clks);
>> +       if (!dt_clk)
>> +               return;
>> +       clk = clk_register_fixed_factor(NULL, "pll_x_out0", "pll_x",
>> +                                       CLK_SET_RATE_PARENT, 1, 2);
>> +       *dt_clk = clk;
>> +#endif
>> +
>>          /* CCLKG */
>>          dt_clk = tegra_lookup_dt_id(tegra_clk_cclk_g, tegra_clks);
>>          if (dt_clk) {
>> @@ -127,25 +153,5 @@ void __init tegra_super_clk_gen4_init(void __iomem *clk_base,
>>          }
>>
>>          tegra_sclk_init(clk_base, tegra_clks);
>> -
>> -#if defined(CONFIG_ARCH_TEGRA_114_SOC) || defined(CONFIG_ARCH_TEGRA_124_SOC)
>> -       /* PLLX */
>> -       dt_clk = tegra_lookup_dt_id(tegra_clk_pll_x, tegra_clks);
>> -       if (!dt_clk)
>> -               return;
>> -
>> -       clk = tegra_clk_register_pllxc("pll_x", "pll_ref", clk_base,
>> -                       pmc_base, CLK_IGNORE_UNUSED, params, NULL);
>> -       *dt_clk = clk;
>> -
>> -       /* PLLX_OUT0 */
>> -
>> -       dt_clk = tegra_lookup_dt_id(tegra_clk_pll_x_out0, tegra_clks);
>> -       if (!dt_clk)
>> -               return;
>> -       clk = clk_register_fixed_factor(NULL, "pll_x_out0", "pll_x",
>> -                                       CLK_SET_RATE_PARENT, 1, 2);
>> -       *dt_clk = clk;
>> -#endif
>>   }
>>
>> --
>> 2.3.0
>>
