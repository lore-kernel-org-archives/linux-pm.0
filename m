From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Thu, 31 Mar 2016 19:27:35 +0200
Message-ID: <CADDKRnAYPXip0EG0Y7ADuyt9L=FL-Nd1giHBVvPexs4kGkRj4g@mail.gmail.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	<8393335.Q1cjiaGecN@vostro.rjw.lan>
	<CADDKRnBE==ea7YvXH+YL_m1v8E1zNHsZnXJgc58OQ=vrcs+cKQ@mail.gmail.com>
	<2727017.UmaUvtBLeX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33372 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbcCaR1h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 13:27:37 -0400
In-Reply-To: <2727017.UmaUvtBLeX@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>

2016-03-31 17:43 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> On Thursday, March 31, 2016 05:25:18 PM J=C3=B6rg Otte wrote:
>> 2016-03-31 13:42 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> > On Thursday, March 31, 2016 11:05:56 AM J=C3=B6rg Otte wrote:
>> >
>> > [cut]
>> >
>> >> >
>> >>
>> >> Yes, works for me.
>> >>
>> >> CPUID(7): No-SGX
>> >>      CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
>> >>        -      11    0.66 1682 2494
>> >>        0      11    0.60 1856 2494
>> >>        1       6    0.34    1898    2494
>> >>        2      13    0.82    1628    2494
>> >>        3      13    0.87    1528    2494
>> >>      CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
>> >>        -       6    0.58     963    2494
>> >>        0       8    0.83     957    2494
>> >>        1       1    0.08     984    2494
>> >>        2      10    1.04     975    2494
>> >>        3       3    0.35     934    2494
>> >>
>> >
>
> [cut]
>
>> >
>>
>> No, this patch doesn't help.
>
> Well, more work to do then.
>
> I've just noticed a bug in this patch, which is not relevant for the =
results,
> but below is a new version.
>
>> CPUID(7): No-SGX
>>       CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
>>        -       8    0.32    2507    2495
>>        0      13    0.53    2505    2495
>>        1       3    0.11    2523    2495
>>        2       1    0.06    2555    2495
>>        3      15    0.59    2500    2495
>>      CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
>>        -       8    0.33    2486    2495
>>        0      12    0.50    2482    2495
>>        1       5    0.22    2489    2495
>>        2       1    0.04    2492    2495
>>        3      15    0.59    2487    2495
>
> Please apply the patch below and take a (1s or so) trace from the pst=
ate_sample
> tracepoint (under /sys/kernel/debug/tracing/events/power/ on my syste=
ms).
>
> Then please apply the revert instead of it and take a trace from that=
 tracepoint
> again and send both of the traces to me.
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] intel_pstate: Do not set utilization update hook too=
 early
>
> The utilization update hook in the intel_pstate driver is set too
> early, as it only should be set after the policy has been fully
> initialized by the core.  That may cause intel_pstate_update_util()
> to use incorrect data and put the CPUs into incorrect P-states as
> a result.
>
> To prevent that from happening, make intel_pstate_set_policy() set
> the utilization update hook instead of intel_pstate_init_cpu() so
> intel_pstate_update_util() only runs when all things have been
> initialized as appropriate.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |   27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -1103,7 +1103,6 @@ static int intel_pstate_init_cpu(unsigne
>         intel_pstate_sample(cpu, 0);
>
>         cpu->update_util.func =3D intel_pstate_update_util;
> -       cpufreq_set_update_util_data(cpunum, &cpu->update_util);
>
>         pr_debug("intel_pstate: controlling: cpu %d\n", cpunum);
>
> @@ -1122,18 +1121,29 @@ static unsigned int intel_pstate_get(uns
>         return get_avg_frequency(cpu);
>  }
>
> +static void intel_pstate_set_update_util_hook(unsigned int cpu)
> +{
> +       cpufreq_set_update_util_data(cpu, &all_cpu_data[cpu]->update_=
util);
> +}
> +
> +static void intel_pstate_clear_update_util_hook(unsigned int cpu)
> +{
> +       cpufreq_set_update_util_data(cpu, NULL);
> +       synchronize_sched();
> +}
> +
>  static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  {
>         if (!policy->cpuinfo.max_freq)
>                 return -ENODEV;
>
> +       intel_pstate_clear_update_util_hook(policy->cpu);
> +
>         if (policy->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE &&
>             policy->max >=3D policy->cpuinfo.max_freq) {
>                 pr_debug("intel_pstate: set performance\n");
>                 limits =3D &performance_limits;
> -               if (hwp_active)
> -                       intel_pstate_hwp_set(policy->cpus);
> -               return 0;
> +               goto out;
>         }
>
>         pr_debug("intel_pstate: set powersave\n");
> @@ -1163,6 +1173,9 @@ static int intel_pstate_set_policy(struc
>         limits->max_perf =3D div_fp(int_tofp(limits->max_perf_pct),
>                                   int_tofp(100));
>
> + out:
> +       intel_pstate_set_update_util_hook(policy->cpu);
> +
>         if (hwp_active)
>                 intel_pstate_hwp_set(policy->cpus);
>
> @@ -1187,8 +1200,7 @@ static void intel_pstate_stop_cpu(struct
>
>         pr_debug("intel_pstate: CPU %d exiting\n", cpu_num);
>
> -       cpufreq_set_update_util_data(cpu_num, NULL);
> -       synchronize_sched();
> +       intel_pstate_clear_update_util_hook(cpu_num);
>
>         if (hwp_active)
>                 return;
> @@ -1455,8 +1467,7 @@ out:
>         get_online_cpus();
>         for_each_online_cpu(cpu) {
>                 if (all_cpu_data[cpu]) {
> -                       cpufreq_set_update_util_data(cpu, NULL);
> -                       synchronize_sched();
> +                       intel_pstate_clear_update_util_hook(cpu);
>                         kfree(all_cpu_data[cpu]);
>                 }
>         }
>

OK, patch is applied.
After some configurations and compilations I'm there.
Under pstate_sample I see:
enable  filter  format  id  trigger

what to do now ? (never did tracing before)

Thanks, J=C3=B6rg
