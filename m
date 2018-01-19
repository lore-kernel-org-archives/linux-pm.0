From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v3 2/2] thermal: cpu_cooling: use power models from the
 OPP library
Date: Fri, 19 Jan 2018 15:15:41 -0800
Message-ID: <CAJWu+orOoq3uKeaBnTjS+PytwXS3MwK+gasOCLNqj+QxXXZ7Ug@mail.gmail.com>
References: <20180119094549.5468-1-quentin.perret@arm.com> <20180119094549.5468-3-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37673 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeASXPn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jan 2018 18:15:43 -0500
Received: by mail-yb0-f195.google.com with SMTP id p83so1206355yba.4
        for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2018 15:15:43 -0800 (PST)
In-Reply-To: <20180119094549.5468-3-quentin.perret@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Todd Kjos <tkjos@google.com>

Hi,

On Fri, Jan 19, 2018 at 1:45 AM, Quentin Perret <quentin.perret@arm.com> wrote:
> Now that the OPP library features a power estimator, the existing code
> in IPA can be modified to rely only on dev_pm_opp_get_power() without
> having to care about the dynamic-power-coefficient DT binding.
>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
[..]
>   */
>  static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
> -                            u32 capacitance)
> +                            bool *found_power)
>  {
>         struct freq_table *freq_table = cpufreq_cdev->freq_table;
>         struct dev_pm_opp *opp;
> @@ -225,11 +226,10 @@ static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
>                 return -EINVAL;
>         }
>
> +       *found_power = true;
> +
>         for (i = 0; i <= cpufreq_cdev->max_level; i++) {
> -               unsigned long freq = freq_table[i].frequency * 1000;
> -               u32 freq_mhz = freq_table[i].frequency / 1000;
> -               u64 power;
> -               u32 voltage_mv;
> +               unsigned long power, freq = freq_table[i].frequency * 1000;
>
>                 /*
>                  * Find ceil frequency as 'freq' may be slightly lower than OPP
> @@ -242,18 +242,12 @@ static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
>                         return -EINVAL;
>                 }
>
> -               voltage_mv = dev_pm_opp_get_voltage(opp) / 1000;
> -               dev_pm_opp_put(opp);
> -
> -               /*
> -                * Do the multiplication with MHz and millivolt so as
> -                * to not overflow.
> -                */
> -               power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
> -               do_div(power, 1000000000);
> -
>                 /* power is stored in mW */
> +               power = dev_pm_opp_get_power(opp) / 1000;
> +               dev_pm_opp_put(opp);
>                 freq_table[i].power = power;
> +               if (!power)
> +                       *found_power = false;
>         }
>
>         return 0;
> @@ -594,7 +588,6 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
>   * @np: a valid struct device_node to the cooling device device tree node
>   * @policy: cpufreq policy
>   * Normally this should be same as cpufreq policy->related_cpus.
> - * @capacitance: dynamic power coefficient for these cpus
>   *
>   * This interface function registers the cpufreq cooling device with the name
>   * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
> @@ -606,7 +599,7 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
>   */
>  static struct thermal_cooling_device *
>  __cpufreq_cooling_register(struct device_node *np,
> -                       struct cpufreq_policy *policy, u32 capacitance)
> +                       struct cpufreq_policy *policy)
>  {
>         struct thermal_cooling_device *cdev;
>         struct cpufreq_cooling_device *cpufreq_cdev;
> @@ -614,7 +607,7 @@ __cpufreq_cooling_register(struct device_node *np,
>         unsigned int freq, i, num_cpus;
>         int ret;
>         struct thermal_cooling_device_ops *cooling_ops;
> -       bool first;
> +       bool first, found_power;
>
>         if (IS_ERR_OR_NULL(policy)) {
>                 pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
> @@ -675,18 +668,15 @@ __cpufreq_cooling_register(struct device_node *np,
>                         pr_debug("%s: freq:%u KHz\n", __func__, freq);
>         }
>
> -       if (capacitance) {
> -               ret = update_freq_table(cpufreq_cdev, capacitance);
> -               if (ret) {
> -                       cdev = ERR_PTR(ret);
> -                       goto remove_ida;
> -               }
> -
> -               cooling_ops = &cpufreq_power_cooling_ops;
> -       } else {
> -               cooling_ops = &cpufreq_cooling_ops;

Instead of this, is it better to add an API to OPP library to query it
if it has power data for all OPPs? Then you don't need to have a
'found_power' variable and also don't unnecessarily call
dev_pm_opp_find_freq_ceil in update_freq_table.

> +       ret = update_freq_table(cpufreq_cdev, &found_power);
> +       if (ret) {
> +               cdev = ERR_PTR(ret);
> +               goto remove_ida;
>         }
[..]

Thanks,

- Joel
