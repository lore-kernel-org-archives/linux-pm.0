From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: Add cpufreq driver for Freescale e500mc SoCs
Date: Fri, 29 Mar 2013 12:47:06 +0530
Message-ID: <CAKohpo=4ypXkE=VDBHOWnLHG_x2cbh7=OGA=87MEMLyNaTi=xg@mail.gmail.com>
References: <1364536350-23788-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1364536350-23788-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: cpufreq-owner@vger.kernel.org
To: Yuantian.Tang@freescale.com
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: linux-pm@vger.kernel.org

On 29 March 2013 11:22,  <Yuantian.Tang@freescale.com> wrote:
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
> +

Add following here for better debug prints (sorry, i should have done
it earlier)

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

> +#include <linux/clk.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +

> +static unsigned int    cpus_per_cluster;

remove tab with space after int.

> +static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       struct device_node *np;
> +       int i, count, ret;
> +       struct clk *clk;
> +       struct cpufreq_frequency_table *table;
> +       struct cpu_data *data;
> +       unsigned int cpu = policy->cpu;
> +
> +       np = of_get_cpu_node(cpu, NULL);
> +       if (!np)
> +               return -ENODEV;
> +
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->clk = of_clk_get(np, 0);

what if this fails?

> +       /* align the cpu id with cluster if any */
> +       i = (cpu / cpus_per_cluster) * cpus_per_cluster;
> +       for (count = 0; count < cpus_per_cluster; count++)
> +               cpumask_set_cpu(i + count, policy->cpus);

Better than before but i still see some regression with it :)

What if cpu order in DT is changed a bit and so cpus boot with following
order: 0 1 3 5 7 2 6 4

And so you will end up grouping 0135 and 7264 :)

See if topology_core_cpumask() gives you correct pairs.

> +static int corenet_cpufreq_target(struct cpufreq_policy *policy,
> +               unsigned int target_freq, unsigned int relation)
> +{
> +       struct cpufreq_freqs freqs;
> +       unsigned int new;
> +       struct clk *parent;
> +       int ret;
> +       struct cpu_data *data = per_cpu(cpu_data, policy->cpu);
> +
> +       cpufreq_frequency_table_target(policy, data->table,
> +                       target_freq, relation, &new);
> +
> +       if (policy->cur == data->table[new].frequency)
> +               return 0;
> +
> +       freqs.old = policy->cur;
> +       freqs.new = data->table[new].frequency;
> +       freqs.cpu = policy->cpu;
> +
> +       mutex_lock(&cpufreq_lock);
> +       cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);

What i wanted here from you was:

	for_each_cpu(freqs.cpu, policy->cpus)
		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);

Which would be fixed later by my patch, but until then you must have correct
code in your driver. What if my patchset is rejected :)

Mostly good now. Probably V4 would be the last one :)
