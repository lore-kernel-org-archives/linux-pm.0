From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 2/2] CPUFreq: Add new sysfs attribute freqdomain_cpus
 for acpi-freq driver
Date: Tue, 25 Jun 2013 14:54:22 +0800
Message-ID: <51C93E9E.3030107@intel.com>
References: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com> <1372126006-4950-2-git-send-email-tianyu.lan@intel.com> <CAKohpokUmvkkGwCDDa1d8OCz8YcsE2J0GQkA-dJ=EE+6REm7Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokUmvkkGwCDDa1d8OCz8YcsE2J0GQkA-dJ=EE+6REm7Mg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi Viresh
	Thanks for your review.

On 2013=E5=B9=B406=E6=9C=8825=E6=97=A5 11:56, Viresh Kumar wrote:
> On 25 June 2013 07:36, Lan Tianyu <tianyu.lan@intel.com> wrote:
>> diff --git a/Documentation/cpu-freq/user-guide.txt b/Documentation/c=
pu-freq/user-guide.txt
>> index ff2f283..0cc72f7 100644
>> --- a/Documentation/cpu-freq/user-guide.txt
>> +++ b/Documentation/cpu-freq/user-guide.txt
>> @@ -196,6 +196,10 @@ affected_cpus :                    List of Onli=
ne CPUs that require software
>>  related_cpus :                 List of Online + Offline CPUs that n=
eed software
>>                                 coordination of frequency.
>>
>> +freqdomain_cpus :              List of Online + Offline CPUs in sam=
e CPU dependency
>> +                               domain. (This is only available for =
acpi-cpufreq
>> +                               driver)
>> +
>=20
> This is generic file, don't add this information here. Add this in
> acpi-cpufreq file.
I don't find acpi-cpufreq.txt under
Documentation/cpu-freq/acpi-cpufreq.txt. So I should create it?

>=20
>>  scaling_driver :               Hardware driver for cpufreq.
>>
>>  scaling_cur_freq :             Current frequency of the CPU as dete=
rmined by
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-c=
pufreq.c
>> index 17e3496..b859997 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -176,6 +176,16 @@ static struct global_attr global_boost =3D __AT=
TR(boost, 0644,
>>                                                 show_global_boost,
>>                                                 store_global_boost);
>>
>> +static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, =
char *buf)
>> +{
>> +       struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, poli=
cy->cpu);
>> +       struct acpi_processor_performance *perf =3D data->acpi_data;
>> +
>> +       return cpufreq_show_cpus(perf->shared_cpu_map, buf);
>> +}
>=20
> I am not sure if this is enough. Check this commit:
>=20
> aa77a52764a92216b61a6c8079b5c01937c046cd
>=20
> It had these changes:

Please see the acpi_processor_preregister_performance() in the
drivers/acpi/processor_perlib.c. All cpus in the same dependency domain
are stored in the perf->shared_cpu_map(including the reference cpu the
perf belongs to). Original code will copy shared_cpu_map to
policy->related_cpus, do cpumask_or between policy->related_cpus and
policy->cpus in the cpufreq_add_dev() and store the result into
policy->related_cpus. Expose the data via related_cpus.

=46or acpi-cpufreq driver, the shared_cpu_map is the biggest subset sin=
ce
it regardless the coordination type.

After the commit aa77a5, only the cpus in the software or
software&hardware coordination type dependency domain will copy to
policy->cpus and finally store into policy->related_cpus in the
cpufreq_add_dev() by cpumask_or. And then we miss the cpus in the
hardware coordination type domain. But these info is still stored in th=
e
policy->shared_cpu_map. Does this make sense?

>=20
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cp=
ufreq.c
> index 937bc28..57a8774 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -730,7 +730,6 @@ static int acpi_cpufreq_cpu_init(struct
> cpufreq_policy *policy)
>             policy->shared_type =3D=3D CPUFREQ_SHARED_TYPE_ANY) {
>                 cpumask_copy(policy->cpus, perf->shared_cpu_map);
>         }
> -       cpumask_copy(policy->related_cpus, perf->shared_cpu_map);
>=20
>  #ifdef CONFIG_SMP
>         dmi_check_system(sw_any_bug_dmi_table);
> @@ -742,7 +741,6 @@ static int acpi_cpufreq_cpu_init(struct
> cpufreq_policy *policy)
>         if (check_amd_hwpstate_cpu(cpu) && !acpi_pstate_strict) {
>                 cpumask_clear(policy->cpus);
>                 cpumask_set_cpu(cpu, policy->cpus);
> -               cpumask_copy(policy->related_cpus, cpu_sibling_mask(c=
pu));
>                 policy->shared_type =3D CPUFREQ_SHARED_TYPE_HW;
>                 pr_info_once(PFX "overriding BIOS provided _PSD data\=
n");
>=20


--=20
Best regards
Tianyu Lan
