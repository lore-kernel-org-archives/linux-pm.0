From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH v3 7/7] PM / devfreq: Add devfreq driver for Exynos5420
Date: Mon, 28 Jul 2014 17:31:10 +0530
Message-ID: <CAM4voan4WMe-q6f3u6Bujx0n_TBrW_ibtZrC64-wOBrG=oYFaw@mail.gmail.com>
References: <1400779322-4410-8-git-send-email-a.kesavan@samsung.com>
	<1405449368-26430-1-git-send-email-a.kesavan@samsung.com>
	<53C6684D.4040605@samsung.com>
	<CAM4voakxJp9Bi6Z6dGEN30ihQYpOpdOnoPkKOSQqCAeZyjcJ8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:61012 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbaG1MBL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jul 2014 08:01:11 -0400
In-Reply-To: <CAM4voakxJp9Bi6Z6dGEN30ihQYpOpdOnoPkKOSQqCAeZyjcJ8g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>, =?UTF-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>
Cc: "myungjoo.ham" <myungjoo.ham@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, devicetree <devicetree@vger.kernel.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>

Hi Tomasz,

On Wed, Jul 16, 2014 at 11:29 PM, Abhilash Kesavan
<kesavan.abhilash@gmail.com> wrote:
> Hi Tomasz,
>
> On Wed, Jul 16, 2014 at 5:25 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>> Hi Abhilash,
>>
>> Please see my comments inline.
>>
>> On 15.07.2014 20:36, Abhilash Kesavan wrote:
>>> From: "Arjun.K.V" <arjun.kv@samsung.com>
>>>
>>> Exynos5420 bus device devfreq driver monitors PPMU counters and
>>> adjusts INT domain operating frequencies and voltages. Support
>>> for 5420 has been added to the extant 5250 support.
>>>
>>> Signed-off-by: Arjun.K.V <arjun.kv@samsung.com>
>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>> ---
>>>  drivers/devfreq/Kconfig              |   10 +-
>>>  drivers/devfreq/exynos/exynos5_bus.c |  598 ++++++++++++++++++++++++++++------
>>>  2 files changed, 508 insertions(+), 100 deletions(-)
>>
>> [snip]
>>
>>>
>>> -#define MAX_SAFEVOLT                 1100000 /* 1.10V */
>>> -/* Assume that the bus is saturated if the utilization is 25% */
>>> -#define INT_BUS_SATURATION_RATIO     25
>>> +/* Assume that we need to bump up the level if the utilization is 10% */
>>> +#define INT_BUS_SATURATION_RATIO     10
>>
>> There is nothing about this change in commit message and changing the
>> ratio from 25% to 10% seems to be rather significant. Please give the
>> rationale for this change.
> Will do.
>>
>>> +#define INT_VOLT_STEP_UV             12500
>>> +
>>> +struct exynos5_busfreq_drv_data {
>>> +     int busf_type;
>>> +};
>>> +
>>> +enum exynos5_busf_type {
>>> +     TYPE_BUSF_EXYNOS5250,
>>> +     TYPE_BUSF_EXYNOS5420,
>>> +};
>>
>> Using this kind of enums is discouraged. Rather than that, just create a
>> structure that describes the differences between variants and use this
>> as type.
> OK.
>>
>>>
>>>  enum int_level_idx {
>>>       LV_0,
>>> @@ -41,12 +46,31 @@ enum int_level_idx {
>>>       _LV_END
>>>  };
>>
>> [snip]
>>
>>> +
>>> +static struct int_bus_opp_table *exynos5_int_opp_table;
>>> +static struct int_bus_opp_table exynos5250_int_opp_table[] = {
>>>       {LV_0, 266000, 1025000},
>>>       {LV_1, 200000, 1025000},
>>>       {LV_2, 160000, 1025000},
>>
>> [snip]
>>
>>> +static struct int_clk_info exynos5420_aclk_300_jpeg[] = {
>>> +     /* Level, Freq, Parent_Pll */
>>> +     {LV_0, 300000, D_PLL},
>>> +     {LV_1, 300000, D_PLL},
>>> +     {LV_2, 200000, D_PLL},
>>> +     {LV_3, 150000, D_PLL},
>>> +     {LV_4,  75000, D_PLL},
>>> +};
>>
>> These should be parsed from DT.
> OK.
>>
>>> +
>>> +#define EXYNOS5420_INT_PM_CLK(NAME, CLK, PCLK, CLK_INFO)     \
>>> +static struct int_comp_clks int_pm_clks_##NAME = {   \
>>> +     .mux_clk_name = CLK,                            \
>>> +     .div_clk_name = PCLK,                           \
>>> +     .clk_info = CLK_INFO,                           \
>>> +}
>>> +
>>> +EXYNOS5420_INT_PM_CLK(aclk_200_fsys, "aclk200_fsys",
>>> +                     "aclk200_fsys_d", exynos5420_aclk_200_fsys);
>>> +EXYNOS5420_INT_PM_CLK(pclk_200_fsys, "pclk200_fsys",
>>> +                     "pclk200_fsys_d", exynos5420_pclk_200_fsys);
>>> +EXYNOS5420_INT_PM_CLK(aclk_100_noc, "aclk100_noc",
>>> +                     "aclk100_noc_d", exynos5420_aclk_100_noc);
>>> +EXYNOS5420_INT_PM_CLK(aclk_400_wcore, "aclk400_wcore",
>>> +                     "aclk400_wcore_d", exynos5420_aclk_400_wcore);
>>> +EXYNOS5420_INT_PM_CLK(aclk_200_fsys2, "aclk200_fsys2",
>>> +                     "aclk200_fsys2_d", exynos5420_aclk_200_fsys2);
>>> +EXYNOS5420_INT_PM_CLK(aclk_400_mscl, "aclk400_mscl",
>>> +                     "aclk400_mscl_d", exynos5420_aclk_400_mscl);
>>> +EXYNOS5420_INT_PM_CLK(aclk_166, "aclk166",
>>> +                     "aclk166_d", exynos5420_aclk_166);
>>> +EXYNOS5420_INT_PM_CLK(aclk_266, "aclk266",
>>> +                     "aclk266_d", exynos5420_aclk_266);
>>> +EXYNOS5420_INT_PM_CLK(aclk_66, "aclk66",
>>> +                     "aclk66_d", exynos5420_aclk_66);
>>> +EXYNOS5420_INT_PM_CLK(aclk_300_disp1, "aclk300_disp1",
>>> +                     "aclk300_disp1_d", exynos5420_aclk_300_disp1);
>>> +EXYNOS5420_INT_PM_CLK(aclk_300_jpeg, "aclk300_jpeg",
>>> +                     "aclk300_jpeg_d", exynos5420_aclk_300_jpeg);
>>> +EXYNOS5420_INT_PM_CLK(aclk_400_disp1, "aclk400_disp1",
>>> +                     "aclk400_disp1_d", exynos5420_aclk_400_disp1);
>>
>> List of the clocks should be parsed from DT as well, without hardcoding
>> data for every SoC in the driver.
>>
>>> +
>>> +static struct int_comp_clks *exynos5420_int_pm_clks[] = {
>>> +     &int_pm_clks_aclk_200_fsys,
>>> +     &int_pm_clks_pclk_200_fsys,
>>> +     &int_pm_clks_aclk_100_noc,
>>> +     &int_pm_clks_aclk_400_wcore,
>>> +     &int_pm_clks_aclk_200_fsys2,
>>> +     &int_pm_clks_aclk_400_mscl,
>>> +     &int_pm_clks_aclk_166,
>>> +     &int_pm_clks_aclk_266,
>>> +     &int_pm_clks_aclk_66,
>>> +     &int_pm_clks_aclk_300_disp1,
>>> +     &int_pm_clks_aclk_300_jpeg,
>>> +     &int_pm_clks_aclk_400_disp1,
>>> +     NULL,
>>> +};
>>> +
>>> +static int exynos5250_int_set_rate(struct busfreq_data_int *data,
>>>                               unsigned long rate)
>>>  {
>>>       int index, i;
>>>
>>> -     for (index = 0; index < ARRAY_SIZE(exynos5_int_opp_table); index++) {
>>> -             if (exynos5_int_opp_table[index].clk == rate)
>>> +     for (index = 0; index < ARRAY_SIZE(exynos5250_int_opp_table); index++) {
>>> +             if (exynos5250_int_opp_table[index].clk == rate)
>>>                       break;
>>>       }
>>>
>>> @@ -161,8 +370,8 @@ static int exynos5_int_set_rate(struct busfreq_data_int *data,
>>>               return -EINVAL;
>>>
>>>       /* Change the system clock divider values */
>>> -     for (i = 0; i < ARRAY_SIZE(exynos5_int_clks); i++) {
>>> -             struct int_clk *clk_info = &exynos5_int_clks[i];
>>> +     for (i = 0; i < ARRAY_SIZE(exynos5250_int_clks); i++) {
>>> +             struct int_simple_clk *clk_info = &exynos5250_int_clks[i];
>>>               int ret;
>>>
>>>               ret = clk_set_rate(clk_info->clk,
>>> @@ -177,10 +386,111 @@ static int exynos5_int_set_rate(struct busfreq_data_int *data,
>>>       return 0;
>>>  }
>>>
>>> +static struct clk *exynos5420_find_pll(struct busfreq_data_int *data,
>>> +                                 enum int_bus_pll target_pll)
>>> +{
>>> +     struct clk *target_src_clk = NULL;
>>> +
>>> +     switch (target_pll) {
>>> +     case C_PLL:
>>> +             target_src_clk = data->mout_cpll;
>>> +             break;
>>> +     case M_PLL:
>>> +             target_src_clk = data->mout_mpll;
>>> +             break;
>>> +     case D_PLL:
>>> +             target_src_clk = data->mout_dpll;
>>> +             break;
>>> +     case I_PLL:
>>> +             target_src_clk = data->mout_ipll;
>>> +             break;
>>> +     default:
>>> +             break;
>>> +     }
>>
>> What about storing the clocks in an array? Then all you would need to do
>> could be as simple as accessing data->plls[target_pll].
> OK.
>>
>>> +
>>> +     return target_src_clk;
>>> +}
>>> +
>>> +static int exynos5420_int_set_rate(struct busfreq_data_int *data,
>>> +             unsigned long target_freq, unsigned long pre_freq)
>>> +{
>>> +     unsigned int i;
>>> +     unsigned long tar_rate;
>>> +     int target_idx = -EINVAL;
>>> +     int pre_idx = -EINVAL;
>>> +     struct int_comp_clks *int_clk;
>>> +     struct clk *new_src_pll;
>>> +     struct clk *old_src_pll;
>>> +     unsigned long old_src_rate, new_src_rate;
>>> +     unsigned long rate1, rate2, rate3, rate4;
>>> +
>>> +     /* Find the levels for target and previous frequencies */
>>> +     for (i = 0; i < _LV_END; i++) {
>>> +             if (exynos5420_int_opp_table[i].clk == target_freq)
>>> +                     target_idx = exynos5420_int_opp_table[i].idx;
>>> +             if (exynos5420_int_opp_table[i].clk == pre_freq)
>>> +                     pre_idx = exynos5420_int_opp_table[i].idx;
>>> +     }
>>> +
>>> +     list_for_each_entry(int_clk, &data->list, node) {
>>> +             tar_rate = int_clk->clk_info[target_idx].target_freq * 1000;
>>> +
>>> +             old_src_pll = clk_get_parent(int_clk->mux_clk);
>>> +             new_src_pll = exynos5420_find_pll(data,
>>> +                             int_clk->clk_info[target_idx].src_pll);
>>> +
>>> +             if (old_src_pll == new_src_pll) {
>>> +                     /* No need to change pll */
>>> +                     clk_set_rate(int_clk->div_clk, tar_rate);
>>> +                     pr_debug("%s: %s now %lu (%lu)\n", __func__,
>>> +                              int_clk->mux_clk_name,
>>> +                              clk_get_rate(int_clk->div_clk), tar_rate);
>>> +                     continue;
>>> +             }
>>> +
>>> +             old_src_rate = clk_get_rate(old_src_pll);
>>> +             new_src_rate = clk_get_rate(new_src_pll);
>>> +             rate1 = clk_get_rate(int_clk->div_clk);
>>> +
>>> +             /*
>>> +              * If we're switching to a faster PLL we should bump up the
>>> +              * divider before switching.
>>> +              */
>>> +             if (new_src_rate > old_src_rate) {
>>> +                     int new_div;
>>> +                     unsigned long tmp_rate;
>>> +
>>> +                     new_div = DIV_ROUND_UP(new_src_rate, tar_rate);
>>> +                     tmp_rate = DIV_ROUND_UP(old_src_rate, new_div);
>>> +                     clk_set_rate(int_clk->div_clk, tmp_rate);
>>> +             }
>>> +             rate2 = clk_get_rate(int_clk->div_clk);
>>> +
>>> +             /* We can safely change the mux now */
>>> +             clk_set_parent(int_clk->mux_clk, new_src_pll);
>>> +             rate3 = clk_get_rate(int_clk->div_clk);
>>> +
>>> +             /*
>>> +              * Give us a proper divider; technically not needed in the case
>>> +              * where we pre-calculated the divider above (the new_src_rate >
>>> +              * old_src_rate case), but let's be formal about it.
>>> +              */
>>> +             clk_set_rate(int_clk->div_clk, tar_rate);
>>> +             rate4 = clk_get_rate(int_clk->div_clk);
>>> +
>>> +             pr_debug("%s: %s => PLL %d; %lu=>%lu=>%lu=>%lu (%lu)\n",
>>> +                      __func__, int_clk->mux_clk_name,
>>> +                      int_clk->clk_info[target_idx].src_pll,
>>> +                      rate1, rate2, rate3, rate4, tar_rate);
>>> +     }
>>> +     return 0;
>>> +}
>>
>> The above function looks like it could be made much more generic and
>> reused for Exynos5250 as well.
> I will look at making it common for the two,
>>
>>> +
>>>  static int exynos5_int_setvolt(struct busfreq_data_int *data,
>>>                               unsigned long volt)
>>>  {
>>> -     return regulator_set_voltage(data->vdd_int, volt, MAX_SAFEVOLT);
>>> +     return regulator_set_voltage(data->vdd_int, volt,
>>> +                             volt + INT_VOLT_STEP_UV);
>>>  }
>>>
>>>  static int exynos5_busfreq_int_target(struct device *dev, unsigned long *_freq,
>>> @@ -218,18 +528,15 @@ static int exynos5_busfreq_int_target(struct device *dev, unsigned long *_freq,
>>>       if (data->disabled)
>>>               goto out;
>>>
>>> -     if (freq > exynos5_int_opp_table[0].clk)
>>> -             pm_qos_update_request(&data->int_req, freq * 16 / 1000);
>>> -     else
>>> -             pm_qos_update_request(&data->int_req, -1);
>>> -
>>>       if (old_freq < freq)
>>>               err = exynos5_int_setvolt(data, volt);
>>>       if (err)
>>>               goto out;
>>>
>>> -     err = exynos5_int_set_rate(data, freq);
>>> -
>>> +     if (data->type == TYPE_BUSF_EXYNOS5250)
>>> +             err = exynos5250_int_set_rate(data, freq);
>>> +     else
>>> +             err = exynos5420_int_set_rate(data, freq, old_freq);
>>>       if (err)
>>>               goto out;
>>>
>>> @@ -267,16 +574,20 @@ static int exynos5_int_get_dev_status(struct device *dev,
>>>  }
>>>
>>>  static struct devfreq_dev_profile exynos5_devfreq_int_profile = {
>>> -     .initial_freq           = 160000,
>>> -     .polling_ms             = 100,
>>> +     .polling_ms             = 10,
>>
>> Another change not mentioned in commit message.
>>
>>>       .target                 = exynos5_busfreq_int_target,
>>>       .get_dev_status         = exynos5_int_get_dev_status,
>>>  };
>>>
>>> -static int exynos5250_init_int_tables(struct busfreq_data_int *data)
>>> +static int exynos5_init_int_tables(struct busfreq_data_int *data)
>>>  {
>>>       int i, err = 0;
>>>
>>> +     if (data->type == TYPE_BUSF_EXYNOS5250)
>>> +             exynos5_int_opp_table = exynos5250_int_opp_table;
>>> +     else
>>> +             exynos5_int_opp_table = exynos5420_int_opp_table;
>>> +
>>>       for (i = LV_0; i < _LV_END; i++) {
>>>               err = dev_pm_opp_add(data->dev, exynos5_int_opp_table[i].clk,
>>>                               exynos5_int_opp_table[i].volt);
>>> @@ -297,6 +608,7 @@ static int exynos5_busfreq_int_pm_notifier_event(struct notifier_block *this,
>>>       struct dev_pm_opp *opp;
>>>       unsigned long maxfreq = ULONG_MAX;
>>>       unsigned long freq;
>>> +     unsigned long old_freq;
>>>       unsigned long volt;
>>>       int err = 0;
>>>
>>> @@ -322,8 +634,14 @@ static int exynos5_busfreq_int_pm_notifier_event(struct notifier_block *this,
>>>               if (err)
>>>                       goto unlock;
>>>
>>> -             err = exynos5_int_set_rate(data, freq);
>>> +             old_freq = data->curr_freq;
>>>
>>> +             if (data->type == TYPE_BUSF_EXYNOS5250)
>>> +                     err = exynos5250_int_set_rate(data, freq);
>>> +             else if (data->type == TYPE_BUSF_EXYNOS5420)
>>> +                     err = exynos5420_int_set_rate(data, freq, old_freq);
>>> +             else
>>> +                     err = -EINVAL;
>>>               if (err)
>>>                       goto unlock;
>>>
>>> @@ -345,16 +663,38 @@ unlock:
>>>       return NOTIFY_DONE;
>>>  }
>>>
>>> +static const struct of_device_id exynos5_busfreq_dt_match[];
>>> +
>>> +static inline int exynos5_busfreq_get_driver_data(struct platform_device *pdev)
>>> +{
>>> +#ifdef CONFIG_OF
>>
>> Exynos is DT-only, so there is no need to handle non-DT cases.
> OK.
>>
>>> +     struct exynos5_busfreq_drv_data *data;
>>> +
>>> +     if (pdev->dev.of_node) {
>>> +             const struct of_device_id *match;
>>> +
>>> +             match = of_match_node(exynos5_busfreq_dt_match,
>>> +                                     pdev->dev.of_node);
>>> +             data = (struct exynos5_busfreq_drv_data *) match->data;
>>> +             return data->busf_type;
>>> +     }
>>> +#endif
>>> +     return platform_get_device_id(pdev)->driver_data;
>>> +}
>>> +
>>>  static int exynos5_busfreq_int_probe(struct platform_device *pdev)
>>>  {
>>>       struct busfreq_data_int *data;
>>>       struct busfreq_ppmu_data *ppmu_data;
>>> +     struct device_node *np = pdev->dev.of_node;
>>>       struct dev_pm_opp *opp;
>>>       struct device *dev = &pdev->dev;
>>> -     struct device_node *np;
>>>       unsigned long initial_freq;
>>>       unsigned long initial_volt;
>>> +     struct clk *mux_clk, *div_clk;
>>> +     struct int_comp_clks *int_pm_clk;
>>>       int err = 0;
>>> +     int nr_clk;
>>>       int i;
>>>
>>>       data = devm_kzalloc(&pdev->dev, sizeof(struct busfreq_data_int),
>>> @@ -364,22 +704,27 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
>>>               return -ENOMEM;
>>>       }
>>>
>>> +     INIT_LIST_HEAD(&data->list);
>>> +     data->type = exynos5_busfreq_get_driver_data(pdev);
>>> +
>>>       ppmu_data = &data->ppmu_data;
>>> -     ppmu_data->ppmu_end = PPMU_END;
>>> +     if (data->type == TYPE_BUSF_EXYNOS5250) {
>>> +             ppmu_data->ppmu_end = PPMU_END_5250;
>>> +     } else if (data->type == TYPE_BUSF_EXYNOS5420) {
>>> +             ppmu_data->ppmu_end = PPMU_END_5420;
>>> +     } else {
>>> +             dev_err(dev, "Cannot determine the device id %d\n", data->type);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>>       ppmu_data->ppmu = devm_kzalloc(dev,
>>> -                                    sizeof(struct exynos_ppmu) * PPMU_END,
>>> -                                    GFP_KERNEL);
>>> +                     sizeof(struct exynos_ppmu) * (ppmu_data->ppmu_end),
>>> +                     GFP_KERNEL);
>>>       if (!ppmu_data->ppmu) {
>>>               dev_err(dev, "Failed to allocate memory for exynos_ppmu\n");
>>>               return -ENOMEM;
>>>       }
>>>
>>> -     np = of_find_compatible_node(NULL, NULL, "samsung,exynos5250-ppmu");
>>> -     if (np == NULL) {
>>> -             pr_err("Unable to find PPMU node\n");
>>> -             return -ENOENT;
>>> -     }
>>
>> This was actually closer to the right solution than what this series
>> does. Actually there was similar attempt already, but for Exynos4 and I
>> even suggested how this could be handled properly. Please see [1] for
>> the whole discussion.
>>
>> [1]
>> https://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg27491.html
> Chanwoo are you working on this for exynos4 ? As far as I can see
> there has been no further effort in adding the  power plane and ppmu
> bindings. So, before I start working on this I wanted to confirm that
> you don't have something in the pipeline.
>
> Tomasz, I have read through the thread and as per your suggestions
> this is how the dt bindings (for my INT use case) would look like:
>
> ppmu_dmc0_0: ppmu@10D00000 {
>         /* Resources of PPMU */
> }
>
> ppmu_dmc0_1: ppmu@10D00000 {
>         /* Resources of PPMU */
> }
>
> ppmu_dmc_1_0: ppmu@10D00000 {
>         /* Resources of PPMU */
> }
>
> power-plane-int {
>         compatible = "exynos5420-int, power-plane";
>         samsung,ppmus = <&ppmu_dmc_0_0>, &ppmu_dmc_0_1>, &ppmu_dmc_1_0>;
>         samsung,devices = ??
>         clock-names = "aclk200_fsys", "pclk200_fsys", "aclk100_noc"...;
>         clocks = <&clock CLK_ACLK200_FSYS2>,...;
>         vdd_int-supply = <&buck3_reg>; /* VDD_INT */
>         operating-points = <
>                                    266000, 1300000
>                                    200000, 1250000
>                                    160000, 1225000
>                                    133000, 1200000
>                                    >;
> };
>
> Here are my doubts regarding this:
> 1) The INT bus consists of several IPs like MFC, DISP, HDMI, ISP etc.
> The 3 PPMUs listed above monitor the load on the TOP block which these
> IPs are a part of. What should be the "samsung, devices" associated
> with it ?
> 2) I have currently listed the virtual INT bus frequencies in
> "operating points" property. So, when there is a high load on the INT
> bus, there would be a request for say a virtual frequency of 266MHz
> which in turn would bump up several clocks (like MFC, DISP etc) to a
> desired level. Is it OK to have the virtual INT bus frequencies listed
> in DT ?
> 3) There are over 10 clocks in 5420 that need to be controlled as part
> of the INT domain. Should all these clocks, parent clocks, hardware
> recommended source PLLs and the recommended clock rates (at each of
> the virtual INT bus frequencies) also be part of the power plane node
> ? So that I parse all these clocks from dt and associate them with
> each of the virtual bus rates. Is that the correct approach ?

Could you please clarify my doubts so that I may take this forward.

Regards,
Abhilash
>>
>>> -
>>>       for (i = 0; i < ppmu_data->ppmu_end; i++) {
>>>               /* map PPMU memory region */
>>>               ppmu_data->ppmu[i].hw_base = of_iomap(np, i);
>>> @@ -388,13 +733,17 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
>>>                       return -ENOMEM;
>>>               }
>>>       }
>>> +
>>>       data->pm_notifier.notifier_call = exynos5_busfreq_int_pm_notifier_event;
>>>       data->dev = dev;
>>>       mutex_init(&data->lock);
>>>
>>> -     err = exynos5250_init_int_tables(data);
>>> -     if (err)
>>> +     err = exynos5_init_int_tables(data);
>>> +     if (err) {
>>> +             dev_err(dev, "Cannot initialize busfreq table %d\n",
>>> +                          data->type);
>>>               return err;
>>> +     }
>>>
>>>       data->vdd_int = devm_regulator_get(dev, "vdd_int");
>>>       if (IS_ERR(data->vdd_int)) {
>>> @@ -402,18 +751,70 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
>>>               return PTR_ERR(data->vdd_int);
>>>       }
>>>
>>> -     for (i = 0; i < ARRAY_SIZE(exynos5_int_clks); i++) {
>>> -             struct int_clk *clk_info = &exynos5_int_clks[i];
>>> +     if (data->type == TYPE_BUSF_EXYNOS5250) {
>>> +             for (i = 0; i < ARRAY_SIZE(exynos5250_int_clks); i++) {
>>> +                     struct int_simple_clk *clk_info =
>>> +                             &exynos5250_int_clks[i];
>>> +
>>> +                     clk_info->clk = devm_clk_get(dev, clk_info->clk_name);
>>> +                     if (IS_ERR(clk_info->clk)) {
>>> +                             dev_err(dev, "Failed to get clock %s\n",
>>> +                                     clk_info->clk_name);
>>> +                             return PTR_ERR(clk_info->clk);
>>> +                     }
>>> +             }
>>> +     } else {
>>> +             data->mout_ipll = devm_clk_get(dev, "mout_ipll");
>>> +             if (IS_ERR(data->mout_ipll)) {
>>> +                     dev_err(dev, "Cannot get clock \"mout_ipll\"\n");
>>> +                     return PTR_ERR(data->mout_ipll);
>>> +             }
>>>
>>> -             clk_info->clk = devm_clk_get(dev, clk_info->clk_name);
>>> -             if (IS_ERR(clk_info->clk)) {
>>> -                     dev_err(dev, "Failed to get clock %s\n",
>>> -                             clk_info->clk_name);
>>> -                     return PTR_ERR(clk_info->clk);
>>> +             data->mout_mpll = devm_clk_get(dev, "mout_mpll");
>>> +             if (IS_ERR(data->mout_mpll)) {
>>> +                     dev_err(dev, "Cannot get clock \"mout_mpll\"\n");
>>> +                     return PTR_ERR(data->mout_mpll);
>>> +             }
>>> +
>>> +             data->mout_dpll = devm_clk_get(dev, "mout_dpll");
>>> +             if (IS_ERR(data->mout_dpll)) {
>>> +                     dev_err(dev, "Cannot get clock \"mout_dpll\"\n");
>>> +                     return PTR_ERR(data->mout_dpll);
>>> +             }
>>> +
>>> +             data->mout_cpll = devm_clk_get(dev, "mout_cpll");
>>> +             if (IS_ERR(data->mout_cpll)) {
>>> +                     dev_err(dev, "Cannot get clock \"mout_cpll\"\n");
>>> +                     return PTR_ERR(data->mout_cpll);
>>> +             }
>>> +
>>> +             for (nr_clk = 0; exynos5420_int_pm_clks[nr_clk] != NULL;
>>> +                                                             nr_clk++) {
>>> +                     int_pm_clk = exynos5420_int_pm_clks[nr_clk];
>>> +                     mux_clk = devm_clk_get(dev, int_pm_clk->mux_clk_name);
>>> +                     if (IS_ERR(mux_clk)) {
>>> +                             dev_err(dev, "Cannot get mux clock: %s\n",
>>> +                                             int_pm_clk->mux_clk_name);
>>> +                             return PTR_ERR(mux_clk);
>>> +                     }
>>> +                     div_clk = devm_clk_get(dev, int_pm_clk->div_clk_name);
>>> +                     if (IS_ERR(div_clk)) {
>>> +                             dev_err(dev, "Cannot get div clock: %s\n",
>>> +                                             int_pm_clk->div_clk_name);
>>> +                             return PTR_ERR(div_clk);
>>> +                     }
>>> +                     int_pm_clk->mux_clk = mux_clk;
>>> +                     int_pm_clk->div_clk = div_clk;
>>> +                     list_add_tail(&int_pm_clk->node, &data->list);
>>
>> All those could be probably handled with an array and a for loop.
>>
>> In general, this patch apparently contains many separate changes and not
>> only is hard to review but also hard to debug potential problems - git
>> bisect has commit granularity.
>>
>> Please refactor the driver step by step first and then add support for
>> new SoC after it has all the needed features.
> You are right. I will first post patches adding dt support for only
> 5250. If that looks good then will add for 5420.
> Thanks for the comprehensive review.
>
> Regards,
> Abhilash
>>
>> Best regards,
>> Tomasz
