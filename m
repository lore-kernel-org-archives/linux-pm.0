From: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Tue, 23 Jun 2015 23:25:52 +0800
Message-ID: <CALx668VmT+90y712QO4JQCh-nTCxStWYY+ygJ_1KiVN7VnmmpQ@mail.gmail.com>
References: <1433766561-1330-1-git-send-email-pi-cheng.chen@linaro.org>
	<1433766561-1330-3-git-send-email-pi-cheng.chen@linaro.org>
	<20150622114511.GA28340@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150622114511.GA28340@linux>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On Mon, Jun 22, 2015 at 7:45 PM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 08-06-15, 20:29, Pi-Cheng Chen wrote:
>
> Sorry for the delay, I have been quite busy recently.

That's fine. Thanks for reviewing.

>
>> +++ b/drivers/cpufreq/mt8173-cpufreq.c
>> +static LIST_HEAD(cpu_dvfs_info_list);
>> +
>> +static inline struct mtk_cpu_dvfs_info *to_mtk_cpu_dvfs_info(
>> +                     struct list_head *list)
>> +{
>> +     return list_entry(list, struct mtk_cpu_dvfs_info, node);
>> +}
>> +
>> +static inline void mtk_cpu_dvfs_info_add(struct mtk_cpu_dvfs_info *info)
>> +{
>> +     list_add(&info->node, &cpu_dvfs_info_list);
>> +}
>
> No stupid wrappers please. Doesn't make anything better.

Will remove it.

>
>> +
>> +static struct mtk_cpu_dvfs_info *mtk_cpu_dvfs_info_get(int cpu)
>
> A very bad name to a routine with very specific functionality.

Would get_mtk_cpu_dvfs_info() or cpu_to_mtk_cpu_dvfs_info() be better?

>
>> +{
>> +     struct mtk_cpu_dvfs_info *info;
>> +     struct list_head *list;
>> +
>> +     list_for_each(list, &cpu_dvfs_info_list) {
>> +             info = to_mtk_cpu_dvfs_info(list);
>> +
>> +             if (cpumask_test_cpu(cpu, info->cpus))
>> +                     return info;
>> +     }
>> +
>> +     return NULL;
>> +}
>> +
>> +static void mtk_cpu_dvfs_info_release(void)
>> +{
>> +     struct list_head *list, *tmp;
>> +     struct mtk_cpu_dvfs_info *info;
>> +
>> +     list_for_each_safe(list, tmp, &cpu_dvfs_info_list) {
>> +             info = to_mtk_cpu_dvfs_info(list);
>> +
>> +             dev_pm_opp_free_cpufreq_table(info->cpu_dev,
>> +                                           &info->freq_table);
>> +
>> +             if (!IS_ERR(info->proc_reg))
>> +                     regulator_put(info->proc_reg);
>> +             if (!IS_ERR(info->sram_reg))
>> +                     regulator_put(info->sram_reg);
>> +             if (!IS_ERR(info->cpu_clk))
>> +                     clk_put(info->cpu_clk);
>> +             if (!IS_ERR(info->inter_clk))
>> +                     clk_put(info->inter_clk);
>> +
>> +             of_free_opp_table(info->cpu_dev);
>> +
>> +             list_del(list);
>> +             kfree(info);
>> +     }
>> +}
>> +
>> +#define MIN(a, b) ((a) < (b) ? (a) : (b))
>> +#define MAX(a, b) ((a) > (b) ? (a) : (b))
>
> Look for these in kernel.h

Thanks for pointing me out this file.
I tried to looking for those macro in the kernel tree but didn't find them.
Will use those in kernel.h instead.

