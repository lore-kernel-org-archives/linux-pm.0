From: Ricky Liang <jcliang@chromium.org>
Subject: Re: [PATCH 4/4] cpufreq: mt8173: move resources allocation into ->probe()
Date: Mon, 30 Nov 2015 11:02:52 +0800
Message-ID: <CAAJzSMeYKGLkVoh0_zPLpVekQpc2rR5ud9YNCPJxRaJRCNX2nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38265 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbbK3DCy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 29 Nov 2015 22:02:54 -0500
Received: by wmec201 with SMTP id c201so120133210wme.1
        for <linux-pm@vger.kernel.org>; Sun, 29 Nov 2015 19:02:52 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, linaro-kernel@lists.linaro.org, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, "moderated list:ARM/Mediatek SoC..." <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

Hi Pi-Cheng,

On Sun, Nov 29, 2015 at 4:31 PM, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> Since the return value of ->init() of cpufreq driver is not propagated
> to the device driver model now, move resources allocation into
> ->probe() to handle -EPROBE_DEFER properly.
>
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> ---
>  drivers/cpufreq/mt8173-cpufreq.c | 94 ++++++++++++++++++++++++++++------------
>  1 file changed, 67 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> index 9d0fe37..1142625 100644
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
> +
> +struct mtk_cpu_dvfs_info *get_dvfs_info(int cpu)
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
> @@ -510,12 +515,47 @@ static struct cpufreq_driver mt8173_cpufreq_driver = {
>
>  static int mt8173_cpufreq_probe(struct platform_device *pdev)
>  {
> -       int ret;
> +       struct mtk_cpu_dvfs_info *info;
> +       struct list_head *list, *tmp;
> +       int cpu, ret;
> +
> +       for_each_possible_cpu(cpu) {
> +               info = get_dvfs_info(cpu);
> +               if (info)
> +                       continue;
> +
> +               info = kzalloc(sizeof(*info), GFP_KERNEL);
> +               if (!info) {
> +                       ret = -ENOMEM;
> +                       goto release_dvfs_info_list;
> +               }
> +
> +               ret = mtk_cpu_dvfs_info_init(info, cpu);
> +               if (ret) {
> +                       pr_err("%s failed to initialize dvfs info for cpu%d\n",
> +                              __func__, cpu);
> +                       kfree(info);
> +                       goto release_dvfs_info_list;
> +               }
> +
> +               list_add(&info->list_head, &dvfs_info_list);
> +       }
>
>         ret = cpufreq_register_driver(&mt8173_cpufreq_driver);
>         if (ret)
>                 pr_err("failed to register mtk cpufreq driver\n");

I think you want "return ret;" inside the if block.

>
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
> +
>         return ret;
>  }
>
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
