From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6] cpufreq: Add SFI based cpufreq driver support
Date: Wed, 3 Dec 2014 22:21:57 -0500
Message-ID: <CAJvTdKku-ioem5iP0xz=uFkom2XMsKMrRHQ7k8vD5FFKt33P9A@mail.gmail.com>
References: <20141125054226.GA20738@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:59800 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbaLDDV5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 22:21:57 -0500
Received: by mail-yk0-f175.google.com with SMTP id 200so7537689ykr.6
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 19:21:57 -0800 (PST)
In-Reply-To: <20141125054226.GA20738@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com

I like this trend:

drivers/cpufreq/sfi-cpufreq.c |  529 +++++++++++++++++++++++++++++++++++++++++
v1: drivers/cpufreq/sfi-cpufreq.c |  426
+++++++++++++++++++++++++++++++++++++++++
v2: drivers/cpufreq/sfi-cpufreq.c |  332
+++++++++++++++++++++++++++++++++++++++++
v3: drivers/cpufreq/sfi-cpufreq.c |  326
+++++++++++++++++++++++++++++++++++++++++
v4: drivers/cpufreq/sfi-cpufreq.c |  317
+++++++++++++++++++++++++++++++++++++++++
v5: drivers/cpufreq/sfi-cpufreq.c         |  238
+++++++++++++++++++++++++++++++++
v6: drivers/cpufreq/sfi-cpufreq.c         |  230
+++++++++++++++++++++++++++++++++



On Tue, Nov 25, 2014 at 12:42 AM, Srinidhi Kasagar
<srinidhi.kasagar@intel.com> wrote:

> +++ b/drivers/cpufreq/sfi-cpufreq.c

> +#define SFI_FREQ_MASK          0xff00
> +
> +static DEFINE_PER_CPU(struct sfi_cpufreq_data *, drv_data);
> +static DEFINE_MUTEX(performance_mutex);

I'm not sure that cpufreq is able to call driver init's in parallel,
so I'm not sure that the driver init needs to lock against other
invocations of itself.
But even if called in parallel, what data does performance_mutex
actually protect?


> +
> +static struct sfi_freq_table_entry *f_entry;
> +static int sfi_cpufreq_num;

The frequency table and its number of entries are global to the system
and un-changing.
So they probably never have to be re-initialized after the first cpu
goes through the init routine.

ie. it doesn't appear to be necessary to have a copy per cpu.

Finally, perhaps more consistent names would be something like:

static sfi_freq_table_entry *freq_table_entries;
static int num_freq_table_entries;

> +
> +struct sfi_cpufreq_performance {
> +       unsigned int state;

state is remembering the most recent next_perf_state.
currently its only (dubious) use is during a printk at initialization time,
when is it probably always zero from being allocated but not yet used...

If you don't use it for caching the state in get_cur_freq_on_cpu()
as discussed below, I recommend you delete it.

> +       unsigned int state_count;

no need to have this, if you also have system-wide
num_freq_table_entries, above.

> +       struct sfi_freq_table_entry *states;

no need to have this, if you also have system-wide freq_table_entries, above.

> +};
> +
> +struct sfi_cpufreq_data {
> +       struct sfi_cpufreq_performance *sfi_data;

as sfi_cpufreq_performance data structure is now down to 4 bytes,
or 0 bytes, if you delete 'state'.  So delete the struct and include what
is left, here -- if anything.

> +       struct cpufreq_frequency_table *freq_table;
> +};
> +
> +static int parse_freq(struct sfi_table_header *table)
> +{
> +       struct sfi_table_simple *sb;
> +
> +       sb = (struct sfi_table_simple *)table;
> +
> +       sfi_cpufreq_num = SFI_GET_NUM_ENTRIES(sb, struct sfi_freq_table_entry);
> +       f_entry = (struct sfi_freq_table_entry *)sb->pentry;

are we sure that this pointer will still be valid after
sfi_table_parse() returns?
sfi_table_parse() appears to do an sfi_table_put() at the end...

> +
> +       return 0;
> +}
> +
> +static int sfi_cpufreq_register_performance(struct sfi_cpufreq_performance *pr)
> +{
> +       int ret = 0;
> +       mutex_lock(&performance_mutex);
> +
> +       /* parse the freq table from SFI */
> +       sfi_table_parse(SFI_SIG_FREQ, NULL, NULL, parse_freq);
> +       pr->state_count = sfi_cpufreq_num;
> +       if (pr->state_count <= 1) {
> +               pr_err("No p-states discovered\n");
> +               ret = -ENODEV;
> +               goto err;
> +       }
> +       pr->states = f_entry;
> +err:
> +       mutex_unlock(&performance_mutex);
> +
> +       return ret;
> +}
> +
> +static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
> +{
> +       u32 lo, hi, sfi_ctrl;
> +       struct cpufreq_frequency_table *pos;
> +       struct sfi_cpufreq_data *data = per_cpu(drv_data, cpu);
> +
> +       rdmsr_on_cpu(cpu, MSR_IA32_PERF_CTL, &lo, &hi);
> +       lo &= SFI_FREQ_MASK;
> +
> +       cpufreq_for_each_entry(pos, data->freq_table) {
> +               sfi_ctrl = data->sfi_data->states[pos->driver_data].ctrl_val
> +                       & SFI_FREQ_MASK;
> +               if (sfi_ctrl == lo)
> +                       return pos->frequency;
> +       }
> +       return data->freq_table[0].frequency;
> +}

