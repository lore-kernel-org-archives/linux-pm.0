From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 2/2 V2] CPUFreq: Add new sysfs attribute freqdomain_cpus
 for acpi-freq driver
Date: Thu, 27 Jun 2013 09:53:51 +0800
Message-ID: <51CB9B2F.1090508@intel.com>
References: <1372250304-20975-1-git-send-email-tianyu.lan@intel.com> <7392221.sLUEUIm1sY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <7392221.sLUEUIm1sY@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, viresh.kumar@linaro.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2013=E5=B9=B406=E6=9C=8827=E6=97=A5 08:10, Rafael J. Wysocki wrote:
> On Wednesday, June 26, 2013 08:38:24 PM Lan Tianyu wrote:
>> Commit aa77a52 and fcf8058 changes the content of "related_cpus" and=
 user
>> space can't get cpus which are in the same hardware coordination cpu=
 domain
>> (These info are provided by ACPI AML method _PSD) via "related_cpus"=
=2E This
>> change affects some users of original "related_cpus".
>>
>> This patch is to add a new sysfs attribute "freqdomian_cpus" for acp=
i-cpufreq
>> driver which exposes all cpus in the same domain regardless of hardw=
are or
>> software coordination to make up the info loss of previous change.
>>
>> Reference:https://bugzilla.kernel.org/show_bug.cgi?id=3D58761
>> Reported-by: Jean-Philippe Halimi <jean-philippe.halimi@exascale-com=
puting.eu>
>=20
> It looks from the bug entry that this has been tested too?

V1 has been tested by Jean-Philippe but for V2, I have changed some
codes. So I didn't add tested-by.

>=20
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>> Change since v1:
>>      Create new file acpi-cpufreq.txt under Documentation/cpu-freq a=
nd
>> move new attribute descriptor to it.
>>      Add new field freqdomain_cpus in struct acpi_cpufreq_data and r=
ecord
>> cpu domain info in it. For AMD case, use sibling cpus info to overwr=
ite
>> cpu domain info from ACPI.       =20
>>
>>  Documentation/cpu-freq/acpi-cpufreq.txt |    7 +++++++
>>  drivers/cpufreq/acpi-cpufreq.c          |   23 ++++++++++++++++++++=
++-
>>  drivers/cpufreq/cpufreq.c               |    7 ++++---
>>  include/linux/cpufreq.h                 |    3 +++
>>  4 files changed, 36 insertions(+), 4 deletions(-)
>>  create mode 100644 Documentation/cpu-freq/acpi-cpufreq.txt
>>
>> diff --git a/Documentation/cpu-freq/acpi-cpufreq.txt b/Documentation=
/cpu-freq/acpi-cpufreq.txt
>> new file mode 100644
>> index 0000000..9c59d09
>> --- /dev/null
>> +++ b/Documentation/cpu-freq/acpi-cpufreq.txt
>> @@ -0,0 +1,7 @@
>> +Sysfs interface
>> +---------------------------
>> +(Interface locates in the directory /sys/devices/system/cpu/cpuN/cp=
ufreq)
>> +
>> +freqdomain_cpus :               List of Online + Offline CPUs in sa=
me CPU dependency
>> +                                domain.
>> +
>=20
> No, this is confusing.
>

Ok.

> Please document it in Documentation/ABI/testing/sysfs-devices-system-=
cpu below
> the /sys/devices/system/cpu/cpu#/cpufreq/* thing, but please write in=
 the
> description that this is only present if the acpi-cpufreq driver is i=
n use.

I will update soon.

