From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Thu, 31 Mar 2016 09:10:00 -0700
Message-ID: <1459440600.4569.70.camel@linux.intel.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	 <8393335.Q1cjiaGecN@vostro.rjw.lan>
	 <CADDKRnBE==ea7YvXH+YL_m1v8E1zNHsZnXJgc58OQ=vrcs+cKQ@mail.gmail.com>
	 <2727017.UmaUvtBLeX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54823 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbcCaQQ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 31 Mar 2016 12:16:29 -0400
In-Reply-To: <2727017.UmaUvtBLeX@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

On Thu, 2016-03-31 at 17:43 +0200, Rafael J. Wysocki wrote:
> On Thursday, March 31, 2016 05:25:18 PM J=C3=B6rg Otte wrote:
> > 2016-03-31 13:42 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> > > On Thursday, March 31, 2016 11:05:56 AM J=C3=B6rg Otte wrote:
> > >=20
> > > [cut]
> > >=20
> > > > >=20
> > > >=20
> > > > Yes, works for me.
> > > >=20
> > > > CPUID(7): No-SGX
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU Avg_MHz=C2=A0=C2=A0=C2=A0Busy=
% Bzy_MHz TSC_MHz
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A011=C2=A0=C2=A0=C2=A0=C2=A00.66 1682 2494
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A011=C2=A0=C2=A0=C2=A0=C2=A00.60 1856 2494
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A06=C2=A0=C2=A0=C2=A0=C2=A00.34=C2=A0=C2=A0=C2=A0=C2=
=A01898=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A013=C2=A0=C2=A0=C2=A0=C2=A00.82=C2=A0=C2=A0=C2=A0=C2=A016=
28=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A013=C2=A0=C2=A0=C2=A0=C2=A00.87=C2=A0=C2=A0=C2=A0=C2=A015=
28=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU Avg_MHz=C2=A0=C2=A0=C2=A0Busy=
% Bzy_MHz TSC_MHz
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A06=C2=A0=C2=A0=C2=A0=C2=A00.58=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0963=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A08=C2=A0=C2=A0=C2=A0=C2=A00.83=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0957=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A00.08=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0984=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A010=C2=A0=C2=A0=C2=A0=C2=A01.04=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0975=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A00.35=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0934=C2=A0=C2=A0=C2=A0=C2=A02494
> > > >=20
> > >=20
>=20
> [cut]
>=20
> > >=20
> >=20
> > No, this patch doesn't help.
>=20
> Well, more work to do then.
>=20
> I've just noticed a bug in this patch, which is not relevant for the
> results,
> but below is a new version.
>=20
> > CPUID(7): No-SGX
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU Avg_MHz=C2=A0=C2=A0=C2=A0Bu=
sy% Bzy_MHz TSC_MHz
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A08=C2=A0=C2=A0=C2=A0=C2=A00.32=C2=A0=C2=A0=C2=A0=C2=A0=
2507=C2=A0=C2=A0=C2=A0=C2=A02495
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A013=C2=A0=C2=A0=C2=A0=C2=A00.53=C2=A0=C2=A0=C2=A0=C2=A02505=C2=
=A0=C2=A0=C2=A0=C2=A02495
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A00.11=C2=A0=C2=A0=C2=A0=C2=A0=
2523=C2=A0=C2=A0=C2=A0=C2=A02495
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A00.06=C2=A0=C2=A0=C2=A0=C2=A0=
2555=C2=A0=C2=A0=C2=A0=C2=A02495
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A015=C2=A0=C2=A0=C2=A0=C2=A00.59=C2=A0=C2=A0=C2=A0=C2=A02500=C2=
=A0=C2=A0=C2=A0=C2=A02495
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU Avg_MHz=C2=A0=C2=A0=C2=A0Busy% Bz=
y_MHz TSC_MHz
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A08=C2=A0=C2=A0=C2=A0=C2=A00.33=C2=A0=C2=A0=C2=A0=C2=A0=
2486=C2=A0=C2=A0=C2=A0=C2=A02495
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A012=C2=A0=C2=A0=C2=A0=C2=A00.50=C2=A0=C2=A0=C2=A0=C2=A02482=C2=
=A0=C2=A0=C2=A0=C2=A02495
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A05=C2=A0=C2=A0=C2=A0=C2=A00.22=C2=A0=C2=A0=C2=A0=C2=A0=
2489=C2=A0=C2=A0=C2=A0=C2=A02495
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A00.04=C2=A0=C2=A0=C2=A0=C2=A0=
2492=C2=A0=C2=A0=C2=A0=C2=A02495
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A015=C2=A0=C2=A0=C2=A0=C2=A00.59=C2=A0=C2=A0=C2=A0=C2=A02487=C2=
=A0=C2=A0=C2=A0=C2=A02495
>=20
> Please apply the patch below and take a (1s or so) trace from the
> pstate_sample
> tracepoint (under /sys/kernel/debug/tracing/events/power/ on my
> systems).
>=20

