From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [PATCH v2 1/4] cpufreq-dt: add clock domain and intermediate
 frequency support
Date: Thu, 5 Mar 2015 11:32:33 +0800
Message-ID: <CALx668XCh46yMLajThuVzba9RRSxf+tEkNuMP9J7w-=vsZN8-Q@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
	<1425458956-20665-2-git-send-email-pi-cheng.chen@linaro.org>
	<CAKohpomw6iDRRMxgmOORzZVeW4h2-LzKOsUcdpUnANcxiAYm+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:38473 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbCEDcf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2015 22:32:35 -0500
Received: by labgf13 with SMTP id gf13so24233507lab.5
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2015 19:32:33 -0800 (PST)
In-Reply-To: <CAKohpomw6iDRRMxgmOORzZVeW4h2-LzKOsUcdpUnANcxiAYm+A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mike Turquette <mturquette@linaro.org>, Chen Fan <fan.chen@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.k>

Hi Viresh,

Thanks for reviewing. Please see my reply below:

On 4 March 2015 at 18:15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 4 March 2015 at 14:19, pi-cheng.chen <pi-cheng.chen@linaro.org> wrote:
>> In this patch, CPU clock/power domain information is added into the
>> platform_data of cpufreq-dt so that cpufreq-dt driver could check with CPUs
>> share clock/power. Also, intermediate frequency support is added in this
>
> You should have separate patches for logically separate changes.

Sure. Will do it.