>=20
> Thanks,
> Rafael
>=20
>=20
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-c=
pufreq.c
>> index f4fef0a..3926402 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -70,6 +70,7 @@ struct acpi_cpufreq_data {
>>  	struct cpufreq_frequency_table *freq_table;
>>  	unsigned int resume;
>>  	unsigned int cpu_feature;
>> +	cpumask_var_t freqdomain_cpus;
>>  };
>> =20
>>  static DEFINE_PER_CPU(struct acpi_cpufreq_data *, acfreq_data);
>> @@ -176,6 +177,15 @@ static struct global_attr global_boost =3D __AT=
TR(boost, 0644,
>>  						show_global_boost,
>>  						store_global_boost);
>> =20
>> +static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, =
char *buf)
>> +{
>> +	struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, policy->cp=
u);
>> +
>> +	return cpufreq_show_cpus(data->freqdomain_cpus, buf);
>> +}
>> +
>> +cpufreq_freq_attr_ro(freqdomain_cpus);
>> +
>>  #ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
>>  static ssize_t store_cpb(struct cpufreq_policy *policy, const char =
*buf,
>>  			 size_t count)
>> @@ -704,6 +714,11 @@ static int acpi_cpufreq_cpu_init(struct cpufreq=
_policy *policy)
>>  	if (!data)
>>  		return -ENOMEM;
>> =20
>> +	if (!zalloc_cpumask_var(&data->freqdomain_cpus, GFP_KERNEL)) {
>> +		result =3D -ENOMEM;
>> +		goto err_free;
>> +	}
>> +
>>  	data->acpi_data =3D per_cpu_ptr(acpi_perf_data, cpu);
>>  	per_cpu(acfreq_data, cpu) =3D data;
>> =20
>> @@ -712,7 +727,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_=
policy *policy)
>> =20
>>  	result =3D acpi_processor_register_performance(data->acpi_data, cp=
u);
>>  	if (result)
>> -		goto err_free;
>> +		goto err_free_mask;
>> =20
>>  	perf =3D data->acpi_data;
>>  	policy->shared_type =3D perf->shared_type;
>> @@ -725,6 +740,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_=
policy *policy)
>>  	    policy->shared_type =3D=3D CPUFREQ_SHARED_TYPE_ANY) {
>>  		cpumask_copy(policy->cpus, perf->shared_cpu_map);
>>  	}
>> +	cpumask_copy(data->freqdomain_cpus, perf->shared_cpu_map);
>> =20
>>  #ifdef CONFIG_SMP
>>  	dmi_check_system(sw_any_bug_dmi_table);
>> @@ -736,6 +752,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_=
policy *policy)
>>  	if (check_amd_hwpstate_cpu(cpu) && !acpi_pstate_strict) {
>>  		cpumask_clear(policy->cpus);
>>  		cpumask_set_cpu(cpu, policy->cpus);
>> +		cpumask_copy(data->freqdomain_cpus, cpu_sibling_mask(cpu));
>>  		policy->shared_type =3D CPUFREQ_SHARED_TYPE_HW;
>>  		pr_info_once(PFX "overriding BIOS provided _PSD data\n");
>>  	}
>> @@ -870,6 +887,8 @@ err_freqfree:
>>  	kfree(data->freq_table);
>>  err_unreg:
>>  	acpi_processor_unregister_performance(perf, cpu);
>> +err_free_mask:
>> +	free_cpumask_var(data->freqdomain_cpus);
>>  err_free:
>>  	kfree(data);
>>  	per_cpu(acfreq_data, cpu) =3D NULL;
>> @@ -888,6 +907,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_=
policy *policy)
>>  		per_cpu(acfreq_data, policy->cpu) =3D NULL;
>>  		acpi_processor_unregister_performance(data->acpi_data,
>>  						      policy->cpu);
>> +		free_cpumask_var(data->freqdomain_cpus);
>>  		kfree(data->freq_table);
>>  		kfree(data);
>>  	}
>> @@ -908,6 +928,7 @@ static int acpi_cpufreq_resume(struct cpufreq_po=
licy *policy)
>> =20
>>  static struct freq_attr *acpi_cpufreq_attr[] =3D {
>>  	&cpufreq_freq_attr_scaling_available_freqs,
>> +	&freqdomain_cpus,
>>  	NULL,	/* this is a placeholder for cpb, do not remove */
>>  	NULL,
>>  };
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index d976e22..adf12a9f 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -573,7 +573,7 @@ out:
>>  	return i;
>>  }
>> =20
>> -static ssize_t show_cpus(const struct cpumask *mask, char *buf)
>> +ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
>>  {
>>  	ssize_t i =3D 0;
>>  	unsigned int cpu;
>> @@ -588,6 +588,7 @@ static ssize_t show_cpus(const struct cpumask *m=
ask, char *buf)
>>  	i +=3D sprintf(&buf[i], "\n");
>>  	return i;
>>  }
>> +EXPORT_SYMBOL_GPL(cpufreq_show_cpus);
>> =20
>>  /**
>>   * show_related_cpus - show the CPUs affected by each transition ev=
en if
>> @@ -595,7 +596,7 @@ static ssize_t show_cpus(const struct cpumask *m=
ask, char *buf)
>>   */
>>  static ssize_t show_related_cpus(struct cpufreq_policy *policy, cha=
r *buf)
>>  {
>> -	return show_cpus(policy->related_cpus, buf);
>> +	return cpufreq_show_cpus(policy->related_cpus, buf);
>>  }
>> =20
>>  /**
>> @@ -603,7 +604,7 @@ static ssize_t show_related_cpus(struct cpufreq_=
policy *policy, char *buf)
>>   */
>>  static ssize_t show_affected_cpus(struct cpufreq_policy *policy, ch=
ar *buf)
>>  {
>> -	return show_cpus(policy->cpus, buf);
>> +	return cpufreq_show_cpus(policy->cpus, buf);
>>  }
>> =20
>>  static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy=
,
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 3c7ee2f..5fedb6c 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -438,4 +438,7 @@ void cpufreq_frequency_table_get_attr(struct cpu=
freq_frequency_table *table,
>>  void cpufreq_frequency_table_update_policy_cpu(struct cpufreq_polic=
y *policy);
>> =20
>>  void cpufreq_frequency_table_put_attr(unsigned int cpu);
>> +
>> +ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf);
>> +
>>  #endif /* _LINUX_CPUFREQ_H */
>>


--=20
Best regards
Tianyu Lan
