From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: imx: fix regulator_get_optional error handling
Date: Tue, 20 Oct 2015 16:36:12 +0200
Message-ID: <CAFSsGVsH5ut5aB24r4htOBn3jdZqLFoorakpqeK9csZXCSLMsg@mail.gmail.com>
References: <56238131.7010907@web.de>
	<20151020133102.GM14356@pengutronix.de>
	<20151020134404.GA954@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34061 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbbJTOgO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2015 10:36:14 -0400
Received: by wikq8 with SMTP id q8so49605344wik.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2015 07:36:12 -0700 (PDT)
In-Reply-To: <20151020134404.GA954@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Heiner Kallweit <heiner.kallweit@web.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

On Tue, Oct 20, 2015 at 3:44 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Oct 20, 2015 at 03:31:02PM +0200, Sascha Hauer wrote:
>> On Tue, Oct 20, 2015 at 03:12:24PM +0200, Heiner Kallweit wrote:
>> > Properly handle the case that regulator_get_optional returns -EPROBE_DEFER
>> > and ignore other errors.
>> >
>> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> > ---
>> >  drivers/cpufreq/imx6q-cpufreq.c | 17 ++++++++++++-----
>> >  1 file changed, 12 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
>> > index 0bb33dc..67dc81c 100644
>> > --- a/drivers/cpufreq/imx6q-cpufreq.c
>> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
>> > @@ -67,7 +67,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>> >
>> >     /* scaling up?  scale voltage before frequency */
>> >     if (new_freq > old_freq) {
>> > -           if (!IS_ERR(pu_reg)) {
>> > +           if (pu_reg) {
>> >                     ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
>> >                     if (ret) {
>> >                             dev_err(cpu_dev, "failed to scale vddpu up: %d\n", ret);
>> > @@ -124,7 +124,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>> >                     dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
>> >                     ret = 0;
>> >             }
>> > -           if (!IS_ERR(pu_reg)) {
>> > +           if (pu_reg) {
>> >                     ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
>> >                     if (ret) {
>> >                             dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
>> > @@ -195,6 +195,13 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>> >     }
>> >
>> >     pu_reg = regulator_get_optional(cpu_dev, "pu");
>> > +   if (IS_ERR(pu_reg)) {
>> > +           if (PTR_ERR(pu_reg) == -EPROBE_DEFER) {
>> > +                   ret = -EPROBE_DEFER;
>> > +                   goto put_reg;
>> > +           } else
>> > +                   pu_reg = NULL;
>> > +   }
>> >
>> >     soc_reg = regulator_get(cpu_dev, "soc");
>> >     if (IS_ERR(soc_reg)) {
>> > @@ -285,7 +292,7 @@ soc_opp_out:
>> >     ret = regulator_set_voltage_time(soc_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
>> >     if (ret > 0)
>> >             transition_latency += ret * 1000;
>> > -   if (!IS_ERR(pu_reg)) {
>> > +   if (pu_reg) {
>> >             ret = regulator_set_voltage_time(pu_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
>> >             if (ret > 0)
>> >                     transition_latency += ret * 1000;
>> > @@ -325,7 +332,7 @@ out_free_opp:
>> >  put_reg:
>> >     if (!IS_ERR(arm_reg))
>> >             regulator_put(arm_reg);
>> > -   if (!IS_ERR(pu_reg))
>> > +   if (!IS_ERR_OR_NULL(pu_reg))
>> >             regulator_put(pu_reg);
>> >     if (!IS_ERR(soc_reg))
>> >             regulator_put(soc_reg);
>>
>> These checks do not work properly. We assume here that the pointers are
>> correctly initialized, but this is only true for the first probe. After
>> a -EPROBE_DEFER the pointers are still initialized from the previous probe.
>> We either have to jump between the above IS_ERR checks when the middle
>> regulator failed or explicitly set the *_reg variables to some error
>> value on probe enter.
>
> I think my favourite approach would be to go in the direction as
> indicated below. At least it would be easier to review for correctness
> than the current mix of reverse-cleanup and !IS_ERR checks at the end of probe().
>
Agree. Just two remarks regarding pu_reg:
- IMHO the call to regulator_get_optional can return -EPROBE_DEFER as
well and that
  would need to be checked.
- I don't like this "!IS_ERR()" too much every time pu_reg is used.
That's what I addressed
  in my second patch. If you share the opinion this could be addressed
in a separate patch
  to separate the fix from the improvement.

> Sascha
>
> ------------------------------------8<--------------------------------
>
> From 7661b5b5407bfa4d29ba48059819937daaa2fa32 Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Tue, 20 Oct 2015 15:39:05 +0200
> Subject: [PATCH] cpufreq: imx6q: cleanup resource allocation
>
> Put all regulator and clock allocation into a separate function and
> create a corresponding cleanup function. This is easier to review for
> correctness than the current mix of reverse-cleanup and !IS_ERR
> checks at the end of probe().
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 168 +++++++++++++++++++++++++---------------
>  1 file changed, 104 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index ef1fa81..a049d43 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -176,6 +176,101 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
>         .attr = cpufreq_generic_attr,
>  };
>
> +static int imx6q_cpufreq_get_resources(struct platform_device *pdev)
> +{
> +       /*
> +        * Do not use devm_* here. The resources are bound to the
> +        * cpu_dev and not to this drivers platform_device.
> +        */
> +       arm_clk = clk_get(cpu_dev, "arm");
> +       if (IS_ERR(arm_clk))
> +               return PTR_ERR(arm_clk);
> +
> +       pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
> +       if (IS_ERR(pll1_sys_clk))
> +               return PTR_ERR(pll1_sys_clk);
> +
> +       pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
> +       if (IS_ERR(pll1_sw_clk))
> +               return PTR_ERR(pll1_sw_clk);
> +
> +       step_clk = clk_get(cpu_dev, "step");
> +       if (IS_ERR(step_clk))
> +               return PTR_ERR(step_clk);
> +
> +       pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
> +       if (IS_ERR(pll2_pfd2_396m_clk))
> +               return PTR_ERR(pll2_pfd2_396m_clk);
> +
> +       if (of_machine_is_compatible("fsl,imx6ul")) {
> +               pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
> +               if (IS_ERR(pll2_bus_clk))
> +                       return PTR_ERR(pll2_bus_clk);
> +
> +               secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
> +               if (IS_ERR(secondary_sel_clk))
> +                       return PTR_ERR(secondary_sel_clk);
> +       }
> +
> +       arm_reg = regulator_get(cpu_dev, "arm");
> +       if (IS_ERR(arm_reg))
> +               return PTR_ERR(arm_reg);
> +
> +       pu_reg = regulator_get_optional(cpu_dev, "pu");
I think this call can return -EPROBE_DEFER as well.

> +
> +       soc_reg = regulator_get(cpu_dev, "soc");
> +       if (IS_ERR(soc_reg))
> +               return PTR_ERR(soc_reg);
> +
> +       return 0;
> +}
> +
> +
> +static int imx6q_cpufreq_put_resources(struct platform_device *pdev)
> +{
> +       if (!IS_ERR_OR_NULL(arm_reg))
> +               regulator_put(arm_reg);
> +       arm_reg = NULL;
> +
> +       if (!IS_ERR_OR_NULL(pu_reg))
> +               regulator_put(pu_reg);
> +       pu_reg = NULL;
> +
> +       if (!IS_ERR_OR_NULL(soc_reg))
> +               regulator_put(soc_reg);
> +       soc_reg = NULL;
> +
> +       if (!IS_ERR_OR_NULL(arm_clk))
> +               clk_put(arm_clk);
> +       arm_clk = NULL;
> +
> +       if (!IS_ERR_OR_NULL(pll1_sys_clk))
> +               clk_put(pll1_sys_clk);
> +       pll1_sys_clk = NULL;
> +
> +       if (!IS_ERR_OR_NULL(pll1_sw_clk))
> +               clk_put(pll1_sw_clk);
> +       pll1_sw_clk = NULL;
> +
> +       if (!IS_ERR_OR_NULL(step_clk))
> +               clk_put(step_clk);
> +       step_clk = NULL;
> +
> +       if (!IS_ERR_OR_NULL(pll2_pfd2_396m_clk))
> +               clk_put(pll2_pfd2_396m_clk);
> +       pll2_pfd2_396m_clk = NULL;
> +
> +       if (!IS_ERR_OR_NULL(pll2_bus_clk))
> +               clk_put(pll2_bus_clk);
> +       pll2_bus_clk = NULL;
> +
> +       if (!IS_ERR_OR_NULL(secondary_sel_clk))
> +               clk_put(secondary_sel_clk);
> +       secondary_sel_clk = NULL;
> +
> +
> +}
> +
>  static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  {
>         struct device_node *np;
> @@ -198,36 +293,9 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>                 return -ENOENT;
>         }
>
> -       arm_clk = clk_get(cpu_dev, "arm");
> -       pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
> -       pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
> -       step_clk = clk_get(cpu_dev, "step");
> -       pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
> -       if (IS_ERR(arm_clk) || IS_ERR(pll1_sys_clk) || IS_ERR(pll1_sw_clk) ||
> -           IS_ERR(step_clk) || IS_ERR(pll2_pfd2_396m_clk)) {
> -               dev_err(cpu_dev, "failed to get clocks\n");
> -               ret = -ENOENT;
> -               goto put_clk;
> -       }
> -
> -       if (of_machine_is_compatible("fsl,imx6ul")) {
> -               pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
> -               secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
> -               if (IS_ERR(pll2_bus_clk) || IS_ERR(secondary_sel_clk)) {
> -                       dev_err(cpu_dev, "failed to get clocks specific to imx6ul\n");
> -                       ret = -ENOENT;
> -                       goto put_clk;
> -               }
> -       }
> -
> -       arm_reg = regulator_get(cpu_dev, "arm");
> -       pu_reg = regulator_get_optional(cpu_dev, "pu");
> -       soc_reg = regulator_get(cpu_dev, "soc");
> -       if (IS_ERR(arm_reg) || IS_ERR(soc_reg)) {
> -               dev_err(cpu_dev, "failed to get regulators\n");
> -               ret = -ENOENT;
> -               goto put_reg;
> -       }
> +       ret = imx6q_cpufreq_get_resources(pdev);
> +       if (ret)
> +               goto drop_resources;
>
>         /*
>          * We expect an OPP table supplied by platform.
> @@ -239,7 +307,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>                 ret = dev_pm_opp_of_add_table(cpu_dev);
>                 if (ret < 0) {
>                         dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
> -                       goto put_reg;
> +                       goto drop_resources;
>                 }
>
>                 /* Because we have added the OPPs here, we must free them */
> @@ -347,28 +415,9 @@ free_freq_table:
>  out_free_opp:
>         if (free_opp)
>                 dev_pm_opp_of_remove_table(cpu_dev);
> -put_reg:
> -       if (!IS_ERR(arm_reg))
> -               regulator_put(arm_reg);
> -       if (!IS_ERR(pu_reg))
> -               regulator_put(pu_reg);
> -       if (!IS_ERR(soc_reg))
> -               regulator_put(soc_reg);
> -put_clk:
> -       if (!IS_ERR(arm_clk))
> -               clk_put(arm_clk);
> -       if (!IS_ERR(pll1_sys_clk))
> -               clk_put(pll1_sys_clk);
> -       if (!IS_ERR(pll1_sw_clk))
> -               clk_put(pll1_sw_clk);
> -       if (!IS_ERR(step_clk))
> -               clk_put(step_clk);
> -       if (!IS_ERR(pll2_pfd2_396m_clk))
> -               clk_put(pll2_pfd2_396m_clk);
> -       if (!IS_ERR(pll2_bus_clk))
> -               clk_put(pll2_bus_clk);
> -       if (!IS_ERR(secondary_sel_clk))
> -               clk_put(secondary_sel_clk);
> +drop_resources:
> +       imx6q_cpufreq_put_resources();
> +
>         of_node_put(np);
>         return ret;
>  }
> @@ -379,17 +428,8 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
>         dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
>         if (free_opp)
>                 dev_pm_opp_of_remove_table(cpu_dev);
> -       regulator_put(arm_reg);
> -       if (!IS_ERR(pu_reg))
> -               regulator_put(pu_reg);
> -       regulator_put(soc_reg);
> -       clk_put(arm_clk);
> -       clk_put(pll1_sys_clk);
> -       clk_put(pll1_sw_clk);
> -       clk_put(step_clk);
> -       clk_put(pll2_pfd2_396m_clk);
> -       clk_put(pll2_bus_clk);
> -       clk_put(secondary_sel_clk);
> +
> +       imx6q_cpufreq_put_resources();
>
>         return 0;
>  }
> --
> 2.6.1
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