Jorg,

If you want to know how to trace
# cd /sys/kernel/debug/tracing/
# echo 1 > events/power/pstate_sample/enable
# echo 1 > events/power/cpu_frequency/enable
# cat trace


> Then please apply the revert instead of it and take a trace from that
> tracepoint
> again and send both of the traces to me.
>=20
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] intel_pstate: Do not set utilization update hook too
> early
>=20
> The utilization update hook in the intel_pstate driver is set too
> early, as it only should be set after the policy has been fully
> initialized by the core.=C2=A0=C2=A0That may cause intel_pstate_updat=
e_util()
> to use incorrect data and put the CPUs into incorrect P-states as
> a result.
>=20
> To prevent that from happening, make intel_pstate_set_policy() set
> the utilization update hook instead of intel_pstate_init_cpu() so
> intel_pstate_update_util() only runs when all things have been
> initialized as appropriate.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A027 ++++++++++=
+++++++++--------
> =C2=A01 file changed, 19 insertions(+), 8 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -1103,7 +1103,6 @@ static int intel_pstate_init_cpu(unsigne
> =C2=A0	intel_pstate_sample(cpu, 0);
> =C2=A0
> =C2=A0	cpu->update_util.func =3D intel_pstate_update_util;
> -	cpufreq_set_update_util_data(cpunum, &cpu->update_util);
> =C2=A0
> =C2=A0	pr_debug("intel_pstate: controlling: cpu %d\n", cpunum);
> =C2=A0
> @@ -1122,18 +1121,29 @@ static unsigned int intel_pstate_get(uns
> =C2=A0	return get_avg_frequency(cpu);
> =C2=A0}
> =C2=A0
> +static void intel_pstate_set_update_util_hook(unsigned int cpu)
> +{
> +	cpufreq_set_update_util_data(cpu, &all_cpu_data[cpu]-
> >update_util);
> +}
> +
> +static void intel_pstate_clear_update_util_hook(unsigned int cpu)
> +{
> +	cpufreq_set_update_util_data(cpu, NULL);
> +	synchronize_sched();
> +}
> +
> =C2=A0static int intel_pstate_set_policy(struct cpufreq_policy *polic=
y)
> =C2=A0{
> =C2=A0	if (!policy->cpuinfo.max_freq)
> =C2=A0		return -ENODEV;
> =C2=A0
> +	intel_pstate_clear_update_util_hook(policy->cpu);
> +
> =C2=A0	if (policy->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE &&
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0policy->max >=3D policy->cpuinfo.max_f=
req) {
> =C2=A0		pr_debug("intel_pstate: set performance\n");
> =C2=A0		limits =3D &performance_limits;
> -		if (hwp_active)
> -			intel_pstate_hwp_set(policy->cpus);
> -		return 0;
> +		goto out;
> =C2=A0	}
> =C2=A0
> =C2=A0	pr_debug("intel_pstate: set powersave\n");
> @@ -1163,6 +1173,9 @@ static int intel_pstate_set_policy(struc
> =C2=A0	limits->max_perf =3D div_fp(int_tofp(limits->max_perf_pct),
> =C2=A0				=C2=A0=C2=A0int_tofp(100));
> =C2=A0
> + out:
> +	intel_pstate_set_update_util_hook(policy->cpu);
> +
> =C2=A0	if (hwp_active)
> =C2=A0		intel_pstate_hwp_set(policy->cpus);
> =C2=A0
> @@ -1187,8 +1200,7 @@ static void intel_pstate_stop_cpu(struct
> =C2=A0
> =C2=A0	pr_debug("intel_pstate: CPU %d exiting\n", cpu_num);
> =C2=A0
> -	cpufreq_set_update_util_data(cpu_num, NULL);
> -	synchronize_sched();
> +	intel_pstate_clear_update_util_hook(cpu_num);
> =C2=A0
> =C2=A0	if (hwp_active)
> =C2=A0		return;
> @@ -1455,8 +1467,7 @@ out:
> =C2=A0	get_online_cpus();
> =C2=A0	for_each_online_cpu(cpu) {
> =C2=A0		if (all_cpu_data[cpu]) {
> -			cpufreq_set_update_util_data(cpu, NULL);
> -			synchronize_sched();
> +			intel_pstate_clear_update_util_hook(cpu);
> =C2=A0			kfree(all_cpu_data[cpu]);
> =C2=A0		}
> =C2=A0	}
>=20
