From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH V2] acpi-cpufreq: replace per_cpu with driver_data of
 policy
Date: Tue, 07 Jul 2015 20:49:06 +0800
Message-ID: <559BCAC2.8020908@intel.com>
References: <559BC96E.8020804@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8170 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757138AbbGGMvj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jul 2015 08:51:39 -0400
In-Reply-To: <559BC96E.8020804@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

hi, all
	thanks for reviewing.
any comments or advices are welcome :)
I am OOO tomorrow, so response may arrive later.

thanks
xinhui

On 2015=E5=B9=B407=E6=9C=8807=E6=97=A5 20:43, Pan Xinhui wrote:
>=20
> Drivers can store their internal per-policy information in
> policy->driver_data, lets use it.
>=20
> we have benefits after this replacing.
> 1) memory saving.
> 2) policy is shared by several cpus, per_cpu seems not correct. using
> *driver_data* is more reasonable.
> 3) fix a memory leak in acpi_cpufreq_cpu_exit. as policy->cpu might
> change during cpu hotplug. So sometimes we cant't free *data*, use
> *driver_data* to fix it.
> 4) fix a zero return value of get_cur_freq_on_cpu. Only per_cpu of
> policy->cpu is set to *data*, if we try to get cpufreq on other cpus,=
 we
> get zero instead of correct values. Use *driver_data* to fix it.
>=20
> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> ---
> Changes from V1:
> 	codes style fix, comments update
> 	move cpufreq_cpu_put(policy) after we get *driver_data*
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 40 ++++++++++++++++++++++----------=
--------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cp=
ufreq.c
> index 0136dfc..e7fcaa6 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -72,8 +72,6 @@ struct acpi_cpufreq_data {
>  	cpumask_var_t freqdomain_cpus;
>  };
> =20
> -static DEFINE_PER_CPU(struct acpi_cpufreq_data *, acfreq_data);
> -
>  /* acpi_perf_data is a pointer to percpu data. */
>  static struct acpi_processor_performance __percpu *acpi_perf_data;
> =20
> @@ -144,7 +142,7 @@ static int _store_boost(int val)
> =20
>  static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, c=
har *buf)
>  {
> -	struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, policy->cpu=
);
> +	struct acpi_cpufreq_data *data =3D policy->driver_data;
> =20
>  	return cpufreq_show_cpus(data->freqdomain_cpus, buf);
>  }
> @@ -327,7 +325,8 @@ static void drv_write(struct drv_cmd *cmd)
>  	put_cpu();
>  }
> =20
> -static u32 get_cur_val(const struct cpumask *mask)
> +static u32
> +get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *da=
ta)
>  {
>  	struct acpi_processor_performance *perf;
>  	struct drv_cmd cmd;
> @@ -335,7 +334,7 @@ static u32 get_cur_val(const struct cpumask *mask=
)
>  	if (unlikely(cpumask_empty(mask)))
>  		return 0;
> =20
> -	switch (per_cpu(acfreq_data, cpumask_first(mask))->cpu_feature) {
> +	switch (data->cpu_feature) {
>  	case SYSTEM_INTEL_MSR_CAPABLE:
>  		cmd.type =3D SYSTEM_INTEL_MSR_CAPABLE;
>  		cmd.addr.msr.reg =3D MSR_IA32_PERF_CTL;
> @@ -346,7 +345,7 @@ static u32 get_cur_val(const struct cpumask *mask=
)
>  		break;
>  	case SYSTEM_IO_CAPABLE:
>  		cmd.type =3D SYSTEM_IO_CAPABLE;
> -		perf =3D per_cpu(acfreq_data, cpumask_first(mask))->acpi_data;
> +		perf =3D data->acpi_data;
>  		cmd.addr.io.port =3D perf->control_register.address;
>  		cmd.addr.io.bit_width =3D perf->control_register.bit_width;
>  		break;
> @@ -364,19 +363,24 @@ static u32 get_cur_val(const struct cpumask *ma=
sk)
> =20
>  static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>  {
> -	struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, cpu);
> +	struct acpi_cpufreq_data *data;
> +	struct cpufreq_policy *policy;
>  	unsigned int freq;
>  	unsigned int cached_freq;
> =20
>  	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
> =20
> -	if (unlikely(data =3D=3D NULL ||
> -		     data->acpi_data =3D=3D NULL || data->freq_table =3D=3D NULL))=
 {
> +	policy =3D cpufreq_cpu_get(cpu);
> +	if (unlikely(!policy))
> +		return 0;
> +
> +	data =3D policy->driver_data;
> +	cpufreq_cpu_put(policy);
> +	if (unlikely(!data || !data->acpi_data || !data->freq_table))
>  		return 0;
> -	}
> =20
>  	cached_freq =3D data->freq_table[data->acpi_data->state].frequency;
> -	freq =3D extract_freq(get_cur_val(cpumask_of(cpu)), data);
> +	freq =3D extract_freq(get_cur_val(cpumask_of(cpu), data), data);
>  	if (freq !=3D cached_freq) {
>  		/*
>  		 * The dreaded BIOS frequency change behind our back.
> @@ -397,7 +401,7 @@ static unsigned int check_freqs(const struct cpum=
ask *mask, unsigned int freq,
>  	unsigned int i;
> =20
>  	for (i =3D 0; i < 100; i++) {
> -		cur_freq =3D extract_freq(get_cur_val(mask), data);
> +		cur_freq =3D extract_freq(get_cur_val(mask, data), data);
>  		if (cur_freq =3D=3D freq)
>  			return 1;
>  		udelay(10);
> @@ -408,7 +412,7 @@ static unsigned int check_freqs(const struct cpum=
ask *mask, unsigned int freq,
>  static int acpi_cpufreq_target(struct cpufreq_policy *policy,
>  			       unsigned int index)
>  {
> -	struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, policy->cpu=
);
> +	struct acpi_cpufreq_data *data =3D policy->driver_data;
>  	struct acpi_processor_performance *perf;
>  	struct drv_cmd cmd;
>  	unsigned int next_perf_state =3D 0; /* Index into perf table */
> @@ -673,7 +677,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_p=
olicy *policy)
>  	}
> =20
>  	data->acpi_data =3D per_cpu_ptr(acpi_perf_data, cpu);
> -	per_cpu(acfreq_data, cpu) =3D data;
> +	policy->driver_data =3D data;
> =20
>  	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC))
>  		acpi_cpufreq_driver.flags |=3D CPUFREQ_CONST_LOOPS;
> @@ -843,19 +847,19 @@ err_free_mask:
>  	free_cpumask_var(data->freqdomain_cpus);
>  err_free:
>  	kfree(data);
> -	per_cpu(acfreq_data, cpu) =3D NULL;
> +	policy->driver_data =3D NULL;
> =20
>  	return result;
>  }
> =20
>  static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
> -	struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, policy->cpu=
);
> +	struct acpi_cpufreq_data *data =3D policy->driver_data;
> =20
>  	pr_debug("acpi_cpufreq_cpu_exit\n");
> =20
>  	if (data) {
> -		per_cpu(acfreq_data, policy->cpu) =3D NULL;
> +		policy->driver_data =3D NULL;
>  		acpi_processor_unregister_performance(data->acpi_data,
>  						      policy->cpu);
>  		free_cpumask_var(data->freqdomain_cpus);
> @@ -868,7 +872,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_p=
olicy *policy)
> =20
>  static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
>  {
> -	struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, policy->cpu=
);
> +	struct acpi_cpufreq_data *data =3D policy->driver_data;
> =20
>  	pr_debug("acpi_cpufreq_resume\n");
> =20
>=20
