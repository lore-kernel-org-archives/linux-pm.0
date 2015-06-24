From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Wed, 24 Jun 2015 06:27:59 +0530
Message-ID: <20150624005759.GA6424@linux>
References: <1433766561-1330-1-git-send-email-pi-cheng.chen@linaro.org>
 <1433766561-1330-3-git-send-email-pi-cheng.chen@linaro.org>
 <20150622114511.GA28340@linux>
 <CALx668VmT+90y712QO4JQCh-nTCxStWYY+ygJ_1KiVN7VnmmpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34621 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbbFXA6F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 20:58:05 -0400
Received: by pdbki1 with SMTP id ki1so18240717pdb.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 17:58:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALx668VmT+90y712QO4JQCh-nTCxStWYY+ygJ_1KiVN7VnmmpQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, linux-mediatek@lists.infradead.org

On 23-06-15, 23:25, Pi-Cheng Chen wrote:
> On Mon, Jun 22, 2015 at 7:45 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >> +static struct mtk_cpu_dvfs_info *mtk_cpu_dvfs_info_get(int cpu)
> >
> > A very bad name to a routine with very specific functionality.
> 
> Would get_mtk_cpu_dvfs_info() or cpu_to_mtk_cpu_dvfs_info() be better?
> 
> >
> >> +{
> >> +     struct mtk_cpu_dvfs_info *info;
> >> +     struct list_head *list;
> >> +
> >> +     list_for_each(list, &cpu_dvfs_info_list) {
> >> +             info = to_mtk_cpu_dvfs_info(list);
> >> +
> >> +             if (cpumask_test_cpu(cpu, info->cpus))
> >> +                     return info;
> >> +     }

Firstly there is no need of extra long name for static routines. Just
keep them simple. i.e. no need of mtk_cpu_.

And then I was a bit confused about the functionality earlier and your
initial name wasn't that bad. Sorry :(

So maybe just, get_dvfs_info().

> >> +     freq_hz = freq_table[index].frequency * 1000;
> >
> > A blank line here.
> 
> Will remove it.
> 

I was asking you to add it :)

> >> +     rcu_read_lock();


> >> +static int mtk_cpu_dvfs_info_init(int cpu)
> >> +{
> >> +     struct device *cpu_dev;
> >> +     struct regulator *proc_reg = ERR_PTR(-ENODEV);
> >> +     struct regulator *sram_reg = ERR_PTR(-ENODEV);
> >> +     struct clk *cpu_clk = ERR_PTR(-ENODEV);
> >> +     struct clk *inter_clk = ERR_PTR(-ENODEV);
> >> +     struct mtk_cpu_dvfs_info *info;
> >> +     struct cpufreq_frequency_table *freq_table;
> >> +     struct dev_pm_opp *opp;
> >> +     unsigned long rate;
> >> +     int ret;
> >> +
> >> +     cpu_dev = get_cpu_device(cpu);
> >> +     if (!cpu_dev) {
> >> +             pr_err("failed to get cpu%d device\n", cpu);
> >> +             return -ENODEV;
> >> +     }
> >> +
> >> +     ret = of_init_opp_table(cpu_dev);
> >> +     if (ret) {
> >> +             pr_warn("no OPP table for cpu%d\n", cpu);
> >> +             return ret;
> >> +     }
> >> +
> >> +     cpu_clk = clk_get(cpu_dev, "cpu");
> >> +     if (IS_ERR(cpu_clk)) {
> >> +             if (PTR_ERR(cpu_clk) == -EPROBE_DEFER)
> >> +                     pr_warn("cpu clk for cpu%d not ready, retry.\n", cpu);
> >> +             else
> >> +                     pr_err("failed to get cpu clk for cpu%d\n", cpu);
> >> +
> >> +             ret = PTR_ERR(cpu_clk);
> >> +             goto out_free_opp_table;
> >> +     }
> >> +
> >> +     inter_clk = clk_get(cpu_dev, "intermediate");
> >> +     if (IS_ERR(inter_clk)) {
> >> +             if (PTR_ERR(inter_clk) == -EPROBE_DEFER)
> >> +                     pr_warn("intermediate clk for cpu%d not ready, retry.\n",
> >> +                             cpu);
> >> +             else
> >> +                     pr_err("failed to get intermediate clk for cpu%d\n",
> >> +                            cpu);
> >> +
> >> +             ret = PTR_ERR(cpu_clk);
> >> +             goto out_free_resources;
> >> +     }
> >> +
> >> +     proc_reg = regulator_get_exclusive(cpu_dev, "proc");
> >> +     if (IS_ERR(proc_reg)) {
> >> +             if (PTR_ERR(proc_reg) == -EPROBE_DEFER)
> >> +                     pr_warn("proc regulator for cpu%d not ready, retry.\n",
> >> +                             cpu);
> >> +             else
> >> +                     pr_err("failed to get proc regulator for cpu%d\n",
> >> +                            cpu);
> >> +
> >> +             ret = PTR_ERR(proc_reg);
> >> +             goto out_free_resources;
> >> +     }
> >> +
> >> +     /* Both presence and absence of sram regulator are valid cases. */
> >> +     sram_reg = regulator_get_exclusive(cpu_dev, "sram");
> >> +
> >> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
> >> +     if (!info) {
> >> +             ret = -ENOMEM;
> >> +             goto out_free_resources;
> >> +     }
> >> +
> >> +     ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
> >> +     if (ret) {
> >> +             pr_err("failed to init cpufreq table for cpu%d: %d\n",
> >> +                    cpu, ret);
> >> +             goto out_free_mtk_cpu_dvfs_info;
> >> +     }
> >> +
> >> +     if (!alloc_cpumask_var(&info->cpus, GFP_KERNEL))
> >
> > Why getting into such trouble? What about just saving policy's pointer
> > in info and use it for freq_table, cpus mask, etc ?
> 
> This function is called from driver probe function. At this moment, cpufreq
> driver is not yet registered and the policy struct for each cluster is not yet
> allocated.

This should be called from ->init() callback of the cpufreq driver.

> Also, the mtk_cpu_dvfs_info structs for all clusters are stored in a list
> after probe done. cpus mask is used to find out the proper info struct
> for corresponding cpu.

Yeah, but this will be exactly same to policy->related_cpus, just use
that. Why allocate another mask for same purpose?

> For freq_table, I simply don't want to free and allocate the table
> every time when cpu is unplugged and plugged so I just allocate it
> in the probe function call path, and cache it in the info struct.

->exit() will be called only when all the CPUs from a policy are
hotplugged out. Not on every hotplug. So you probably have 4 big and 4
little cores. So policy for big cluster will be removed only when all
the CPUs are down. And so no point storing things from probe.

Or is there anything special with your usecase?

> But for module_platform_driver(mt8173_cpufreq_platdrv), I saw many
> built-in drivers in kernel call module_platform_driver() also so I use it.

That was wrong for them as well :)

> Would it be better to use platform_driver_register() instead?

Hmm.. 

-- 
viresh