>
>> version. Since the program flows of .target_index and .target_intermediate
>> are quite similar, consolidate the flow as a new function to keep readibility.
>>
>> Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
>> ---
>>  drivers/cpufreq/cpufreq-dt.c | 68 +++++++++++++++++++++++++++++++++++++++-----
>>  include/linux/cpufreq-dt.h   |  7 +++++
>>  2 files changed, 68 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
>> index bab67db..5948bdf 100644
>> --- a/drivers/cpufreq/cpufreq-dt.c
>> +++ b/drivers/cpufreq/cpufreq-dt.c
>> @@ -34,25 +34,37 @@ struct private_data {
>>         struct regulator *cpu_reg;
>>         struct thermal_cooling_device *cdev;
>>         unsigned int voltage_tolerance; /* in percentage */
>> +       unsigned long intermediate_freq;
>>  };
>>
>> -static int set_target(struct cpufreq_policy *policy, unsigned int index)
>> +static unsigned int get_intermediate(struct cpufreq_policy *policy,
>> +                                    unsigned int index)
>> +{
>> +       struct private_data *priv = policy->driver_data;
>> +       struct cpufreq_frequency_table *freq_table;
>> +       unsigned long freq = clk_get_rate(policy->clk);
>
> This will return current freq, which can also be fetched with
> policy->cur.

Will fix it.

>
>> +
>> +       freq_table = cpufreq_frequency_get_table(policy->cpu);
>
> instead, freq_table = policy->freq_table.

Will fix it.

>
>> +
>
> Always add a comment over such decision making expressions, on
> why you chose to return 0.

Will fix it.

>
>> +       if (freq == priv->intermediate_freq ||
>
> Looks fine, current freq == intermediate freq..
>
>> +           freq_table[index].frequency * 1000 == freq)
>
> Absolutely wrong, current-freq == requested-freq.
> Instead it should be:
>
> freq_table[index].frequency * 1000 == priv->intermediate_freq.
>

Thanks for correcting. Will fix it.

>> +               return 0;
>> +
>> +       return priv->intermediate_freq;
>> +}
>> +
>> +static int set_frequency(struct cpufreq_policy *policy, long freq_Hz)
>>  {
>>         struct dev_pm_opp *opp;
>> -       struct cpufreq_frequency_table *freq_table = policy->freq_table;
>>         struct clk *cpu_clk = policy->clk;
>>         struct private_data *priv = policy->driver_data;
>>         struct device *cpu_dev = priv->cpu_dev;
>>         struct regulator *cpu_reg = priv->cpu_reg;
>>         unsigned long volt = 0, volt_old = 0, tol = 0;
>>         unsigned int old_freq, new_freq;
>> -       long freq_Hz, freq_exact;
>> +       long freq_exact;
>>         int ret;
>>
>> -       freq_Hz = clk_round_rate(cpu_clk, freq_table[index].frequency * 1000);
>> -       if (freq_Hz <= 0)
>> -               freq_Hz = freq_table[index].frequency * 1000;
>> -
>>         freq_exact = freq_Hz;
>>         new_freq = freq_Hz / 1000;
>>         old_freq = clk_get_rate(cpu_clk) / 1000;
>> @@ -112,6 +124,29 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
>>         return ret;
>>  }
>>
>> +static int target_intermediate(struct cpufreq_policy *policy,
>> +                              unsigned int index)
>> +{
>> +       struct private_data *priv = policy->driver_data;
>> +       long freq_Hz;
>> +
>> +       freq_Hz = priv->intermediate_freq;
>> +       return set_frequency(policy, freq_Hz);
>
> Instead, return set_frequency(policy, priv->intermediate_freq);

Will fix it.

>
>> +}
>> +
>> +static int set_target(struct cpufreq_policy *policy, unsigned int index)
>> +{
>> +       struct cpufreq_frequency_table *freq_table = policy->freq_table;
>> +       struct clk *cpu_clk = policy->clk;
>> +       long freq_Hz;
>> +
>> +       freq_Hz = clk_round_rate(cpu_clk, freq_table[index].frequency * 1000);
>
> Use policy->clk here directly instead of another local variable.

Will fix it.

>
>> +       if (freq_Hz <= 0)
>> +               freq_Hz = freq_table[index].frequency * 1000;
>
> Why shouldn't we call clk_round_rate() for intermediate freq as well ?

Yes. Will do it.

> I think, it
> should be called for it as well.. And so you can save intermediate_freq_index
> instead of the freq..
>

Here is the case I wanted to talk to you at HKG15:
In the case of Mediatek SoC, the intermediate frequency might not be one entry
of OPP table. To elaborate, the source clock node of the CPUs/Cluster on
Mediatek SoC is a mux. The mux has several PLLs as parents. When we are
doing CPU frequency scaling, the mux should re-parent to another stable PLL,
wait until the original parent PLL become stable, and then switch back to the
original parent. In this case, we could but we might not want the intermediate
frequency as part of OPP table. Therefore I save intermediate_freq instead of
intermediate frequency index in the cpufreq_dt_platform_datat struct.

BTW, is this case that intermediate frequency is not necessarily be one entry
of OPP table supported in the OPPv2 bindings?

>> +       return set_frequency(policy, freq_Hz);
>> +}
>> +
>>  static int allocate_resources(int cpu, struct device **cdev,
>>                               struct regulator **creg, struct clk **cclk)
>>  {
>> @@ -296,6 +331,23 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>>         pd = cpufreq_get_driver_data();
>>         if (!pd || !pd->independent_clocks)
>>                 cpumask_setall(policy->cpus);
>> +       else if (pd && !list_empty(&pd->domain_list)) {
>> +               struct list_head *domain_node;
>> +               struct cpufreq_cpu_domain *domain;
>> +
>> +               list_for_each(domain_node, &pd->domain_list) {
>> +                       domain = container_of(domain_node,
>> +                                             struct cpufreq_cpu_domain, node);
>> +                       if (!cpumask_test_cpu(policy->cpu, &domain->cpus))
>> +                               continue;
>> +
>> +                       if (domain->intermediate_freq)
>> +                               priv->intermediate_freq =
>> +                                               domain->intermediate_freq;
>> +                       cpumask_copy(policy->cpus, &domain->cpus);
>> +                       break;
>> +               }
>> +       }
>>
>
> Do this in a separate patch.

Will do it.

>
>>         of_node_put(np);
>>
>> @@ -363,6 +415,8 @@ static struct cpufreq_driver dt_cpufreq_driver = {
>>         .verify = cpufreq_generic_frequency_table_verify,
>>         .target_index = set_target,
>>         .get = cpufreq_generic_get,
>> +       .get_intermediate = get_intermediate,
>> +       .target_intermediate = target_intermediate,
>>         .init = cpufreq_init,
>>         .exit = cpufreq_exit,
>>         .ready = cpufreq_ready,
>> diff --git a/include/linux/cpufreq-dt.h b/include/linux/cpufreq-dt.h
>> index 0414009..d6e2097 100644
>> --- a/include/linux/cpufreq-dt.h
>> +++ b/include/linux/cpufreq-dt.h
>> @@ -10,6 +10,12 @@
>>  #ifndef __CPUFREQ_DT_H__
>>  #define __CPUFREQ_DT_H__
>>
>> +struct cpufreq_cpu_domain {
>> +       struct list_head node;
>> +       cpumask_t cpus;
>> +       unsigned long intermediate_freq;
>
> This should come from DT instead of platform data.
>
>> +};
>
> This struct will die along with the below one as soon as my patches
> on OPP bindings V2 get merged.

Sure. Will adapt the new way once it's merged.

>
>>  struct cpufreq_dt_platform_data {
>>         /*
>>          * True when each CPU has its own clock to control its
>> @@ -17,6 +23,7 @@ struct cpufreq_dt_platform_data {
>>          * clock.
>>          */
>>         bool independent_clocks;
>> +       struct list_head domain_list;
>
> Also update the comment on how what these fields mean..

Will do it.

Thanks.

Best Regards,
Pi-Cheng

>
>>  };
>>
>>  #endif /* __CPUFREQ_DT_H__ */
>> --
>> 1.9.1
>>
