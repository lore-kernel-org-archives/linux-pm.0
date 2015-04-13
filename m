From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v8 10/18] clk: tegra: Initialize PLL_X before CCLK_G to
 ensure it has a parent
Date: Mon, 13 Apr 2015 14:17:01 +0200
Message-ID: <CAAObsKCHUG7Auwu29My5xfynsQ1Jm6KB0bGxf1e3uUO6dvsBRA@mail.gmail.com>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
 <1425213881-5262-11-git-send-email-mikko.perttunen@kapsi.fi>
 <20150410210832.14369.65901@quantum> <5528FEC8.3080103@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5528FEC8.3080103@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: Michael Turquette <mturquette@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, pwalmsley@nvidia.com, Vince Hsu <vinceh@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, tuomas.tynkkynen@iki.fi
List-Id: linux-pm@vger.kernel.org

On 11 April 2015 at 13:00, Mikko Perttunen <mikko.perttunen@kapsi.fi> wrote:
> On 04/11/2015 12:08 AM, Michael Turquette wrote:
>>
>> Quoting Mikko Perttunen (2015-03-01 04:44:33)
>>>
>>> This patch moves the initialization of PLL_X to be slightly before
>>> that of CCLK_G. This ensures that at boot, CCLK_G will immediately
>>> have a parent and the common clock framework can determine its
>>> clock rate correctly.
>>>
>>> Without this patch, calling clk_put on CCLK_G could cause the CCF
>>> to set its rate to zero, hanging the system.
>>
>>
>> Hi Mikko,
>>
>> Patch looks fine to me but I wanted to get more info on the behavior you
>> mentioned above about clk_put. Is there some special circumstance that
>> causes this for you? Why does calling clk_put adjust the rate of your
>> clock?
>>
>> Thanks,
>> Mike
>
>
> Hi Mike,
>
> this is the chain of events:
> - CCLK_G is registered. CCF stores its current rate, but since it doesn't
> have a parent at this point, the rate is assumed zero.
> - tegra cpufreq driver tries to probe, and clk_gets CCLK_G
> - tegra dfll driver tries to probe, but fails
> - tegra cpufreq driver's probe fails, and during unwinding clk_puts CCLK_G
> - CCF attempts to restore CCLK_G's rate to what it was prior to the clk_get
> (to revert possible changes due to clock constraints)

The CCF will currently only do so if any constraints were set in the
per-user clk that was destroyed, so this particular problem shouldn't
happen any more: ec02ace clk: Only recalculate the rate if needed

> - the stored rate was zero, so CCLK_G is set to zero.
>
> We did discuss it a bit on IRC with Tomeu and Peter and agreed that some fix
> in CCF should be done, but we didn't get much further than that.

Wonder if we could somehow make sure that the rate in the CCF matches
the current state of the HW.

Regards,

Tomeu

> Mikko
>
>
>>
>>>
>>> Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
>>> ---
>>> v8:
>>> - Added
>>>
>>>   drivers/clk/tegra/clk-tegra-super-gen4.c | 46
>>> ++++++++++++++++++--------------
>>>   1 file changed, 26 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/clk/tegra/clk-tegra-super-gen4.c
>>> b/drivers/clk/tegra/clk-tegra-super-gen4.c
>>> index f1f4410..c5ea9ee 100644
>>> --- a/drivers/clk/tegra/clk-tegra-super-gen4.c
>>> +++ b/drivers/clk/tegra/clk-tegra-super-gen4.c
>>> @@ -104,6 +104,32 @@ void __init tegra_super_clk_gen4_init(void __iomem
>>> *clk_base,
>>>          struct clk *clk;
>>>          struct clk **dt_clk;
>>>
>>> +       /*
>>> +        * Register PLL_X first so that CCLK_G has a parent at
>>> registration
>>> +        * time. This ensures that the common clock framework knows
>>> CCLK_G's
>>> +        * rate.
>>> +        */
>>> +
>>> +#if defined(CONFIG_ARCH_TEGRA_114_SOC) ||
>>> defined(CONFIG_ARCH_TEGRA_124_SOC)
>>> +       /* PLLX */
>>> +       dt_clk = tegra_lookup_dt_id(tegra_clk_pll_x, tegra_clks);
>>> +       if (!dt_clk)
>>> +               return;
>>> +
>>> +       clk = tegra_clk_register_pllxc("pll_x", "pll_ref", clk_base,
>>> +                       pmc_base, CLK_IGNORE_UNUSED, params, NULL);
>>> +       *dt_clk = clk;
>>> +
>>> +       /* PLLX_OUT0 */
>>> +
>>> +       dt_clk = tegra_lookup_dt_id(tegra_clk_pll_x_out0, tegra_clks);
>>> +       if (!dt_clk)
>>> +               return;
>>> +       clk = clk_register_fixed_factor(NULL, "pll_x_out0", "pll_x",
>>> +                                       CLK_SET_RATE_PARENT, 1, 2);
>>> +       *dt_clk = clk;
>>> +#endif
>>> +
>>>          /* CCLKG */
>>>          dt_clk = tegra_lookup_dt_id(tegra_clk_cclk_g, tegra_clks);
>>>          if (dt_clk) {
>>> @@ -127,25 +153,5 @@ void __init tegra_super_clk_gen4_init(void __iomem
>>> *clk_base,
>>>          }
>>>
>>>          tegra_sclk_init(clk_base, tegra_clks);
>>> -
>>> -#if defined(CONFIG_ARCH_TEGRA_114_SOC) ||
>>> defined(CONFIG_ARCH_TEGRA_124_SOC)
>>> -       /* PLLX */
>>> -       dt_clk = tegra_lookup_dt_id(tegra_clk_pll_x, tegra_clks);
>>> -       if (!dt_clk)
>>> -               return;
>>> -
>>> -       clk = tegra_clk_register_pllxc("pll_x", "pll_ref", clk_base,
>>> -                       pmc_base, CLK_IGNORE_UNUSED, params, NULL);
>>> -       *dt_clk = clk;
>>> -
>>> -       /* PLLX_OUT0 */
>>> -
>>> -       dt_clk = tegra_lookup_dt_id(tegra_clk_pll_x_out0, tegra_clks);
>>> -       if (!dt_clk)
>>> -               return;
>>> -       clk = clk_register_fixed_factor(NULL, "pll_x_out0", "pll_x",
>>> -                                       CLK_SET_RATE_PARENT, 1, 2);
>>> -       *dt_clk = clk;
>>> -#endif
>>>   }
>>>
>>> --
>>> 2.3.0
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
