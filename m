From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
Date: Wed, 4 Mar 2015 16:39:21 +0530
Message-ID: <CAKohpo=c2t4_2hdPP-vQM7xewK5SXaHBGNA9PhvTwDv3++pSTg@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
	<1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:40504 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288AbbCDLJV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2015 06:09:21 -0500
Received: by oiba3 with SMTP id a3so4960271oib.7
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2015 03:09:21 -0800 (PST)
In-Reply-To: <1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "pi-cheng.chen" <pi-cheng.chen@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mike Turquette <mturquette@linaro.org>, fan.chen@mediatek.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Haven't reviewed it completely yet, but this is all I have done.

On 4 March 2015 at 14:19, pi-cheng.chen <pi-cheng.chen@linaro.org> wrote:

> +static int mtk_cpufreq_notify(struct notifier_block *nb,
> +                             unsigned long action, void *data)
> +{
> +       struct cpufreq_freqs *freqs = data;
> +       struct cpu_opp_table *opp_tbl = dvfs_info->opp_tbl;

There is only one dvfs info ? but there are two clusters, sorry got confused
a bit..

> +       int old_vproc, new_vproc, old_index, new_index;
> +
> +       if (!cpumask_test_cpu(freqs->cpu, &dvfs_info->cpus))
> +               return NOTIFY_DONE;
> +
> +       old_vproc = regulator_get_voltage(dvfs_info->proc_reg);
> +       old_index = cpu_opp_table_get_volt_index(old_vproc);
> +       new_index = cpu_opp_table_get_freq_index(freqs->new * 1000);
> +       new_vproc = opp_tbl[new_index].vproc;
> +
> +       if (old_vproc == new_vproc)
> +               return 0;
> +
> +       if ((action == CPUFREQ_PRECHANGE && old_vproc < new_vproc) ||
> +           (action == CPUFREQ_POSTCHANGE && old_vproc > new_vproc))
> +               mtk_cpufreq_voltage_trace(old_index, new_index);
> +
> +       return NOTIFY_OK;
> +}
> +
> +static struct notifier_block mtk_cpufreq_nb = {
> +       .notifier_call = mtk_cpufreq_notify,
> +};
> +
> +static int cpu_opp_table_init(struct device *dev)
> +{
> +       struct device *cpu_dev = dvfs_info->cpu_dev;
> +       struct cpu_opp_table *opp_tbl;
> +       struct dev_pm_opp *opp;
> +       int ret, cnt, i;
> +       unsigned long rate, vproc, vsram;
> +
> +       ret = of_init_opp_table(cpu_dev);
> +       if (ret) {
> +               dev_err(dev, "Failed to init mtk_opp_table: %d\n", ret);
> +               return ret;
> +       }
> +
> +       rcu_read_lock();
> +
> +       cnt = dev_pm_opp_get_opp_count(cpu_dev);
> +       if (cnt < 0) {
> +               dev_err(cpu_dev, "No OPP table is found: %d", cnt);
> +               ret = cnt;
> +               goto out_free_opp_tbl;
> +       }
> +
> +       opp_tbl = devm_kcalloc(dev, (cnt + 1), sizeof(struct cpu_opp_table),
> +                              GFP_ATOMIC);
> +       if (!opp_tbl) {
> +               ret = -ENOMEM;
> +               goto out_free_opp_tbl;
> +       }
> +
> +       for (i = 0, rate = 0; i < cnt; i++, rate++) {
> +               opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
> +               if (IS_ERR(opp)) {
> +                       ret = PTR_ERR(opp);
> +                       goto out_free_opp_tbl;
> +               }
> +
> +               vproc = dev_pm_opp_get_voltage(opp);
> +               vproc = get_regulator_voltage_ceil(dvfs_info->proc_reg, vproc);
> +               vsram = vproc + VOLT_SHIFT_LOWER_LIMIT;
> +               vsram = get_regulator_voltage_ceil(dvfs_info->sram_reg, vsram);
> +
> +               if (vproc < 0 || vsram < 0) {
> +                       ret = -EINVAL;
> +                       goto out_free_opp_tbl;
> +               }
> +
> +               opp_tbl[i].freq = rate;
> +               opp_tbl[i].vproc = vproc;
> +               opp_tbl[i].vsram = vsram;
> +       }
> +
> +       opp_tbl[i].freq = 0;
> +       opp_tbl[i].vproc = -1;
> +       opp_tbl[i].vsram = -1;
> +       dvfs_info->opp_tbl = opp_tbl;
> +
> +out_free_opp_tbl:
> +       rcu_read_unlock();
> +       of_free_opp_table(cpu_dev);
> +
> +       return ret;
> +}
> +
> +static struct cpufreq_cpu_domain *get_cpu_domain(struct list_head *domain_list,
> +                                                int cpu)
> +{
> +       struct list_head *node;
> +
> +       list_for_each(node, domain_list) {
> +               struct cpufreq_cpu_domain *domain;
> +
> +               domain = container_of(node, struct cpufreq_cpu_domain, node);
> +               if (cpumask_test_cpu(cpu, &domain->cpus))
> +                       return domain;
> +       }
> +
> +       return NULL;
> +}
> +
> +static int mtk_cpufreq_probe(struct platform_device *pdev)

