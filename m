From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v2] cpufreq: mt8173: move resources allocation into ->probe()
Date: Mon, 7 Dec 2015 10:44:42 +0800
Message-ID: <CAGS+omBwHVAARNA=ZwK+fAwfJye6eDnxoKW6qCaH_haqsw9PJA@mail.gmail.com>
References: <1448785898-17838-4-git-send-email-pi-cheng.chen@linaro.org> <1449295306-9222-1-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34681 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775AbbLGCpD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 6 Dec 2015 21:45:03 -0500
Received: by vkbs1 with SMTP id s1so94752538vkb.1
        for <linux-pm@vger.kernel.org>; Sun, 06 Dec 2015 18:45:02 -0800 (PST)
In-Reply-To: <1449295306-9222-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Ricky Liang <jcliang@chromium.org>, linux-mediatek@lists.infradead.org, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

Hi Pi-Cheng,

On Sat, Dec 5, 2015 at 2:01 PM, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> Since the return value of ->init() of cpufreq driver is not propagated
> to the device driver model now, move resources allocation into
> ->probe() to handle -EPROBE_DEFER properly.
>
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> ---
> v1->v2:
> - fix error handling path in ->probe()
> ---
>  drivers/cpufreq/mt8173-cpufreq.c | 98 ++++++++++++++++++++++++++++------------
>  1 file changed, 70 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> index 9d0fe37..257bcb9 100644
> --- a/drivers/cpufreq/mt8173-cpufreq.c
> +++ b/drivers/cpufreq/mt8173-cpufreq.c
> @@ -41,16 +41,35 @@
>   * the original PLL becomes stable at target frequency.
>   */
>  struct mtk_cpu_dvfs_info {
> +       struct cpumask cpus;
>         struct device *cpu_dev;
>         struct regulator *proc_reg;
>         struct regulator *sram_reg;
>         struct clk *cpu_clk;
>         struct clk *inter_clk;
>         struct thermal_cooling_device *cdev;
> +       struct list_head list_head;
>         int intermediate_voltage;
>         bool need_voltage_tracking;
>  };
>
> +static LIST_HEAD(dvfs_info_list);

This struct is specific to this driver, so:

mtk_cpu_dvfs_info_list

> +
> +struct mtk_cpu_dvfs_info *get_dvfs_info(int cpu)

static

Also, it would be clearer to name this function something like
"mtk_cpu_dfs_info_lookup" since "mtk_cpu_dfs_info" is the type this
function looks up in the list.
It would also match the other functions such as "mtk_cpu_dvfs_info_init()".

