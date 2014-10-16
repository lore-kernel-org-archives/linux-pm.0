From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Add sfi based cpufreq driver support
Date: Thu, 16 Oct 2014 14:18:27 +0530
Message-ID: <CAKohpom-8+H-u_PkVNrwfE+ugo_g3RmrnD-koQfXkcBaXTBh2A@mail.gmail.com>
References: <20141015065309.GA10590@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:49232 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaJPIs1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Oct 2014 04:48:27 -0400
Received: by mail-oi0-f50.google.com with SMTP id i138so2360947oig.9
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2014 01:48:27 -0700 (PDT)
In-Reply-To: <20141015065309.GA10590@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rudramuni, Vishwesh M" <vishwesh.m.rudramuni@intel.com>

On 15 October 2014 12:23, Srinidhi Kasagar <srinidhi.kasagar@intel.com> wrote:
> This adds the sfi based cpu freq driver for some of the
> Intel's Silver Mont based atom architectures like
> Merrifield and Moorfield (intel-mid)
>
> Signed-off-by: Rudramuni, Vishwesh M <vishwesh.m.rudramuni@intel.com>
> Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> ---

Always good to let people know what changed from previous version.

> diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c
> +static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
> +{
> +       struct sfi_cpufreq_data *data = per_cpu(drv_data, cpu);
> +       unsigned int cached_freq;
> +
> +       pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
> +
> +       cached_freq = data->freq_table[data->sfi_data->state].frequency;

Are you sure cached_freq is used at all ? And if not, then you don't need
to pass 'data' in exact_freq(), just get it there..

> +       return extract_freq(get_cur_val(cpumask_of(cpu)), data);
> +
> +}
> +
> +static int sfi_cpufreq_target(struct cpufreq_policy *policy,
> +                               unsigned int index)
> +{
> +       struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
> +       struct sfi_processor_performance *perf;
> +       unsigned int next_perf_state = 0; /* Index into perf table */
> +       u32 lo, hi;
> +
> +       perf = data->sfi_data;
> +       next_perf_state = data->freq_table[index].driver_data;
> +
> +       rdmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, &lo, &hi);
> +       lo = (lo & ~INTEL_MSR_RANGE) |
> +               ((u32) perf->states[next_perf_state].control & INTEL_MSR_RANGE);
> +       wrmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, lo, hi);
> +
> +       perf->state = next_perf_state;

This looks much better now :)

> +       return 0;
> +}
> +
> +static int sfi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       unsigned int i, result = 0, valid_states = 0;
> +       unsigned int cpu = policy->cpu;
> +       struct sfi_cpufreq_data *data;
> +       struct sfi_processor_performance *perf;
> +
> +       pr_debug("%s: CPU:%d\n", __func__, policy->cpu);

Use cpu here instead of policy->cpu ?

> +
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->sfi_data = per_cpu_ptr(sfi_perf_data, cpu);
> +       per_cpu(drv_data, cpu) = data;
> +
> +       result = sfi_processor_register_performance(data->sfi_data);
> +       if (result)
> +               goto err_free;
> +
> +       perf = data->sfi_data;
> +       policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
> +
> +       /* capability check */
> +       if (perf->state_count <= 1) {
> +               pr_debug("No P-States\n");
> +               result = -ENODEV;
> +               goto err_unreg;
> +       }
> +
> +       data->freq_table = kzalloc(sizeof(*data->freq_table) *
> +                               (perf->state_count+1), GFP_KERNEL);
> +       if (!data->freq_table) {
> +               result = -ENOMEM;
> +               goto err_unreg;
> +       }
> +
> +       /* detect transition latency */
> +       policy->cpuinfo.transition_latency = 0;
> +       for (i = 0; i < perf->state_count; i++) {
> +               if ((perf->states[i].transition_latency * 1000) >
> +                   policy->cpuinfo.transition_latency)
> +                       policy->cpuinfo.transition_latency =
> +                           perf->states[i].transition_latency * 1000;
> +
> +               pr_debug("     %cP%d: %d MHz, %d uS\n",
> +                       (i == perf->state ? '*' : ' '), i,
> +                       (u32) perf->states[i].core_frequency,
> +                       (u32) perf->states[i].transition_latency);
> +       }
> +
> +       /* initialize the freq table */
> +       for (i = 0; i < perf->state_count; i++) {
> +               data->freq_table[valid_states].driver_data = i;
> +               data->freq_table[valid_states].frequency =
> +                   perf->states[i].core_frequency * 1000;
> +               valid_states++;
> +       }

Why not merge both 'for' loops?

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
> +err_unreg:
> +       sfi_processor_unregister_performance(perf);
> +err_free:
> +       kfree(data);
> +       per_cpu(drv_data, cpu) = NULL;
> +
> +       return result;
> +}
> +
> +static int sfi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +       struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
> +
> +       pr_debug("sfi_cpufreq_cpu_exit\n");
> +
> +       per_cpu(drv_data, policy->cpu) = NULL;
> +       sfi_processor_unregister_performance(data->sfi_data);
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
> +       sfi_perf_data = alloc_percpu(struct sfi_processor_performance);
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

Looks fine otherwise.
