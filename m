From: Konstantin Khlebnikov <koct9i@gmail.com>
Subject: Re: [PATCH RFC] intel_pstate: play well with frequency limits set by acpi
Date: Fri, 17 Jul 2015 10:10:54 +0300
Message-ID: <CALYGNiP1-=Rk85Ek1LXkiP8X5eC0kgbhNZYYFLimYx-k+Gcukg@mail.gmail.com>
References: <20150716181706.6500.64386.stgit@buzz>
	<55A899E4.4030708@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:36589 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbbGQHK5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2015 03:10:57 -0400
In-Reply-To: <55A899E4.4030708@oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ethan zhao <ethan.zhao@oracle.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, Len Brown <lenb@kernel.org>

On Fri, Jul 17, 2015 at 9:00 AM, ethan zhao <ethan.zhao@oracle.com> wro=
te:
>
> On 2015/7/17 2:17, Konstantin Khlebnikov wrote:
>>
>> IPMI can control CPU P-states remotely: configuration is reported vi=
a
>> common ACPI interface (_PPC/_PSS/etc). This patch adds required mini=
mal
>> support in intel_pstate to receive and use these P-state limits.
>>
>> * ignore limit of top state in _PPC: it lower than turbo boost frequ=
ency
>> * register intel_pstate in acpi-processor to get states from _PSS
>> * link acpi_processor_get_bios_limit: this adds attribute "bios_limi=
t"
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>>   drivers/acpi/processor_perflib.c |    3 +-
>>   drivers/cpufreq/intel_pstate.c   |   57
>> ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/processor_perflib.c
>> b/drivers/acpi/processor_perflib.c
>> index cfc8aba72f86..781e328c9d5f 100644
>> --- a/drivers/acpi/processor_perflib.c
>> +++ b/drivers/acpi/processor_perflib.c
>> @@ -98,7 +98,8 @@ static int acpi_processor_ppc_notifier(struct
>> notifier_block *nb,
>>         ppc =3D (unsigned int)pr->performance_platform_limit;
>>   -     if (ppc >=3D pr->performance->state_count)
>> +       /* Ignore limit of top state: it lower than turbo boost freq=
uency
>> */
>> +       if (!ppc || ppc >=3D pr->performance->state_count)
>
>  Perhaps the !ppc is wrong if we check it against ACPI spec.
>  Zero value of ppc means:
>
>  "0 =E2=80=93 States 0 through Nth state are available (all states av=
ailable)"

Yep, also states are ordered by power - state0 must must have highest
performance.
This code below clamps range of available frequences to 0.._PSS[_PPC].f=
requency.
So if _PPC =3D 0 then there should be no limit but then turbo is enable=
d frequency
of state0 is actually could be lower than effective turbo frequency:
for hardware I have it's _PSS[0] =3D 2601 Mhz, PSS[1] =3D 2600 Mhz whil=
e turbo
state is 3400 Mhz.

