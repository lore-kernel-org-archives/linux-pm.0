From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/6] clk: add CLK_RECALC_NEW_RATES clock flag for Exynos
 cpu clock support
Date: Mon, 22 Jun 2015 09:06:58 +0900
Message-ID: <558751A2.2010406@samsung.com>
References: <'@samsung.com> <20150618195846.9112.7144@quantum>
 <15113828.ygxT0eaek9@amdc1976> <3554100.H9OH7Yrz4m@amdc1976>
 <20150619145357.9112.63998@quantum> <558539E8.5050101@samsung.com>
 <20150620191337.9112.76018@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20150620191337.9112.76018@quantum>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, Lukasz Majewski <l.majewski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 21.06.2015 04:13, Michael Turquette wrote:
> Quoting Krzysztof Kozlowski (2015-06-20 03:01:12)
>> W dniu 19.06.2015 o 23:53, Michael Turquette pisze:
>>> Quoting Bartlomiej Zolnierkiewicz (2015-06-19 05:35:23)
>>>> On Friday, June 19, 2015 01:19:06 PM Bartlomiej Zolnierkiewicz wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Thursday, June 18, 2015 12:58:46 PM Michael Turquette wrote:
>>>>>> Quoting Sylwester Nawrocki (2015-05-13 07:13:13)
>>>>>>> On 03/04/15 18:43, Bartlomiej Zolnierkiewicz wrote:
>>>>>>>> This flag is needed to fix the issue with wrong dividers being setup
>>>>>>>> by Common Clock Framework when using the new Exynos cpu clock support.
>>>>>>>>
>>>>>>>> The issue happens because clk_core_set_rate_nolock()  calls
>>>>>>>> clk_calc_new_rates(clk, rate) before both pre/post clock notifiers have
>>>>>>>> a chance to run.  In case of Exynos cpu clock support pre/post clock
>>>>>>>> notifiers are registered for mout_apll clock which is a parent of armclk
>>>>>>>> cpu clock and dividers are modified in both pre and post clock notifier.
>>>>>>>> This results in wrong dividers values being later programmed by
>>>>>>>> clk_change_rate(top).  To workaround the problem CLK_RECALC_NEW_RATES
>>>>>>>> flag is added and it is set for mout_apll clock later so the correct
>>>>>>>> divider values are re-calculated after both pre and post clock notifiers
>>>>>>>> had run.
>>>>>>>>
>>>>>>>> For example when using "performance" governor on Exynos4210 Origen board
>>>>>>>> the cpufreq-dt driver requests to change the frequency from 1000MHz to
>>>>>>>> 1200MHz and after the change state of the relevant clocks is following:
>>>>>>>>
>>>>>>>> Without use of CLK_GET_RATE_NOCACHE flag:
>>>>>>>>
>>>>>>>>  fout_apll rate: 1200000000
>>>>>>>>          fout_apll_div_2 rate: 600000000
>>>>>>>>                  mout_clkout_cpu rate: 600000000
>>>>>>>>                          div_clkout_cpu rate: 600000000
>>>>>>>>                                  clkout_cpu rate: 600000000
>>>>>>>>          mout_apll rate: 1200000000
>>>>>>>>                  armclk rate: 1200000000
>>>>>>>>                  mout_hpm rate: 1200000000
>>>>>>>>                          div_copy rate: 300000000
>>>>>>>>                                  div_hpm rate: 300000000
>>>>>>>>                  mout_core rate: 1200000000
>>>>>>>>                          div_core rate: 1200000000
>>>>>>>>                                  div_core2 rate: 1200000000
>>>>>>>>                                          arm_clk_div_2 rate: 600000000
>>>>>>>>                                          div_corem0 rate: 300000000
>>>>>>>>                                          div_corem1 rate: 150000000
>>>>>>>>                                          div_periph rate: 300000000
>>>>>>>>                          div_atb rate: 300000000
>>>>>>>>                                  div_pclk_dbg rate: 150000000
>>>>>>>>                  sclk_apll rate: 1200000000
>>>>>>>>                          sclk_apll_div_2 rate: 600000000
>>>>>>>>
>>>>>>>>
>>>>>>>> With use of CLK_GET_RATE_NOCACHE flag:
>>>>>>>>
>>>>>>>>  fout_apll rate: 1200000000
>>>>>>>>          fout_apll_div_2 rate: 600000000
>>>>>>>>                  mout_clkout_cpu rate: 600000000
>>>>>>>>                          div_clkout_cpu rate: 600000000
>>>>>>>>                                  clkout_cpu rate: 600000000
>>>>>>>>          mout_apll rate: 1200000000
>>>>>>>>                  armclk rate: 1200000000
>>>>>>>>                  mout_hpm rate: 1200000000
>>>>>>>>                          div_copy rate: 200000000
>>>>>>>>                                  div_hpm rate: 200000000
>>>>>>>>                  mout_core rate: 1200000000
>>>>>>>>                          div_core rate: 1200000000
>>>>>>>>                                  div_core2 rate: 1200000000
>>>>>>>>                                          arm_clk_div_2 rate: 600000000
>>>>>>>>                                          div_corem0 rate: 300000000
>>>>>>>>                                          div_corem1 rate: 150000000
>>>>>>>>                                          div_periph rate: 300000000
>>>>>>>>                          div_atb rate: 240000000
>>>>>>>>                                  div_pclk_dbg rate: 120000000
>>>>>>>>                  sclk_apll rate: 150000000
>>>>>>>>                          sclk_apll_div_2 rate: 75000000
>>>>>>>>
>>>>>>>> Without this change cpufreq-dt driver showed ~10 mA larger energy
>>>>>>>> consumption when compared to cpufreq-exynos one when "performance"
>>>>>>>> cpufreq governor was used on Exynos4210 SoC based Origen board.
>>>>>>>>
>>>>>>>> This issue was probably meant to be workarounded by use of
>>>>>>>> CLK_GET_RATE_NOCACHE and CLK_DIVIDER_READ_ONLY clock flags in
>>>>>>>> the original Exynos cpu clock patchset (in "[PATCH v12 6/6] clk:
>>>>>>>> samsung: remove unused clock aliases and update clock flags" patch)
>>>>>>>> but usage of these flags is not sufficient to fix the issue observed.
>>>>>>>>
>>>>>>>> Cc: Thomas Abraham <thomas.ab@samsung.com>
>>>>>>>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>>>>>>>> Cc: Mike Turquette <mturquette@linaro.org>
>>>>>>>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>>>>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>>>>>>> ---
>>>>>>>>  drivers/clk/clk.c            |    3 +++
>>>>>>>>  include/linux/clk-provider.h |    1 +
>>>>>>>>  2 files changed, 4 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>>>>>>>> index f85c8e2..97cc73e 100644
>>>>>>>> --- a/drivers/clk/clk.c
>>>>>>>> +++ b/drivers/clk/clk.c
>>>>>>>> @@ -1771,6 +1771,9 @@ static void clk_change_rate(struct clk_core *clk)
>>>>>>>>       if (clk->notifier_count && old_rate != clk->rate)
>>>>>>>>               __clk_notify(clk, POST_RATE_CHANGE, old_rate, clk->rate);
>>>>>>>>  
>>>>>>>> +     if (clk->flags & CLK_RECALC_NEW_RATES)
>>>>>>>> +             (void)clk_calc_new_rates(clk, clk->new_rate);
>>>>>>>> +
>>>>>>>>       /*
>>>>>>>>        * Use safe iteration, as change_rate can actually swap parents
>>>>>>>>        * for certain clock types.
>>>>>>>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>>>>>>>> index 28abf1b..8d1aebe 100644
>>>>>>>> --- a/include/linux/clk-provider.h
>>>>>>>> +++ b/include/linux/clk-provider.h
>>>>>>>> @@ -31,6 +31,7 @@
>>>>>>>>  #define CLK_GET_RATE_NOCACHE BIT(6) /* do not use the cached clk rate */
>>>>>>>>  #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
>>>>>>>>  #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
>>>>>>>> +#define CLK_RECALC_NEW_RATES BIT(9) /* recalc rates after notifications */
>>>>>>>
>>>>>>> Mike, Stephen, what do you think about this? I'm rather resistant to
>>>>>>> this new flag approach, it looks like a hack. I don't seem to have better
>>>>>>> ideas to address the missing rate recalculation issue though.
>>>>>>
>>>>>> I also do not like it. The root of the problem is the use of clk
>>>>>> notifiers to change clk rates. This is also a hack and it points towards
>>>>>> some missing infrastructure in the clock framework.
>>>>>
>>>>> I'm very surprised by this.  Clock changes using clock notifiers in
>>>>> Thomas' original patchset were Acked by you:
>>>>>
>>>>> "[PATCH v12 1/6] clk: samsung: add infrastructure to register cpu clocks"
>>>>> https://www.marc.info/?l=linux-arm-kernel&m=141657613203808&w=2
>>>>>
>>>>> I've only fixed issues present within the original code (this 4 lines
>>>>> workaround/hack change to clock subsystem is a result of this), I have
>>>>> not changed it fundamentally.
>>>>
>>>> Moreover similar changes for rockchip SoCs (which were explicitly based
>>>> on Thomas' patches as noted in the code!) have already been merged in
>>>> 3.18:
>>>>
>>>> http://lkml.iu.edu/hypermail/linux/kernel/1410.1/02644.html
>>>>
>>>> and are available in commit f6fba5f6967dbc062a7c138d67e2314220f5dd04
>>>> ("clk: rockchip: add new clock-type for the cpuclk").
>>>>
>>>> I understand that my findings have uncovered some clock subsystem
>>>> deficiencies which resulted in afterthought about fundamental design
>>>> of cpu clocks but I have a feeling that our patches are now being
>>>> unjustly punished for making these issues public.
>>>>
>>>> I agree that current patches are not perfect (especially this patch)
>>>> but they are good enough IMO.  Please also understand that there were
>>>> some serious work put into validating and reviewing them.
>>>
>>> You know what? You're right.
>>>
>>> I don't really like this cpu-clock code (and similarly I don't like
>>> Tegra's EMC code which requires access to clk_hw_reparent). But I slept
>>> on this issue overnight and it doesn't seem right for me to hold back
>>> these patches when the better solution is currently vaporware (I have
>>> some code but it's far from ready).
>>>
>>> It occurs to me that the best decision I can take is to merge it now and
>>> then force you guys to switch over when the new infrastructure is
>>> available. That is more reasonable than delaying the patches getting
>>> pulled.
>>>
>>> So how to merge it? Viresh has given his Ack and is OK for the cpufreq
>>> changes to go through another tree. I can take the whole thing with
>>> Kukjin's Ack on the ARM dts patch, or we can set up an immutable
>>> branch.
>>
>> I already acked the DTS [0] patch and I'm fine with it. However there
>> would be some conflicts if this went through tree different than
>> Samsung. There are many Exynos4 DTS changes in the queue for 4.2.
>>
>> Are there any objections for picking the DTS patch to Samsung tree?
> 
> That's fine with me. I don't foresee any build problems if I take
> patches 1-3 and 5-6. So I'll take those and you'll take #4, sound good?

Yes, sounds good.

Bartlomiej, let us know if you suspect any problems with such approach.

Best regards,
Krzysztof