Not obvious (to me) that this in-accurate return value is more useful
to the caller than simply returning data->freq_table[state].frequency.

Unless the caller is taking into account for hardware coordination
of multiple PERF_CTRL MSR's, then it is garbage-in/garbage-out,
not to mention that by the time this value is used, it may have changed...

I'm curious what breaks in your Android setup if you don't supply
a get_cur_freq() at all...

But that said, acpi-cpufreq.c is much worse in this department.

> +
> +static int sfi_cpufreq_target(struct cpufreq_policy *policy,
> +                               unsigned int index)
> +{
> +       struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
> +       unsigned int next_perf_state = 0; /* Index into perf table */
> +       u32 lo, hi;
> +
> +       next_perf_state = data->freq_table[index].driver_data;
> +
> +       rdmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, &lo, &hi);
> +       lo = (lo & ~INTEL_PERF_CTL_MASK) |
> +               ((u32) data->sfi_data->states[next_perf_state].ctrl_val &
> +                       INTEL_PERF_CTL_MASK);
> +       wrmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, lo, hi);
> +
> +       data->sfi_data->state = next_perf_state;
> +
> +       return 0;
> +}
> +
> +static int sfi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       unsigned int i, result = 0, valid_states = 0;
> +       unsigned int cpu = policy->cpu;
> +       struct sfi_cpufreq_data *data;
> +
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->sfi_data = kzalloc(sizeof(*data->sfi_data), GFP_KERNEL);
> +       if (!data->sfi_data) {
> +               result = -ENOMEM;
> +               goto err_free1;
> +       }
> +
> +       per_cpu(drv_data, cpu) = data;
> +
> +       result = sfi_cpufreq_register_performance(data->sfi_data);
> +       if (result)
> +               goto err_free2;
> +
> +       policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
> +
> +       data->freq_table = kzalloc(sizeof(*data->freq_table) *
> +                       (data->sfi_data->state_count+1), GFP_KERNEL);
> +       if (!data->freq_table) {
> +               result = -ENOMEM;
> +               goto err_free2;
> +       }
> +
> +       policy->cpuinfo.transition_latency = 0;
> +       for (i = 0; i < data->sfi_data->state_count; i++) {
> +               /* detect transition latency */
> +               if ((data->sfi_data->states[i].latency * 1000) >
> +                   policy->cpuinfo.transition_latency)
> +                       policy->cpuinfo.transition_latency =
> +                               data->sfi_data->states[i].latency * 1000;
> +
> +               /* initialize the freq table */
> +               data->freq_table[valid_states].driver_data = i;
> +               data->freq_table[valid_states].frequency =
> +                               data->sfi_data->states[i].freq_mhz * 1000;
> +               valid_states++;
> +
> +               pr_debug("     %cP%d: %d MHz, %d uS\n",
> +                       (i == data->sfi_data->state ? '*' : ' '), i,
> +                       (u32) data->sfi_data->states[i].freq_mhz,
> +                       (u32) data->sfi_data->states[i].latency);
> +       }
> +
> +       data->freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
> +       data->sfi_data->state = 0;
> +
> +       result = cpufreq_table_validate_and_show(policy, data->freq_table);
> +       if (result)
> +               goto err_freqfree;
> +
> +       pr_debug("CPU%u - SFI performance management activated.\n", cpu);
> +
> +       return result;
> +
> +err_freqfree:
> +       kfree(data->freq_table);
> +err_free2:
> +       per_cpu(drv_data, cpu) = NULL;
> +       kfree(data->sfi_data);
> +err_free1:
> +       kfree(data);
> +
> +       return result;
> +}
> +
> +static int sfi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +       struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
> +
> +       kfree(data->freq_table);
> +       per_cpu(drv_data, policy->cpu) = NULL;
> +       kfree(data->sfi_data);
> +       kfree(data);
> +
> +       return 0;
> +}
> +
> +static struct cpufreq_driver sfi_cpufreq_driver = {
> +       .flags          = CPUFREQ_CONST_LOOPS,
> +       .get            = get_cur_freq_on_cpu,
> +       .verify         = cpufreq_generic_frequency_table_verify,
> +       .target_index   = sfi_cpufreq_target,
> +       .init           = sfi_cpufreq_cpu_init,
> +       .exit           = sfi_cpufreq_cpu_exit,
> +       .name           = "sfi-cpufreq",
> +       .attr           = cpufreq_generic_attr,
> +};
> +
> +static int __init sfi_cpufreq_init(void)
> +{
> +       return cpufreq_register_driver(&sfi_cpufreq_driver);
> +}
> +late_initcall(sfi_cpufreq_init);
> +
> +static void __exit sfi_cpufreq_exit(void)
> +{
> +       cpufreq_unregister_driver(&sfi_cpufreq_driver);
> +}
> +module_exit(sfi_cpufreq_exit);
> +
> +MODULE_AUTHOR("Vishwesh M Rudramuni <vishwesh.m.rudramuni@intel.com>");
> +MODULE_DESCRIPTION("SFI P-States Driver");
> +MODULE_LICENSE("GPL");
> --
> 1.7.9.5
>
>
> --



-- 
Len Brown, Intel Open Source Technology Center
