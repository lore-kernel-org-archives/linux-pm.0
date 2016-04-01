From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Fri, 1 Apr 2016 11:20:42 +0200
Message-ID: <CADDKRnCs8vWbqOBbk0T+A5_VSzC5ENfND=NLwb3G0XjTvF9DQA@mail.gmail.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	<8393335.Q1cjiaGecN@vostro.rjw.lan>
	<CADDKRnBE==ea7YvXH+YL_m1v8E1zNHsZnXJgc58OQ=vrcs+cKQ@mail.gmail.com>
	<2727017.UmaUvtBLeX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a114362c8ac87f8052f68e49f
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35631 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618AbcDAJUo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 05:20:44 -0400
In-Reply-To: <2727017.UmaUvtBLeX@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>

--001a114362c8ac87f8052f68e49f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

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
> I've just noticed a bug in this patch, which is not relevant for the resu=
lts,
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
> Please apply the patch below and take a (1s or so) trace from the pstate_=
sample
> tracepoint (under /sys/kernel/debug/tracing/events/power/ on my systems).
>
> Then please apply the revert instead of it and take a trace from that tra=
cepoint
> again and send both of the traces to me.
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] intel_pstate: Do not set utilization update hook too ear=
ly
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
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> +       cpufreq_set_update_util_data(cpu, &all_cpu_data[cpu]->update_util=
);
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

here they are.

Thanks,J=C3=B6rg

--001a114362c8ac87f8052f68e49f
Content-Type: application/x-xz; name="intel_pstate_tracer_without_revert.xz"
Content-Disposition: attachment;
	filename="intel_pstate_tracer_without_revert.xz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_imhi20ld0

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
vmvT8T0AAYmFAaWqCQa618mxxGf7AgAAAAAEWVo=
--001a114362c8ac87f8052f68e49f
Content-Type: application/x-xz; name="intel_pstate_tracer_with_revert.xz"
Content-Disposition: attachment;
	filename="intel_pstate_tracer_with_revert.xz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_imhi2b251

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
--001a114362c8ac87f8052f68e49f--
