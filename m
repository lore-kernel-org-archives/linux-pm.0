From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: CPUfreq lockdep issue
Date: Fri, 19 Feb 2016 14:47:23 +0530
Message-ID: <20160219091723.GB22812@vireshk-i7>
References: <1455793609.9851.45.camel@linux.intel.com>
 <20160218113437.GX2610@vireshk-i7>
 <1455871852.7321.4.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34624 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948541AbcBSJRi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2016 04:17:38 -0500
Received: by mail-pf0-f178.google.com with SMTP id x65so48143016pfb.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2016 01:17:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455871852.7321.4.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, dirk.j.brandewie@intel.com, srinivas.pandruvada@linux.intel.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, lenb@kernel.org

Adding the maintainers of the driver in cc now.

On 19-02-16, 10:50, Joonas Lahtinen wrote:
> On to, 2016-02-18 at 17:04 +0530, Viresh Kumar wrote:
> > On 18-02-16, 13:06, Joonas Lahtinen wrote:
> > > Hi,
> > >=20
> > > The Intel P-state driver has a lockdep issue as described below. =
It
> > > could in theory cause a deadlock if initialization and suspend we=
re to
> > > be performed simultaneously. Conflicting calling paths are as fol=
lows:
> > >=20
> > > intel_pstate_init(...)
> > > 	...cpufreq_online(...)
> > > 		down_write(&policy->rwsem); // Locks policy->rwsem
> > > 		...
> > > 		cpufreq_init_policy(policy);
> > > 			...intel_pstate_hwp_set();
> > > 				get_online_cpus(); // Temporarily locks cpu_hotplug.lock
> >=20
> > Why is this one required?
>=20
> Otherwise CPUs could be added or removed during the execution of
> intel_pstate_hwp_set(), which has the following code:
>=20
> =A0 =A0 =A0 =A0	get_online_cpus();
> =A0 =A0 =A0 =A0 for_each_online_cpu(cpu) {
> 		...
> 		wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
> 	}
> >=20
> > > 		...
> > > 		up_write(&policy->rwsem);
> > >=20
> > > pm_suspend(...)
> > > 	...disable_nonboot_cpus()
> > > 		_cpu_down()
> > > 			cpu_hotplug_begin(); // Locks cpu_hotplug.lock
> > > 			__cpu_notify(CPU_DOWN_PREPARE, ...);
> > > 				...cpufreq_offline_prepare();
> > > 					down_write(&policy->rwsem); // Locks policy->rwsem
> > >=20
> > > Quickly looking at the code, some refactoring has to be done to f=
ix the
> > > issue. I think it would a good idea to document some of the drive=
r
> > > callbacks related to what locks are held etc. in order to avoid f=
uture
> > > situations like this.
> > >=20
> > > Because get_online_cpus() is of recursive nature and the way it
> > > currently works, adding wider get_online_cpus() scope up around
> > > cpufreq_online() does not fix the issue because it only momentari=
ly
> > > locks cpu_hotplug.lock and proceeds to do so again at next call.
> > >=20
> > > Moving get_online_cpus() completely away from pstate_hwp_set() an=
d
> > > assuring it is called higher in the call chain might be a viable
> > > solution. Then it could be made sure get_online_cpus() is not cal=
led
> > > while policy->rwsem is being held already.

Hi Guys,

Joonas reported a lockdep between cpufreq and intel-pstate driver and
we are looking for probable solutions.

I failed to understand why should we run intel_pstate_hwp_set() for
each online CPU, while the frequency is changed only for a group of
CPUs that belong to a policy. Ofcourse intel_pstate_hwp_set() is
required to be run for all CPUs, while the sysfs files are touched.
And so, do we have a problem with below diff?

--=20
viresh

-------------------------8<-------------------------
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pst=
ate.c
index d6061be2c542..a3c1788daab2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -287,7 +287,7 @@ static inline void update_turbo_state(void)
 		 cpu->pstate.max_pstate =3D=3D cpu->pstate.turbo_pstate);
 }
=20
-static void intel_pstate_hwp_set(void)
+static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 {
 	int min, hw_min, max, hw_max, cpu, range, adj_range;
 	u64 value, cap;
@@ -297,9 +297,7 @@ static void intel_pstate_hwp_set(void)
 	hw_max =3D HWP_HIGHEST_PERF(cap);
 	range =3D hw_max - hw_min;
=20
-	get_online_cpus();
-
-	for_each_online_cpu(cpu) {
+	for_each_cpu(cpu, cpumask) {
 		rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
 		adj_range =3D limits->min_perf_pct * range / 100;
 		min =3D hw_min + adj_range;
@@ -318,7 +316,12 @@ static void intel_pstate_hwp_set(void)
 		value |=3D HWP_MAX_PERF(max);
 		wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 	}
+}
=20
+static void intel_pstate_hwp_set_online_cpus(void)
+{
+	get_online_cpus();
+	intel_pstate_hwp_set(cpu_online_mask);
 	put_online_cpus();
 }
=20
@@ -440,7 +443,7 @@ static ssize_t store_no_turbo(struct kobject *a, st=
ruct attribute *b,
 	limits->no_turbo =3D clamp_t(int, input, 0, 1);
=20
 	if (hwp_active)
-		intel_pstate_hwp_set();
+		intel_pstate_hwp_set_online_cpus();
=20
 	return count;
 }
@@ -466,7 +469,7 @@ static ssize_t store_max_perf_pct(struct kobject *a=
, struct attribute *b,
 				  int_tofp(100));
=20
 	if (hwp_active)
-		intel_pstate_hwp_set();
+		intel_pstate_hwp_set_online_cpus();
 	return count;
 }
=20
@@ -491,7 +494,7 @@ static ssize_t store_min_perf_pct(struct kobject *a=
, struct attribute *b,
 				  int_tofp(100));
=20
 	if (hwp_active)
-		intel_pstate_hwp_set();
+		intel_pstate_hwp_set_online_cpus();
 	return count;
 }
=20
@@ -1112,7 +1115,7 @@ static int intel_pstate_set_policy(struct cpufreq=
_policy *policy)
 		pr_debug("intel_pstate: set performance\n");
 		limits =3D &performance_limits;
 		if (hwp_active)
-			intel_pstate_hwp_set();
+			intel_pstate_hwp_set(policy->cpus);
 		return 0;
 	}
=20
@@ -1144,7 +1147,7 @@ static int intel_pstate_set_policy(struct cpufreq=
_policy *policy)
 				  int_tofp(100));
=20
 	if (hwp_active)
-		intel_pstate_hwp_set();
+		intel_pstate_hwp_set(policy->cpus);
=20
 	return 0;
 }
