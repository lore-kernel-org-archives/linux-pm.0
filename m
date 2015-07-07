From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH] acpi-cpufreq: replace per_cpu with driver_data of policy
Date: Tue, 07 Jul 2015 20:02:05 +0800
Message-ID: <559BBFBD.5040103@intel.com>
References: <559BA9FF.7050702@intel.com> <20150707104553.GN14598@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14213 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754520AbbGGMEm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jul 2015 08:04:42 -0400
In-Reply-To: <20150707104553.GN14598@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

hi, Viresh
	thanks for your reply. :)

On 2015=E5=B9=B407=E6=9C=8807=E6=97=A5 18:45, Viresh Kumar wrote:
> On 07-07-15, 18:29, Pan Xinhui wrote:
>>
>> Now policy has field of driver_data, we can use it to get rid of per=
_cpu
>> acpi_cpufreq_data.
>=20
> Instead:
> "Drivers can store their internal per-policy information in
> policy->driver_data, lets use it."
>=20

thanks.

>> we have benefits after this replacing.  1) memory saving.  2) policy=
 is
>=20
> s/we/We
>=20
> Also these points can be kept in separate lines :)
>=20

agree, thanks for pointing out it.

>> shared by several cpus, per_cpu seems not correct.  useing *driver_d=
ata*
>=20
>                                                       using
>=20
>> is more reasonable.  3) fix a memory leak in acpi_cpufreq_cpu_exit.
>=20
> Not just that. You are also fixing NULL pointer dereferences if wrong
> or uninitialized per-cpu data is used, because of a recent hotplug of
> policy->cpu.
>=20
acpi_cpufreq_cpu_exit has if (data) check.
In past days, I believed in that all per_cpu is initialized to NULL by =
default, like global variables.

>> as
>> policy->cpu might change after cpu hotplug. So sometimes we cant't f=
ree
>> *data*, use *driver_data* to fix it.  4) fix a zero return value of
>> get_cur_freq_on_cpu.  Only per_cpu(policy->cpu) is set to *data*, if=
 we
>> try to get cpufreq on other cpus, we get zero instead of correct val=
ues.
>> Use *driver_data* to fix it.
>>
>> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
>> ---
>>  drivers/cpufreq/acpi-cpufreq.c | 38 +++++++++++++++++++++++--------=
-------
>>  1 file changed, 23 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-c=
pufreq.c
>> index 0136dfc..7f662dd 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -72,8 +72,6 @@ struct acpi_cpufreq_data {
>>  	cpumask_var_t freqdomain_cpus;
>>  };
>> =20
>> -static DEFINE_PER_CPU(struct acpi_cpufreq_data *, acfreq_data);
>> -
>>  /* acpi_perf_data is a pointer to percpu data. */
>>  static struct acpi_processor_performance __percpu *acpi_perf_data;
>> =20
>> @@ -144,7 +142,7 @@ static int _store_boost(int val)
>> =20
>>  static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, =
char *buf)
>>  {
>> -	struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, policy->cp=
u);
>> +	struct acpi_cpufreq_data *data =3D policy->driver_data;
>> =20
>>  	return cpufreq_show_cpus(data->freqdomain_cpus, buf);
>>  }
>> @@ -327,7 +325,8 @@ static void drv_write(struct drv_cmd *cmd)
>>  	put_cpu();
>>  }
>> =20
>> -static u32 get_cur_val(const struct cpumask *mask)
>> +static u32 get_cur_val(const struct cpumask *mask,
>> +				struct acpi_cpufreq_data *data)
>=20
> Run checkpatch --strict to see some alignment warnings here..
>=20
yes, confused..
Let me have a check.

