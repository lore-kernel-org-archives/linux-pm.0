From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] acpi-cpufreq: replace per_cpu with driver_data of policy
Date: Tue, 7 Jul 2015 16:15:53 +0530
Message-ID: <20150707104553.GN14598@linux>
References: <559BA9FF.7050702@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33991 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbbGGKp7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 06:45:59 -0400
Received: by pabvl15 with SMTP id vl15so111473731pab.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2015 03:45:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <559BA9FF.7050702@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

On 07-07-15, 18:29, Pan Xinhui wrote:
> 
> Now policy has field of driver_data, we can use it to get rid of per_cpu
> acpi_cpufreq_data.

Instead:
"Drivers can store their internal per-policy information in
policy->driver_data, lets use it."

> we have benefits after this replacing.  1) memory saving.  2) policy is

s/we/We

Also these points can be kept in separate lines :)

> shared by several cpus, per_cpu seems not correct.  useing *driver_data*

                                                      using

> is more reasonable.  3) fix a memory leak in acpi_cpufreq_cpu_exit.

Not just that. You are also fixing NULL pointer dereferences if wrong
or uninitialized per-cpu data is used, because of a recent hotplug of
policy->cpu.

> as
> policy->cpu might change after cpu hotplug. So sometimes we cant't free
> *data*, use *driver_data* to fix it.  4) fix a zero return value of
> get_cur_freq_on_cpu.  Only per_cpu(policy->cpu) is set to *data*, if we
> try to get cpufreq on other cpus, we get zero instead of correct values.
> Use *driver_data* to fix it.
> 
> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 0136dfc..7f662dd 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -72,8 +72,6 @@ struct acpi_cpufreq_data {
>  	cpumask_var_t freqdomain_cpus;
>  };
>  
> -static DEFINE_PER_CPU(struct acpi_cpufreq_data *, acfreq_data);
> -
>  /* acpi_perf_data is a pointer to percpu data. */
>  static struct acpi_processor_performance __percpu *acpi_perf_data;
>  
> @@ -144,7 +142,7 @@ static int _store_boost(int val)
>  
>  static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>  {
> -	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, policy->cpu);
> +	struct acpi_cpufreq_data *data = policy->driver_data;
>  
>  	return cpufreq_show_cpus(data->freqdomain_cpus, buf);
>  }
> @@ -327,7 +325,8 @@ static void drv_write(struct drv_cmd *cmd)
>  	put_cpu();
>  }
>  
> -static u32 get_cur_val(const struct cpumask *mask)
> +static u32 get_cur_val(const struct cpumask *mask,
> +				struct acpi_cpufreq_data *data)

Run checkpatch --strict to see some alignment warnings here..