> +{
> +       struct mtk_cpu_dvfs_info *info;
> +       struct list_head *list;
> +
> +       list_for_each(list, &dvfs_info_list) {
> +               info = list_entry(list, struct mtk_cpu_dvfs_info, list_head);
> +
> +               if (cpumask_test_cpu(cpu, &info->cpus))
> +                       return info;
> +       }
> +
> +       return NULL;
> +}
> +
>  static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>                                         int new_vproc)
>  {
> @@ -402,6 +421,9 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>          */
>         info->need_voltage_tracking = !IS_ERR(sram_reg);
>
> +       /* CPUs in the same cluster share a clock and power domain. */
> +       cpumask_copy(&info->cpus, &cpu_topology[cpu].core_sibling);
> +
>         return 0;
>
>  out_free_opp_table:
> @@ -440,47 +462,32 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>         struct cpufreq_frequency_table *freq_table;
>         int ret;
>
> -       info = kzalloc(sizeof(*info), GFP_KERNEL);
> -       if (!info)
> -               return -ENOMEM;
> -
> -       ret = mtk_cpu_dvfs_info_init(info, policy->cpu);
> -       if (ret) {
> -               pr_err("%s failed to initialize dvfs info for cpu%d\n",
> -                      __func__, policy->cpu);
> -               goto out_free_dvfs_info;
> +       info = get_dvfs_info(policy->cpu);
> +       if (!info) {
> +               pr_err("dvfs info for cpu%d is not initialized.\n",
> +                      policy->cpu);
> +               return -EINVAL;
>         }
>
>         ret = dev_pm_opp_init_cpufreq_table(info->cpu_dev, &freq_table);

Hmm. Does this change at init() time?  Or can we move this to probe(), too?

>         if (ret) {
>                 pr_err("failed to init cpufreq table for cpu%d: %d\n",
>                        policy->cpu, ret);
> -               goto out_release_dvfs_info;
> +               return ret;
>         }
>
>         ret = cpufreq_table_validate_and_show(policy, freq_table);
>         if (ret) {
>                 pr_err("%s: invalid frequency table: %d\n", __func__, ret);
> -               goto out_free_cpufreq_table;
> +               dev_pm_opp_free_cpufreq_table(info->cpu_dev, &freq_table);
> +               return ret;

If dev_pm_opp_init_cpufreq_table() really is needed at init() time,
then please don't change this; still use "goto out_free_cpufreq_table"
here.

>         }
>
> -       /* CPUs in the same cluster share a clock and power domain. */
> -       cpumask_copy(policy->cpus, &cpu_topology[policy->cpu].core_sibling);
> +       cpumask_copy(policy->cpus, &info->cpus);
>         policy->driver_data = info;
>         policy->clk = info->cpu_clk;
>
>         return 0;
> -
> -out_free_cpufreq_table:
> -       dev_pm_opp_free_cpufreq_table(info->cpu_dev, &freq_table);
> -
> -out_release_dvfs_info:
> -       mtk_cpu_dvfs_info_release(info);
> -
> -out_free_dvfs_info:
> -       kfree(info);
> -
> -       return ret;
>  }
>
>  static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
> @@ -489,8 +496,6 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
>
>         cpufreq_cooling_unregister(info->cdev);
>         dev_pm_opp_free_cpufreq_table(info->cpu_dev, &policy->freq_table);
> -       mtk_cpu_dvfs_info_release(info);
> -       kfree(info);
>
>         return 0;
>  }
> @@ -510,11 +515,48 @@ static struct cpufreq_driver mt8173_cpufreq_driver = {
>
>  static int mt8173_cpufreq_probe(struct platform_device *pdev)
>  {
> -       int ret;
> +       struct mtk_cpu_dvfs_info *info;
> +       struct list_head *list, *tmp;
> +       int cpu, ret;
> +
> +       for_each_possible_cpu(cpu) {

Is there an iterator for cpu clusters?  Would be useful here.

Or, even better:
 * Is there a way to way to map cpu to cpu cluster ID?
 * Is there a way to count the number of clusters?
If so you can just use an array of mtk_cpu_dvfs_info, and use a cpu's
cluster ID as its index into the array.

> +               info = get_dvfs_info(cpu);
> +               if (info)
> +                       continue;

How could this ever return non-NULL?
This is probe; it won't be called twice - not unless a prior probe()
failed (and/or after .remove()), right?

> +
> +               info = kzalloc(sizeof(*info), GFP_KERNEL);

devm_kzalloc() (and you can then remove the kfree()'s below).

> +               if (!info) {
> +                       ret = -ENOMEM;
> +                       goto release_dvfs_info_list;
> +               }
> +
> +               ret = mtk_cpu_dvfs_info_init(info, cpu);
> +               if (ret) {
> +                       pr_err("%s failed to initialize dvfs info for cpu%d\n",
> +                              __func__, cpu);

dev_err(&pdev->dev, ) here and elsewhere.

-Dan

> +                       kfree(info);
> +                       goto release_dvfs_info_list;
> +               }
> +
> +               list_add(&info->list_head, &dvfs_info_list);
> +       }
>
>         ret = cpufreq_register_driver(&mt8173_cpufreq_driver);
> -       if (ret)
> +       if (ret) {
>                 pr_err("failed to register mtk cpufreq driver\n");
> +               goto release_dvfs_info_list;
> +       }
> +
> +       return 0;
> +
> +release_dvfs_info_list:
> +       list_for_each_safe(list, tmp, &dvfs_info_list) {
> +               info = list_entry(list, struct mtk_cpu_dvfs_info, list_head);
> +
> +               mtk_cpu_dvfs_info_release(info);
> +               list_del(list);
> +               kfree(info);
> +       }
>
>         return ret;
>  }
> --
> 1.9.1
>
