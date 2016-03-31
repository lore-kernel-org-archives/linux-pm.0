From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Thu, 31 Mar 2016 10:55:05 -0700
Message-ID: <1459446905.4569.76.camel@linux.intel.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	 <8393335.Q1cjiaGecN@vostro.rjw.lan>
	 <CADDKRnBE==ea7YvXH+YL_m1v8E1zNHsZnXJgc58OQ=vrcs+cKQ@mail.gmail.com>
	 <2727017.UmaUvtBLeX@vostro.rjw.lan>
	 <CADDKRnAYPXip0EG0Y7ADuyt9L=FL-Nd1giHBVvPexs4kGkRj4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADDKRnAYPXip0EG0Y7ADuyt9L=FL-Nd1giHBVvPexs4kGkRj4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 2016-03-31 at 19:27 +0200, J=C3=B6rg Otte wrote:
> 2016-03-31 17:43 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> > On Thursday, March 31, 2016 05:25:18 PM J=C3=B6rg Otte wrote:
> > > 2016-03-31 13:42 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> > > > On Thursday, March 31, 2016 11:05:56 AM J=C3=B6rg Otte wrote:
> > > >=20
> > > > [cut]
> > > >=20
> > > > > >=20
> > > > >=20
> > > > > Yes, works for me.
> > > > >=20
> > > > > CPUID(7): No-SGX
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU Avg_MHz=C2=A0=C2=A0=C2=A0Bu=
sy% Bzy_MHz TSC_MHz
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A011=C2=A0=C2=A0=C2=A0=C2=A00.66 1682 2494
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A011=C2=A0=C2=A0=C2=A0=C2=A00.60 1856 2494
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A06=C2=A0=C2=A0=C2=A0=C2=A00.34=C2=A0=C2=A0=C2=A0=
=C2=A01898=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A013=C2=A0=C2=A0=C2=A0=C2=A00.82=C2=A0=C2=A0=C2=A0=C2=A0=
1628=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A013=C2=A0=C2=A0=C2=A0=C2=A00.87=C2=A0=C2=A0=C2=A0=C2=A0=
1528=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU Avg_MHz=C2=A0=C2=A0=C2=A0Bu=
sy% Bzy_MHz TSC_MHz
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A06=C2=A0=C2=A0=C2=A0=C2=A00.58=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0963=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A08=C2=A0=C2=A0=C2=A0=C2=A00.83=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0957=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A00.08=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0984=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A010=C2=A0=C2=A0=C2=A0=C2=A01.04=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0975=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A00.35=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0934=C2=A0=C2=A0=C2=A0=C2=A02494
> > > > >=20
> > > >=20
> >=20
> > [cut]
> >=20
> > > >=20
> > >=20
> > > No, this patch doesn't help.
> >=20
> > Well, more work to do then.
> >=20
> > I've just noticed a bug in this patch, which is not relevant for
> > the results,
> > but below is a new version.
> >=20
> > > CPUID(7): No-SGX
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU Avg_MHz=C2=A0=C2=A0=C2=A0=
Busy% Bzy_MHz TSC_MHz
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A08=C2=A0=C2=A0=C2=A0=C2=A00.32=C2=A0=C2=A0=C2=A0=C2=A0=
2507=C2=A0=C2=A0=C2=A0=C2=A02495
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A013=C2=A0=C2=A0=C2=A0=C2=A00.53=C2=A0=C2=A0=C2=A0=C2=A02505=C2=
=A0=C2=A0=C2=A0=C2=A02495
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A00.11=C2=A0=C2=A0=C2=A0=C2=A0=
2523=C2=A0=C2=A0=C2=A0=C2=A02495
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A00.06=C2=A0=C2=A0=C2=A0=C2=A0=
2555=C2=A0=C2=A0=C2=A0=C2=A02495
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A015=C2=A0=C2=A0=C2=A0=C2=A00.59=C2=A0=C2=A0=C2=A0=C2=A02500=C2=
=A0=C2=A0=C2=A0=C2=A02495
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU Avg_MHz=C2=A0=C2=A0=C2=A0Busy% =
Bzy_MHz TSC_MHz
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A08=C2=A0=C2=A0=C2=A0=C2=A00.33=C2=A0=C2=A0=C2=A0=C2=A0=
2486=C2=A0=C2=A0=C2=A0=C2=A02495
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A012=C2=A0=C2=A0=C2=A0=C2=A00.50=C2=A0=C2=A0=C2=A0=C2=A02482=C2=
=A0=C2=A0=C2=A0=C2=A02495
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A05=C2=A0=C2=A0=C2=A0=C2=A00.22=C2=A0=C2=A0=C2=A0=C2=A0=
2489=C2=A0=C2=A0=C2=A0=C2=A02495
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A00.04=C2=A0=C2=A0=C2=A0=C2=A0=
2492=C2=A0=C2=A0=C2=A0=C2=A02495
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A015=C2=A0=C2=A0=C2=A0=C2=A00.59=C2=A0=C2=A0=C2=A0=C2=A02487=C2=
=A0=C2=A0=C2=A0=C2=A02495
> >=20
> > Please apply the patch below and take a (1s or so) trace from the
> > pstate_sample
> > tracepoint (under /sys/kernel/debug/tracing/events/power/ on my
> > systems).
> >=20
> > Then please apply the revert instead of it and take a trace from
> > that tracepoint
> > again and send both of the traces to me.
> >=20
> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] intel_pstate: Do not set utilization update hook
> > too early
> >=20
> > The utilization update hook in the intel_pstate driver is set too
> > early, as it only should be set after the policy has been fully
> > initialized by the core.=C2=A0=C2=A0That may cause intel_pstate_upd=
ate_util()
> > to use incorrect data and put the CPUs into incorrect P-states as
> > a result.
> >=20
> > To prevent that from happening, make intel_pstate_set_policy() set
> > the utilization update hook instead of intel_pstate_init_cpu() so
> > intel_pstate_update_util() only runs when all things have been
> > initialized as appropriate.
> >=20
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A027 ++++++++=
+++++++++++--------
> > =C2=A01 file changed, 19 insertions(+), 8 deletions(-)
> >=20
> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
> > @@ -1103,7 +1103,6 @@ static int intel_pstate_init_cpu(unsigne
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_pstate_sample=
(cpu, 0);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpu->update_util.fu=
nc =3D intel_pstate_update_util;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpufreq_set_update_util_=
data(cpunum, &cpu->update_util);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_debug("intel_pst=
ate: controlling: cpu %d\n", cpunum);
> >=20
> > @@ -1122,18 +1121,29 @@ static unsigned int intel_pstate_get(uns
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return get_avg_freq=
uency(cpu);
> > =C2=A0}
> >=20
> > +static void intel_pstate_set_update_util_hook(unsigned int cpu)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpufreq_set_update_util_=
data(cpu, &all_cpu_data[cpu]-
> > >update_util);
> > +}
> > +
> > +static void intel_pstate_clear_update_util_hook(unsigned int cpu)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpufreq_set_update_util_=
data(cpu, NULL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0synchronize_sched();
> > +}
> > +
> > =C2=A0static int intel_pstate_set_policy(struct cpufreq_policy *pol=
icy)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!policy->cpuinf=
o.max_freq)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_pstate_clear_updat=
e_util_hook(policy->cpu);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (policy->policy =
=3D=3D CPUFREQ_POLICY_PERFORMANCE &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0policy->max >=3D policy->cpuinfo.max_freq) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_debug("intel_pstate: set performance\n");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0limits =3D &performance_limits;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (hwp_active)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
intel_pstate_hwp_set(policy->cpus);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto out;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_debug("intel_pst=
ate: set powersave\n");
> > @@ -1163,6 +1173,9 @@ static int intel_pstate_set_policy(struc
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0limits->max_perf =3D=
 div_fp(int_tofp(limits->max_perf_pct),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int_tofp=
(100));
> >=20
> > + out:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_pstate_set_update_=
util_hook(policy->cpu);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (hwp_active)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_pstate_hwp_set(policy->cpus);
> >=20
> > @@ -1187,8 +1200,7 @@ static void intel_pstate_stop_cpu(struct
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_debug("intel_pst=
ate: CPU %d exiting\n", cpu_num);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpufreq_set_update_util_=
data(cpu_num, NULL);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0synchronize_sched();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_pstate_clear_updat=
e_util_hook(cpu_num);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (hwp_active)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> > @@ -1455,8 +1467,7 @@ out:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0get_online_cpus();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for_each_online_cpu=
(cpu) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (all_cpu_data[cpu]) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
cpufreq_set_update_util_data(cpu, NULL);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
synchronize_sched();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
intel_pstate_clear_update_util_hook(cpu);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0kfree(all_cpu_data[cpu]);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> >=20
>=20
> OK, patch is applied.
> After some configurations and compilations I'm there.
> Under pstate_sample I see:
> enable=C2=A0=C2=A0filter=C2=A0=C2=A0format=C2=A0=C2=A0id=C2=A0=C2=A0t=
rigger
>=20
> what to do now ? (never did tracing before)'

# cd /sys/kernel/debug/tracing/
# echo 1 > events/power/pstate_sample/enable
# echo 1 > events/power/cpu_frequency/enable
# cat trace
Send us the trace file.

Also your kernel config doesn't have many modules, Is it a custom
configuration you do for your system?

Thanks,
Srinivas

=C2=A0
>=20
> Thanks, J=C3=B6rg