>
>
>>                 goto out;
>>         cpufreq_verify_within_limits(policy, 0,
>> diff --git a/drivers/cpufreq/intel_pstate.c
>> b/drivers/cpufreq/intel_pstate.c
>> index 15ada47bb720..4a34ddf4fa73 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -26,6 +26,7 @@
>>   #include <linux/fs.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/acpi.h>
>> +#include <acpi/processor.h>
>>   #include <linux/vmalloc.h>
>>   #include <trace/events/power.h>
>>   @@ -113,6 +114,9 @@ struct cpudata {
>>         u64     prev_mperf;
>>         u64     prev_tsc;
>>         struct sample sample;
>> +#ifdef CONFIG_ACPI_PROCESSOR
>> +       struct acpi_processor_performance acpi_data;
>> +#endif
>>   };
>>     static struct cpudata **all_cpu_data;
>> @@ -145,6 +149,7 @@ static int hwp_active;
>>     struct perf_limits {
>>         int no_turbo;
>> +       int no_acpi;
>>         int turbo_disabled;
>>         int max_perf_pct;
>>         int min_perf_pct;
>> @@ -158,6 +163,7 @@ struct perf_limits {
>>     static struct perf_limits limits =3D {
>>         .no_turbo =3D 0,
>> +       .no_acpi =3D !IS_ENABLED(CONFIG_ACPI_PROCESSOR),
>>         .turbo_disabled =3D 0,
>>         .max_perf_pct =3D 100,
>>         .max_perf =3D int_tofp(1),
>> @@ -449,6 +455,18 @@ static ssize_t store_min_perf_pct(struct kobjec=
t *a,
>> struct attribute *b,
>>         return count;
>>   }
>>   +static ssize_t store_no_acpi(struct kobject *a, struct attribute =
*b,
>> +                            const char *buf, size_t count)
>> +{
>> +#ifdef CONFIG_ACPI_PROCESSOR
>> +       return kstrtouint(buf, 0, &limits.no_acpi) ?: count;
>> +#else
>> +       return -ENODEV;
>> +#endif
>> +}
>> +show_one(no_acpi, no_acpi);
>> +define_one_global_rw(no_acpi);
>> +
>>   show_one(max_perf_pct, max_perf_pct);
>>   show_one(min_perf_pct, min_perf_pct);
>>   @@ -460,6 +478,7 @@ define_one_global_ro(num_pstates);
>>     static struct attribute *intel_pstate_attributes[] =3D {
>>         &no_turbo.attr,
>> +       &no_acpi.attr,
>>         &max_perf_pct.attr,
>>         &min_perf_pct.attr,
>>         &turbo_pct.attr,
>> @@ -1049,6 +1068,38 @@ static int intel_pstate_cpu_init(struct
>> cpufreq_policy *policy)
>>         policy->cpuinfo.transition_latency =3D CPUFREQ_ETERNAL;
>>         cpumask_set_cpu(policy->cpu, policy->cpus);
>>   +#ifdef CONFIG_ACPI_PROCESSOR
>> +       if (!limits.no_acpi) {
>> +               /*
>> +                * Minimum necessary to get acpi_processor_ppc_notif=
ier()
>> and
>> +                * acpi_processor_get_bios_limit() working.
>> +                */
>> +               if (!zalloc_cpumask_var(&cpu->acpi_data.shared_cpu_m=
ap,
>> +                                       GFP_KERNEL))
>> +                       rc =3D -ENOMEM;
>> +               else
>> +                       rc =3D acpi_processor_register_performance(
>> +                                       &cpu->acpi_data, policy->cpu=
);
>> +               if (rc) {
>> +                       pr_err("intel_pstate: acpi init failed: %d\n=
",
>> rc);
>> +                       free_cpumask_var(cpu->acpi_data.shared_cpu_m=
ap);
>> +                       limits.no_acpi =3D 1;
>> +               }
>> +       }
>> +#endif
>> +       return 0;
>> +}
>> +
>> +static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
>> +{
>> +#ifdef CONFIG_ACPI_PROCESSOR
>> +       struct cpudata *cpu =3D all_cpu_data[policy->cpu];
>> +
>> +       if (cpu->acpi_data.state_count)
>> +               acpi_processor_unregister_performance(&cpu->acpi_dat=
a,
>> +                                                     policy->cpu);
>> +       free_cpumask_var(cpu->acpi_data.shared_cpu_map);
>> +#endif
>>         return 0;
>>   }
>>   @@ -1057,7 +1108,11 @@ static struct cpufreq_driver intel_pstate_d=
river
>> =3D {
>>         .verify         =3D intel_pstate_verify_policy,
>>         .setpolicy      =3D intel_pstate_set_policy,
>>         .get            =3D intel_pstate_get,
>> +#ifdef CONFIG_ACPI_PROCESSOR
>> +       .bios_limit     =3D acpi_processor_get_bios_limit,
>> +#endif
>>         .init           =3D intel_pstate_cpu_init,
>> +       .exit           =3D intel_pstate_cpu_exit,
>>         .stop_cpu       =3D intel_pstate_stop_cpu,
>>         .name           =3D "intel_pstate",
>>   };
>> @@ -1286,6 +1341,8 @@ static int __init intel_pstate_setup(char *str=
)
>>                 force_load =3D 1;
>>         if (!strcmp(str, "hwp_only"))
>>                 hwp_only =3D 1;
>> +       if (!strcmp(str, "no_acpi"))
>> +               limits.no_acpi =3D 1;
>>         return 0;
>>   }
>>   early_param("intel_pstate", intel_pstate_setup);
>>
>
>
>  Thanks,
>  Ethan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