On a dual cluster big LITTLE (your system), how many times is probe
getting called ? Once or twice, i.e. for each cluster ??

> +{
> +       struct clk *inter_clk;
> +       struct cpufreq_dt_platform_data *pd;
> +       struct platform_device *dev;
> +       unsigned long inter_freq;
> +       int cpu, ret;
> +
> +       inter_clk = clk_get(&pdev->dev, NULL);

How is this supposed to work ? How will pdev->dev give intermediate
clock ?

> +       if (IS_ERR(inter_clk)) {
> +               if (PTR_ERR(inter_clk) == -EPROBE_DEFER) {
> +                       dev_warn(&pdev->dev, "clock not ready. defer probeing.\n");
> +                       return -EPROBE_DEFER;
> +               }
> +
> +               dev_err(&pdev->dev, "Failed to get intermediate clock\n");
> +               return -ENODEV;
> +       }
> +       inter_freq = clk_get_rate(inter_clk);
> +
> +       pd = devm_kzalloc(&pdev->dev, sizeof(*pd), GFP_KERNEL);
> +       if (!pd)
> +               return -ENOMEM;
> +
> +       dvfs_info = devm_kzalloc(&pdev->dev, sizeof(*dvfs_info), GFP_KERNEL);
> +       if (!dvfs_info)
> +               return -ENOMEM;

Instead of two allocations, you could have made pd part of dvfs_info
and allocated only
once.

> +
> +       pd->independent_clocks = 1,

s/,/; ??

> +       INIT_LIST_HEAD(&pd->domain_list);
> +
> +       for_each_possible_cpu(cpu) {
> +               struct device *cpu_dev;
> +               struct cpufreq_cpu_domain *new_domain;
> +               struct regulator *proc_reg, *sram_reg;
> +
> +               cpu_dev = get_cpu_device(cpu);

This should be done in the below if block only.

> +               if (!dvfs_info->cpu_dev) {
> +                       proc_reg = regulator_get_exclusive(cpu_dev, "proc");
> +                       sram_reg = regulator_get_exclusive(cpu_dev, "sram");
> +
> +                       if (PTR_ERR(proc_reg) == -EPROBE_DEFER ||
> +                           PTR_ERR(sram_reg) == -EPROBE_DEFER)
> +                               return -EPROBE_DEFER;
> +
> +                       if (!IS_ERR_OR_NULL(proc_reg) &&
> +                           !IS_ERR_OR_NULL(sram_reg)) {
> +                               dvfs_info->cpu_dev = cpu_dev;
> +                               dvfs_info->proc_reg = proc_reg;
> +                               dvfs_info->sram_reg = sram_reg;
> +                               cpumask_copy(&dvfs_info->cpus,
> +                                            &cpu_topology[cpu].core_sibling);
> +                       }
> +               }
> +
> +               if (get_cpu_domain(&pd->domain_list, cpu))
> +                       continue;

This isn't required if you do below..

> +
> +               new_domain = devm_kzalloc(&pdev->dev, sizeof(*new_domain),
> +                                         GFP_KERNEL);
> +               if (!new_domain)
> +                       return -ENOMEM;
> +
> +               cpumask_copy(&new_domain->cpus,
> +                            &cpu_topology[cpu].core_sibling);
> +               new_domain->intermediate_freq = inter_freq;
> +               list_add(&new_domain->node, &pd->domain_list);

Just issue a 'break' from here as you don't want to let this loop run again.

> +       }
> +
> +       if (IS_ERR_OR_NULL(dvfs_info->proc_reg) ||
> +           IS_ERR_OR_NULL(dvfs_info->sram_reg)) {
> +               dev_err(&pdev->dev, "Failed to get regulators\n");
> +               return -ENODEV;
> +       }

If you really need these, then don't allocate new_domain unless you find a CPU
with these regulators..

> +       ret = cpu_opp_table_init(&pdev->dev);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to setup cpu_opp_table: %d\n",
> +                       ret);
> +               return ret;
> +       }
> +
> +       ret = cpufreq_register_notifier(&mtk_cpufreq_nb,
> +                                       CPUFREQ_TRANSITION_NOTIFIER);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to register cpufreq notifier\n");
> +               return ret;
> +       }

Don't want to free OPP table here on error ?

> +       dev = platform_device_register_data(NULL, "cpufreq-dt", -1, pd,
> +                                           sizeof(*pd));

So this routine is going to be called only once. Then how are you
initializing stuff
for both the clusters in the upper for loop ? It looked very very confusing.

> +       if (IS_ERR(dev)) {
> +               dev_err(&pdev->dev,
> +                       "Failed to register cpufreq-dt platform device\n");
> +               return PTR_ERR(dev);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mtk_cpufreq_match[] = {
> +       {
> +               .compatible = "mediatek,mtk-cpufreq",

Can't you use "mediatek,mt8173" here ?

> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, mtk_cpufreq_match);
> +
> +static struct platform_driver mtk_cpufreq_platdrv = {
> +       .driver = {
> +               .name   = "mtk-cpufreq",
> +               .of_match_table = mtk_cpufreq_match,
> +       },
> +       .probe  = mtk_cpufreq_probe,
> +};
> +module_platform_driver(mtk_cpufreq_platdrv);
