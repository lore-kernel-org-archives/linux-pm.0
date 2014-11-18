From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5] cpufreq: Add SFI based cpufreq driver support
Date: Tue, 18 Nov 2014 16:33:47 +0530
Message-ID: <CAKohpokVi-6+mwhm6qqWCbjnNmm0L-3=6hezYBNg2zoE=ov=5Q@mail.gmail.com>
References: <20141118054537.GA28516@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:48936 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbaKRLDs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Nov 2014 06:03:48 -0500
Received: by mail-oi0-f53.google.com with SMTP id x69so2341962oia.12
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2014 03:03:47 -0800 (PST)
In-Reply-To: <20141118054537.GA28516@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rudramuni, Vishwesh M" <vishwesh.m.rudramuni@intel.com>, Len Brown <lenb@kernel.org>

On 18 November 2014 11:15, Srinidhi Kasagar <srinidhi.kasagar@intel.com> wrote:
> diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c
> +static int parse_freq(struct sfi_table_header *table)

When this can't fail, why should it return a int?

> +{
> +       struct sfi_table_simple *sb;
> +
> +       sb = (struct sfi_table_simple *)table;
> +
> +       sfi_cpufreq_num = SFI_GET_NUM_ENTRIES(sb, struct sfi_freq_table_entry);
> +       f_entry = (struct sfi_freq_table_entry *)sb->pentry;
> +
> +       return 0;
> +}
> +
> +static int sfi_cpufreq_register_performance(struct sfi_cpufreq_performance *pr)
> +{
> +       mutex_lock(&performance_mutex);
> +
> +       /* parse the freq table from SFI */
> +       sfi_table_parse(SFI_SIG_FREQ, NULL, NULL, parse_freq);
> +
> +       pr->state_count = sfi_cpufreq_num;
> +       if (pr->state_count <= 1) {
> +               pr_err("No p-states discovered\n");
> +               return -ENODEV;
> +       }
> +
> +       pr->states = f_entry;
> +
> +       mutex_unlock(&performance_mutex);
> +
> +       return 0;
> +}
> +
> +static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
> +{
> +       u32 lo, hi, sfi_ctrl;
> +       struct sfi_cpufreq_performance *perf;
> +       struct cpufreq_frequency_table *pos;
> +       struct sfi_cpufreq_data *data = per_cpu(drv_data, cpu);
> +
> +       rdmsr_on_cpu(cpu, MSR_IA32_PERF_CTL, &lo, &hi);
> +       lo &= SFI_FREQ_MASK;
> +
> +       perf = data->sfi_data;
> +
> +       cpufreq_for_each_entry(pos, data->freq_table) {
> +               sfi_ctrl = perf->states[pos->driver_data].ctrl_val
> +                       & SFI_FREQ_MASK;
> +               if (sfi_ctrl == lo)
> +                       return pos->frequency;
> +       }
> +       return data->freq_table[0].frequency;
> +}
> +
> +static int sfi_cpufreq_target(struct cpufreq_policy *policy,
> +                               unsigned int index)
> +{
> +       struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
> +       struct sfi_cpufreq_performance *perf;
> +       unsigned int next_perf_state = 0; /* Index into perf table */
> +       u32 lo, hi;
> +
> +       perf = data->sfi_data;
> +       next_perf_state = data->freq_table[index].driver_data;
> +
> +       rdmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, &lo, &hi);
> +       lo = (lo & ~INTEL_PERF_CTL_MASK) |
> +               ((u32) perf->states[next_perf_state].ctrl_val &
> +                       INTEL_PERF_CTL_MASK);
> +       wrmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, lo, hi);
> +
> +       perf->state = next_perf_state;

Can use data->sfi_data->state = next_perf_state here directly and
drop local var 'perf'.

> +
> +       return 0;
> +}
> +
> +static int sfi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       unsigned int i, result = 0, valid_states = 0;
> +       unsigned int cpu = policy->cpu;
> +       struct sfi_cpufreq_data *data;
> +       struct sfi_cpufreq_performance *perf;
> +
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->sfi_data = per_cpu_ptr(sfi_perf_data, cpu);

I told you this before and this is still broken:

> Your code is dependent on policy->cpu at multiple places and it can change on
> CPU hotplug.

To explain again, in your case a single policy will have two CPUs.
Groups are: 0-1 and 2-3.
policy->cpu for both policies are 0 and 2.

If we hotplug out cpu 0 or cpu 2, policy->cpu will be updated to 1 and 3.

And then the above per-cpu variable access will return NULL, as you
have initialized
them just for 0 and 2, not 1 and 3.

> +       per_cpu(drv_data, cpu) = data;
> +
> +       result = sfi_cpufreq_register_performance(data->sfi_data);
> +       if (result)
> +               goto err_free;
> +
> +       perf = data->sfi_data;
> +       policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
> +
> +       data->freq_table = kzalloc(sizeof(*data->freq_table) *
> +                               (perf->state_count+1), GFP_KERNEL);
> +       if (!data->freq_table) {
> +               result = -ENOMEM;
> +               goto err_free;
> +       }
> +
> +       policy->cpuinfo.transition_latency = 0;
> +       for (i = 0; i < perf->state_count; i++) {
> +               /* detect transition latency */
> +               if ((perf->states[i].latency * 1000) >
> +                   policy->cpuinfo.transition_latency)
> +                       policy->cpuinfo.transition_latency =
> +                               perf->states[i].latency * 1000;
> +
> +               /* initialize the freq table */
> +               data->freq_table[valid_states].driver_data = i;
> +               data->freq_table[valid_states].frequency =
> +                               perf->states[i].freq_mhz * 1000;
> +               valid_states++;
> +
> +               pr_debug("     %cP%d: %d MHz, %d uS\n",
> +                       (i == perf->state ? '*' : ' '), i,
> +                       (u32) perf->states[i].freq_mhz,
> +                       (u32) perf->states[i].latency);
> +       }
> +
> +       data->freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
> +       perf->state = 0;
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
> +err_free:
> +       kfree(data);
> +       per_cpu(drv_data, cpu) = NULL;

Order of these two instructions must be reversed..

> +
> +       return result;
> +}
> +
> +static int sfi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +       struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
> +
> +       per_cpu(drv_data, policy->cpu) = NULL;
> +       kfree(data->freq_table);
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
> +       sfi_perf_data = alloc_percpu(struct sfi_cpufreq_performance);

Why do you need a per-cpu struct for this? Its per-policy and so you
better allocate it at runtime from ->init() call.

> +       if (!sfi_perf_data) {
> +               pr_err("Memory allocation error for sfi_perf_data.\n");
> +               return -ENOMEM;
> +       }
> +
> +       return cpufreq_register_driver(&sfi_cpufreq_driver);
> +}
> +late_initcall(sfi_cpufreq_init);
> +
> +static void __exit sfi_cpufreq_exit(void)
> +{
> +       cpufreq_unregister_driver(&sfi_cpufreq_driver);
> +       free_percpu(sfi_perf_data);
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