>>  {
>>  	struct acpi_processor_performance *perf;
>>  	struct drv_cmd cmd;
>> @@ -335,7 +334,7 @@ static u32 get_cur_val(const struct cpumask *mas=
k)
>>  	if (unlikely(cpumask_empty(mask)))
>>  		return 0;
>> =20
>> -	switch (per_cpu(acfreq_data, cpumask_first(mask))->cpu_feature) {
>> +	switch (data->cpu_feature) {
>>  	case SYSTEM_INTEL_MSR_CAPABLE:
>>  		cmd.type =3D SYSTEM_INTEL_MSR_CAPABLE;
>>  		cmd.addr.msr.reg =3D MSR_IA32_PERF_CTL;
>> @@ -346,7 +345,7 @@ static u32 get_cur_val(const struct cpumask *mas=
k)
>>  		break;
>>  	case SYSTEM_IO_CAPABLE:
>>  		cmd.type =3D SYSTEM_IO_CAPABLE;
>> -		perf =3D per_cpu(acfreq_data, cpumask_first(mask))->acpi_data;
>> +		perf =3D data->acpi_data;
>>  		cmd.addr.io.port =3D perf->control_register.address;
>>  		cmd.addr.io.bit_width =3D perf->control_register.bit_width;
>>  		break;
>> @@ -364,19 +363,26 @@ static u32 get_cur_val(const struct cpumask *m=
ask)
>> =20
>>  static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>>  {
>> -	struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, cpu);
>> +	struct acpi_cpufreq_data *data;
>> +	struct cpufreq_policy *policy;
>>  	unsigned int freq;
>>  	unsigned int cached_freq;
>> =20
>>  	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
>> =20
>> +	policy =3D cpufreq_cpu_get(cpu);
>> +	if (unlikely(!policy))
>> +		return 0;
>> +
>> +	data =3D policy->driver_data;
>=20
> Do
>=20
> +		cpufreq_cpu_put(policy);
>=20
> right here. No need of doing this towards the end.
>=20
agree
thanks

>>  	if (unlikely(data =3D=3D NULL ||
>>  		     data->acpi_data =3D=3D NULL || data->freq_table =3D=3D NULL)=
) {
>=20
> Maybe this if you like:
>=20
>   	if (unlikely(! data || !data->acpi_data || !data->freq_table))
>                 return 0;
>
Looks better
thanks

>> +		cpufreq_cpu_put(policy);
>>  		return 0;
>>  	}
>> =20
>>  	cached_freq =3D data->freq_table[data->acpi_data->state].frequency=
;
>=20
> And this freq_table thing gives you opportunity to write another
> patch :)
>=20
> policy already have: policy->freq_table :)
>=20

Yes, upstream codes changes much.
These changes really help us. thanks for your hard work. :)

>> -	freq =3D extract_freq(get_cur_val(cpumask_of(cpu)), data);
>> +	freq =3D extract_freq(get_cur_val(cpumask_of(cpu), data), data);
>>  	if (freq !=3D cached_freq) {
>>  		/*
>>  		 * The dreaded BIOS frequency change behind our back.
>> @@ -385,6 +391,8 @@ static unsigned int get_cur_freq_on_cpu(unsigned=
 int cpu)
>>  		data->resume =3D 1;
>>  	}
>> =20
>> +	cpufreq_cpu_put(policy);
>> +
>>  	pr_debug("cur freq =3D %u\n", freq);
>> =20
>>  	return freq;
>> @@ -397,7 +405,7 @@ static unsigned int check_freqs(const struct cpu=
mask *mask, unsigned int freq,
>>  	unsigned int i;
>> =20
>>  	for (i =3D 0; i < 100; i++) {
>> -		cur_freq =3D extract_freq(get_cur_val(mask), data);
>> +		cur_freq =3D extract_freq(get_cur_val(mask, data), data);
>>  		if (cur_freq =3D=3D freq)
>>  			return 1;
>>  		udelay(10);
>> @@ -408,7 +416,7 @@ static unsigned int check_freqs(const struct cpu=
mask *mask, unsigned int freq,
>>  static int acpi_cpufreq_target(struct cpufreq_policy *policy,
>>  			       unsigned int index)
>>  {
>> -	struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, policy->cp=
u);
>> +	struct acpi_cpufreq_data *data =3D policy->driver_data;
>>  	struct acpi_processor_performance *perf;
>>  	struct drv_cmd cmd;
>>  	unsigned int next_perf_state =3D 0; /* Index into perf table */
>> @@ -673,7 +681,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_=
policy *policy)
>>  	}
>> =20
>>  	data->acpi_data =3D per_cpu_ptr(acpi_perf_data, cpu);
>> -	per_cpu(acfreq_data, cpu) =3D data;
>> +	policy->driver_data =3D data;
>> =20
>>  	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC))
>>  		acpi_cpufreq_driver.flags |=3D CPUFREQ_CONST_LOOPS;
>> @@ -843,19 +851,19 @@ err_free_mask:
>>  	free_cpumask_var(data->freqdomain_cpus);
>>  err_free:
>>  	kfree(data);
>> -	per_cpu(acfreq_data, cpu) =3D NULL;
>> +	policy->driver_data =3D NULL;
>> =20
>>  	return result;
>>  }
>> =20
>>  static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>>  {
>> -	struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, policy->cp=
u);
>> +	struct acpi_cpufreq_data *data =3D policy->driver_data;
>> =20
>>  	pr_debug("acpi_cpufreq_cpu_exit\n");
>> =20
>>  	if (data) {
>> -		per_cpu(acfreq_data, policy->cpu) =3D NULL;
>> +		policy->driver_data =3D NULL;
>>  		acpi_processor_unregister_performance(data->acpi_data,
>>  						      policy->cpu);
>>  		free_cpumask_var(data->freqdomain_cpus);
>> @@ -868,7 +876,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_=
policy *policy)
>> =20
>>  static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
>>  {
>> -	struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, policy->cp=
u);
>> +	struct acpi_cpufreq_data *data =3D policy->driver_data;
>> =20
>>  	pr_debug("acpi_cpufreq_resume\n");
>=20
> Rest looks fine.
>=20

thanks
xinhui