>
>> +static int mtk_cpufreq_set_voltage(struct mtk_cpu_dvfs_info *info, int vproc)
>> +{
>> +     if (info->need_voltage_trace)
>> +             return mtk_cpufreq_voltage_trace(info, vproc);
>> +     else
>> +             return regulator_set_voltage(info->proc_reg, vproc,
>> +                                          vproc + VOLT_TOL);
>> +}
>> +
>> +static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>> +                               unsigned int index)
>> +{
>> +     struct cpufreq_frequency_table *freq_table = policy->freq_table;
>> +     struct clk *cpu_clk = policy->clk;
>> +     struct clk *armpll = clk_get_parent(cpu_clk);
>> +     struct mtk_cpu_dvfs_info *info = policy->driver_data;
>> +     struct device *cpu_dev = info->cpu_dev;
>> +     struct dev_pm_opp *opp;
>> +     long freq_hz, old_freq_hz;
>> +     int vproc, old_vproc, inter_vproc, target_vproc, ret;
>> +
>> +     inter_vproc = info->intermediate_voltage;
>> +
>> +     old_freq_hz = clk_get_rate(cpu_clk);
>> +     old_vproc = regulator_get_voltage(info->proc_reg);
>> +
>> +     freq_hz = freq_table[index].frequency * 1000;
>
> A blank line here.

Will remove it.

>
>> +     rcu_read_lock();
>> +     opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
>> +     if (IS_ERR(opp)) {
>> +             rcu_read_unlock();
>> +             pr_err("cpu%d: failed to find OPP for %ld\n",
>> +                    policy->cpu, freq_hz);
>> +             return PTR_ERR(opp);
>> +     }
>> +     vproc = dev_pm_opp_get_voltage(opp);
>> +     rcu_read_unlock();
>> +
>> +     /*
>> +      * If the new voltage or the intermediate voltage is higher than the
>> +      * current voltage, scale up voltage first.
>> +      */
>> +     target_vproc = (inter_vproc > vproc) ? inter_vproc : vproc;
>> +     if (old_vproc < target_vproc) {
>> +             ret = mtk_cpufreq_set_voltage(info, target_vproc);
>> +             if (ret) {
>> +                     pr_err("cpu%d: failed to scale up voltage!\n",
>> +                            policy->cpu);
>> +                     mtk_cpufreq_set_voltage(info, old_vproc);
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     /* Reparent the CPU clock to intermediate clock. */
>> +     ret = clk_set_parent(cpu_clk, info->inter_clk);
>> +     if (ret) {
>> +             pr_err("cpu%d: failed to re-parent cpu clock!\n",
>> +                    policy->cpu);
>> +             mtk_cpufreq_set_voltage(info, old_vproc);
>> +             WARN_ON(1);
>> +             return ret;
>> +     }
>> +
>> +     /* Set the original PLL to target rate. */
>> +     ret = clk_set_rate(armpll, freq_hz);
>> +     if (ret) {
>> +             pr_err("cpu%d: failed to scale cpu clock rate!\n",
>> +                    policy->cpu);
>> +             clk_set_parent(cpu_clk, armpll);
>> +             mtk_cpufreq_set_voltage(info, old_vproc);
>> +             return ret;
>> +     }
>> +
>> +     /* Set parent of CPU clock back to the original PLL. */
>> +     ret = clk_set_parent(cpu_clk, armpll);
>> +     if (ret) {
>> +             pr_err("cpu%d: failed to re-parent cpu clock!\n",
>> +                    policy->cpu);
>> +             mtk_cpufreq_set_voltage(info, inter_vproc);
>> +             WARN_ON(1);
>> +             return ret;
>> +     }
>> +
>> +     /*
>> +      * If the new voltage is lower than the intermediate voltage or the
>> +      * original voltage, scale down to the new voltage.
>> +      */
>> +     if (vproc < inter_vproc || vproc < old_vproc) {
>> +             ret = mtk_cpufreq_set_voltage(info, vproc);
>> +             if (ret) {
>> +                     pr_err("cpu%d: failed to scale down voltage!\n",
>> +                            policy->cpu);
>> +                     clk_set_parent(cpu_clk, info->inter_clk);
>> +                     clk_set_rate(armpll, old_freq_hz);
>> +                     clk_set_parent(cpu_clk, armpll);
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>> +{
>> +     struct mtk_cpu_dvfs_info *info;
>> +     int ret;
>> +
>> +     info = mtk_cpu_dvfs_info_get(policy->cpu);
>> +     if (!info) {
>> +             pr_err("%s: mtk cpu dvfs info for cpu%d is not initialized\n",
>> +                    __func__, policy->cpu);
>> +             return -ENODEV;
>> +     }
>> +
>> +     ret = cpufreq_table_validate_and_show(policy, info->freq_table);
>> +     if (ret) {
>> +             pr_err("%s: invalid frequency table: %d\n", __func__, ret);
>> +             return ret;
>> +     }
>> +
>> +     cpumask_copy(policy->cpus, info->cpus);
>> +     policy->driver_data = info;
>> +     policy->clk = info->cpu_clk;
>> +
>> +     return 0;
>> +}
>> +
>> +static struct cpufreq_driver mt8173_cpufreq_driver = {
>> +     .flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
>> +     .verify = cpufreq_generic_frequency_table_verify,
>> +     .target_index = mtk_cpufreq_set_target,
>> +     .get = cpufreq_generic_get,
>> +     .init = mtk_cpufreq_init,
>> +     .name = "mtk-cpufreq",
>> +     .attr = cpufreq_generic_attr,
>> +};
>> +
>> +static int mtk_cpu_dvfs_info_init(int cpu)
>> +{
>> +     struct device *cpu_dev;
>> +     struct regulator *proc_reg = ERR_PTR(-ENODEV);
>> +     struct regulator *sram_reg = ERR_PTR(-ENODEV);
>> +     struct clk *cpu_clk = ERR_PTR(-ENODEV);
>> +     struct clk *inter_clk = ERR_PTR(-ENODEV);
>> +     struct mtk_cpu_dvfs_info *info;
>> +     struct cpufreq_frequency_table *freq_table;
>> +     struct dev_pm_opp *opp;
>> +     unsigned long rate;
>> +     int ret;
>> +
>> +     cpu_dev = get_cpu_device(cpu);
>> +     if (!cpu_dev) {
>> +             pr_err("failed to get cpu%d device\n", cpu);
>> +             return -ENODEV;
>> +     }
>> +
>> +     ret = of_init_opp_table(cpu_dev);
>> +     if (ret) {
>> +             pr_warn("no OPP table for cpu%d\n", cpu);
>> +             return ret;
>> +     }
>> +
>> +     cpu_clk = clk_get(cpu_dev, "cpu");
>> +     if (IS_ERR(cpu_clk)) {
>> +             if (PTR_ERR(cpu_clk) == -EPROBE_DEFER)
>> +                     pr_warn("cpu clk for cpu%d not ready, retry.\n", cpu);
>> +             else
>> +                     pr_err("failed to get cpu clk for cpu%d\n", cpu);
>> +
>> +             ret = PTR_ERR(cpu_clk);
>> +             goto out_free_opp_table;
>> +     }
>> +
>> +     inter_clk = clk_get(cpu_dev, "intermediate");
>> +     if (IS_ERR(inter_clk)) {
>> +             if (PTR_ERR(inter_clk) == -EPROBE_DEFER)
>> +                     pr_warn("intermediate clk for cpu%d not ready, retry.\n",
>> +                             cpu);
>> +             else
>> +                     pr_err("failed to get intermediate clk for cpu%d\n",
>> +                            cpu);
>> +
>> +             ret = PTR_ERR(cpu_clk);
>> +             goto out_free_resources;
>> +     }
>> +
>> +     proc_reg = regulator_get_exclusive(cpu_dev, "proc");
>> +     if (IS_ERR(proc_reg)) {
>> +             if (PTR_ERR(proc_reg) == -EPROBE_DEFER)
>> +                     pr_warn("proc regulator for cpu%d not ready, retry.\n",
>> +                             cpu);
>> +             else
>> +                     pr_err("failed to get proc regulator for cpu%d\n",
>> +                            cpu);
>> +
>> +             ret = PTR_ERR(proc_reg);
>> +             goto out_free_resources;
>> +     }
>> +
>> +     /* Both presence and absence of sram regulator are valid cases. */
>> +     sram_reg = regulator_get_exclusive(cpu_dev, "sram");
>> +
>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +     if (!info) {
>> +             ret = -ENOMEM;
>> +             goto out_free_resources;
>> +     }
>> +
>> +     ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
>> +     if (ret) {
>> +             pr_err("failed to init cpufreq table for cpu%d: %d\n",
>> +                    cpu, ret);
>> +             goto out_free_mtk_cpu_dvfs_info;
>> +     }
>> +
>> +     if (!alloc_cpumask_var(&info->cpus, GFP_KERNEL))
>
> Why getting into such trouble? What about just saving policy's pointer
> in info and use it for freq_table, cpus mask, etc ?

This function is called from driver probe function. At this moment, cpufreq
driver is not yet registered and the policy struct for each cluster is not yet
allocated.

Also, the mtk_cpu_dvfs_info structs for all clusters are stored in a list
after probe done. cpus mask is used to find out the proper info struct
for corresponding cpu.

For freq_table, I simply don't want to free and allocate the table
every time when cpu is unplugged and plugged so I just allocate it
in the probe function call path, and cache it in the info struct.

>
>> +             goto out_free_cpufreq_table;
>> +
>
>> +}
>> +
>> +static int mt8173_cpufreq_probe(struct platform_device *pdev)
>> +{
>> +     int cpu, ret;
>> +
>> +     for_each_possible_cpu(cpu) {
>> +             /*
>> +              * If the struct mtk_cpu_dvfs_info for the cpu power domain
>> +              * is already initialized, skip this CPU.
>> +              */
>> +             if (!mtk_cpu_dvfs_info_get(cpu)) {
>> +                     ret = mtk_cpu_dvfs_info_init(cpu);
>> +                     if (ret) {
>> +                             if (ret != -EPROBE_DEFER)
>> +                                     pr_err("%s probe fail\n", __func__);
>> +
>> +                             mtk_cpu_dvfs_info_release();
>> +                             return ret;
>> +                     }
>> +             }
>> +     }
>> +
>> +     ret = cpufreq_register_driver(&mt8173_cpufreq_driver);
>> +     if (ret) {
>> +             pr_err("failed to register mtk cpufreq driver\n");
>> +             mtk_cpu_dvfs_info_release();
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static struct platform_driver mt8173_cpufreq_platdrv = {
>> +     .driver = {
>> +             .name   = "mt8173-cpufreq",
>> +     },
>> +     .probe          = mt8173_cpufreq_probe,
>> +};
>> +module_platform_driver(mt8173_cpufreq_platdrv);
>> +
>> +static int mt8173_cpufreq_driver_init(void)
>> +{
>> +     struct platform_device *pdev;
>> +
>> +     if (!of_machine_is_compatible("mediatek,mt8173"))
>> +             return -ENODEV;
>> +
>> +     pdev = platform_device_register_simple("mt8173-cpufreq", -1, NULL, 0);
>> +     if (IS_ERR(pdev)) {
>> +             pr_err("failed to register mtk-cpufreq platform device\n");
>> +             return PTR_ERR(pdev);
>> +     }
>> +
>> +     return 0;
>> +}
>> +module_init(mt8173_cpufreq_driver_init);
>
> Can this driver be built as module? Why this module* crap all over the
> place?

As mentioned in previous comment from Paul Bolle, it should be better
to do device_initcall(mt8173_cpufreq_driver_inint) instead of
module_init(mt8173_cpufreq_driver_init). I will do it.

But for module_platform_driver(mt8173_cpufreq_platdrv), I saw many
built-in drivers in kernel call module_platform_driver() also so I use it.
Would it be better to use platform_driver_register() instead?

Thanks.
Pi-Cheng

>
> --
> viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