>  {
>  	struct acpi_processor_performance *perf;
>  	struct drv_cmd cmd;
> @@ -335,7 +334,7 @@ static u32 get_cur_val(const struct cpumask *mask)
>  	if (unlikely(cpumask_empty(mask)))
>  		return 0;
>  
> -	switch (per_cpu(acfreq_data, cpumask_first(mask))->cpu_feature) {
> +	switch (data->cpu_feature) {
>  	case SYSTEM_INTEL_MSR_CAPABLE:
>  		cmd.type = SYSTEM_INTEL_MSR_CAPABLE;
>  		cmd.addr.msr.reg = MSR_IA32_PERF_CTL;
> @@ -346,7 +345,7 @@ static u32 get_cur_val(const struct cpumask *mask)
>  		break;
>  	case SYSTEM_IO_CAPABLE:
>  		cmd.type = SYSTEM_IO_CAPABLE;
> -		perf = per_cpu(acfreq_data, cpumask_first(mask))->acpi_data;
> +		perf = data->acpi_data;
>  		cmd.addr.io.port = perf->control_register.address;
>  		cmd.addr.io.bit_width = perf->control_register.bit_width;
>  		break;
> @@ -364,19 +363,26 @@ static u32 get_cur_val(const struct cpumask *mask)
>  
>  static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>  {
> -	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, cpu);
> +	struct acpi_cpufreq_data *data;
> +	struct cpufreq_policy *policy;
>  	unsigned int freq;
>  	unsigned int cached_freq;
>  
>  	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
>  
> +	policy = cpufreq_cpu_get(cpu);
> +	if (unlikely(!policy))
> +		return 0;
> +
> +	data = policy->driver_data;

Do

+		cpufreq_cpu_put(policy);

right here. No need of doing this towards the end.

>  	if (unlikely(data == NULL ||
>  		     data->acpi_data == NULL || data->freq_table == NULL)) {

Maybe this if you like:

  	if (unlikely(! data || !data->acpi_data || !data->freq_table))
                return 0;

> +		cpufreq_cpu_put(policy);
>  		return 0;
>  	}
>  
>  	cached_freq = data->freq_table[data->acpi_data->state].frequency;

And this freq_table thing gives you opportunity to write another
patch :)

policy already have: policy->freq_table :)

> -	freq = extract_freq(get_cur_val(cpumask_of(cpu)), data);
> +	freq = extract_freq(get_cur_val(cpumask_of(cpu), data), data);
>  	if (freq != cached_freq) {
>  		/*
>  		 * The dreaded BIOS frequency change behind our back.
> @@ -385,6 +391,8 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>  		data->resume = 1;
>  	}
>  
> +	cpufreq_cpu_put(policy);
> +
>  	pr_debug("cur freq = %u\n", freq);
>  
>  	return freq;
> @@ -397,7 +405,7 @@ static unsigned int check_freqs(const struct cpumask *mask, unsigned int freq,
>  	unsigned int i;
>  
>  	for (i = 0; i < 100; i++) {
> -		cur_freq = extract_freq(get_cur_val(mask), data);
> +		cur_freq = extract_freq(get_cur_val(mask, data), data);
>  		if (cur_freq == freq)
>  			return 1;
>  		udelay(10);
> @@ -408,7 +416,7 @@ static unsigned int check_freqs(const struct cpumask *mask, unsigned int freq,
>  static int acpi_cpufreq_target(struct cpufreq_policy *policy,
>  			       unsigned int index)
>  {
> -	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, policy->cpu);
> +	struct acpi_cpufreq_data *data = policy->driver_data;
>  	struct acpi_processor_performance *perf;
>  	struct drv_cmd cmd;
>  	unsigned int next_perf_state = 0; /* Index into perf table */
> @@ -673,7 +681,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	}
>  
>  	data->acpi_data = per_cpu_ptr(acpi_perf_data, cpu);
> -	per_cpu(acfreq_data, cpu) = data;
> +	policy->driver_data = data;
>  
>  	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC))
>  		acpi_cpufreq_driver.flags |= CPUFREQ_CONST_LOOPS;
> @@ -843,19 +851,19 @@ err_free_mask:
>  	free_cpumask_var(data->freqdomain_cpus);
>  err_free:
>  	kfree(data);
> -	per_cpu(acfreq_data, cpu) = NULL;
> +	policy->driver_data = NULL;
>  
>  	return result;
>  }
>  
>  static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
> -	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, policy->cpu);
> +	struct acpi_cpufreq_data *data = policy->driver_data;
>  
>  	pr_debug("acpi_cpufreq_cpu_exit\n");
>  
>  	if (data) {
> -		per_cpu(acfreq_data, policy->cpu) = NULL;
> +		policy->driver_data = NULL;
>  		acpi_processor_unregister_performance(data->acpi_data,
>  						      policy->cpu);
>  		free_cpumask_var(data->freqdomain_cpus);
> @@ -868,7 +876,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  
>  static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
>  {
> -	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, policy->cpu);
> +	struct acpi_cpufreq_data *data = policy->driver_data;
>  
>  	pr_debug("acpi_cpufreq_resume\n");

Rest looks fine.

-- 
viresh
