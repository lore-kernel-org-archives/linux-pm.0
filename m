From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/4] cpufreq-dt: add clock domain and intermediate
 frequency support
Date: Wed, 4 Mar 2015 15:45:40 +0530
Message-ID: <CAKohpomw6iDRRMxgmOORzZVeW4h2-LzKOsUcdpUnANcxiAYm+A@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
	<1425458956-20665-2-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425458956-20665-2-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "pi-cheng.chen" <pi-cheng.chen@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mike Turquette <mturquette@linaro.org>, fan.chen@mediatek.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 4 March 2015 at 14:19, pi-cheng.chen <pi-cheng.chen@linaro.org> wrote:
> In this patch, CPU clock/power domain information is added into the
> platform_data of cpufreq-dt so that cpufreq-dt driver could check with CPUs
> share clock/power. Also, intermediate frequency support is added in this

You should have separate patches for logically separate changes.

> version. Since the program flows of .target_index and .target_intermediate
> are quite similar, consolidate the flow as a new function to keep readibility.
>
> Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 68 +++++++++++++++++++++++++++++++++++++++-----
>  include/linux/cpufreq-dt.h   |  7 +++++
>  2 files changed, 68 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index bab67db..5948bdf 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -34,25 +34,37 @@ struct private_data {
>         struct regulator *cpu_reg;
>         struct thermal_cooling_device *cdev;
>         unsigned int voltage_tolerance; /* in percentage */
> +       unsigned long intermediate_freq;
>  };
>
> -static int set_target(struct cpufreq_policy *policy, unsigned int index)
> +static unsigned int get_intermediate(struct cpufreq_policy *policy,
> +                                    unsigned int index)
> +{
> +       struct private_data *priv = policy->driver_data;
> +       struct cpufreq_frequency_table *freq_table;
> +       unsigned long freq = clk_get_rate(policy->clk);

This will return current freq, which can also be fetched with
policy->cur.

> +
> +       freq_table = cpufreq_frequency_get_table(policy->cpu);

instead, freq_table = policy->freq_table.

> +

Always add a comment over such decision making expressions, on
why you chose to return 0.

> +       if (freq == priv->intermediate_freq ||

Looks fine, current freq == intermediate freq..

> +           freq_table[index].frequency * 1000 == freq)

Absolutely wrong, current-freq == requested-freq.
Instead it should be:

freq_table[index].frequency * 1000 == priv->intermediate_freq.

> +               return 0;
> +
> +       return priv->intermediate_freq;
> +}
> +
> +static int set_frequency(struct cpufreq_policy *policy, long freq_Hz)
>  {
>         struct dev_pm_opp *opp;
> -       struct cpufreq_frequency_table *freq_table = policy->freq_table;
>         struct clk *cpu_clk = policy->clk;
>         struct private_data *priv = policy->driver_data;
>         struct device *cpu_dev = priv->cpu_dev;
>         struct regulator *cpu_reg = priv->cpu_reg;
>         unsigned long volt = 0, volt_old = 0, tol = 0;
>         unsigned int old_freq, new_freq;
> -       long freq_Hz, freq_exact;
> +       long freq_exact;
>         int ret;
>
> -       freq_Hz = clk_round_rate(cpu_clk, freq_table[index].frequency * 1000);
> -       if (freq_Hz <= 0)
> -               freq_Hz = freq_table[index].frequency * 1000;
> -
>         freq_exact = freq_Hz;
>         new_freq = freq_Hz / 1000;
>         old_freq = clk_get_rate(cpu_clk) / 1000;
> @@ -112,6 +124,29 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
>         return ret;
>  }
>
> +static int target_intermediate(struct cpufreq_policy *policy,
> +                              unsigned int index)
> +{
> +       struct private_data *priv = policy->driver_data;
> +       long freq_Hz;
> +
> +       freq_Hz = priv->intermediate_freq;
> +       return set_frequency(policy, freq_Hz);

Instead, return set_frequency(policy, priv->intermediate_freq);

> +}
> +
> +static int set_target(struct cpufreq_policy *policy, unsigned int index)
> +{
> +       struct cpufreq_frequency_table *freq_table = policy->freq_table;
> +       struct clk *cpu_clk = policy->clk;
> +       long freq_Hz;
> +
> +       freq_Hz = clk_round_rate(cpu_clk, freq_table[index].frequency * 1000);

Use policy->clk here directly instead of another local variable.

> +       if (freq_Hz <= 0)
> +               freq_Hz = freq_table[index].frequency * 1000;

Why shouldn't we call clk_round_rate() for intermediate freq as well ?
I think, it
should be called for it as well.. And so you can save intermediate_freq_index
instead of the freq..

> +       return set_frequency(policy, freq_Hz);
> +}
> +
>  static int allocate_resources(int cpu, struct device **cdev,
>                               struct regulator **creg, struct clk **cclk)
>  {
> @@ -296,6 +331,23 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>         pd = cpufreq_get_driver_data();
>         if (!pd || !pd->independent_clocks)
>                 cpumask_setall(policy->cpus);
> +       else if (pd && !list_empty(&pd->domain_list)) {
> +               struct list_head *domain_node;
> +               struct cpufreq_cpu_domain *domain;
> +
> +               list_for_each(domain_node, &pd->domain_list) {
> +                       domain = container_of(domain_node,
> +                                             struct cpufreq_cpu_domain, node);
> +                       if (!cpumask_test_cpu(policy->cpu, &domain->cpus))
> +                               continue;
> +
> +                       if (domain->intermediate_freq)
> +                               priv->intermediate_freq =
> +                                               domain->intermediate_freq;
> +                       cpumask_copy(policy->cpus, &domain->cpus);
> +                       break;
> +               }
> +       }
>

Do this in a separate patch.

>         of_node_put(np);
>
> @@ -363,6 +415,8 @@ static struct cpufreq_driver dt_cpufreq_driver = {
>         .verify = cpufreq_generic_frequency_table_verify,
>         .target_index = set_target,
>         .get = cpufreq_generic_get,
> +       .get_intermediate = get_intermediate,
> +       .target_intermediate = target_intermediate,
>         .init = cpufreq_init,
>         .exit = cpufreq_exit,
>         .ready = cpufreq_ready,
> diff --git a/include/linux/cpufreq-dt.h b/include/linux/cpufreq-dt.h
> index 0414009..d6e2097 100644
> --- a/include/linux/cpufreq-dt.h
> +++ b/include/linux/cpufreq-dt.h
> @@ -10,6 +10,12 @@
>  #ifndef __CPUFREQ_DT_H__
>  #define __CPUFREQ_DT_H__
>
> +struct cpufreq_cpu_domain {
> +       struct list_head node;
> +       cpumask_t cpus;
> +       unsigned long intermediate_freq;

This should come from DT instead of platform data.

> +};

This struct will die along with the below one as soon as my patches
on OPP bindings V2 get merged.

>  struct cpufreq_dt_platform_data {
>         /*
>          * True when each CPU has its own clock to control its
> @@ -17,6 +23,7 @@ struct cpufreq_dt_platform_data {
>          * clock.
>          */
>         bool independent_clocks;
> +       struct list_head domain_list;

Also update the comment on how what these fields mean..

>  };
>
>  #endif /* __CPUFREQ_DT_H__ */
> --
> 1.9.1
>
