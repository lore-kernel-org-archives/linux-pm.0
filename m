From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [intel-pstate driver regression] processor frequency very high even if in idle
Date: Thu, 31 Mar 2016 13:42:14 +0200
Message-ID: <8393335.Q1cjiaGecN@vostro.rjw.lan>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com> <4695038.Xoqbuvkrbb@vostro.rjw.lan> <CADDKRnCQAcuA=fv+4g-3aVU3U_zwssMAcoek0mu_ip24mO-pDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44215 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751771AbcCaLjw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 31 Mar 2016 07:39:52 -0400
In-Reply-To: <CADDKRnCQAcuA=fv+4g-3aVU3U_zwssMAcoek0mu_ip24mO-pDg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Thursday, March 31, 2016 11:05:56 AM J=C3=B6rg Otte wrote:

[cut]

> >
>=20
> Yes, works for me.
>=20
> CPUID(7): No-SGX
>      CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
>        -      11    0.66    1682    2494
>        0      11    0.60    1856    2494
>        1       6    0.34    1898    2494
>        2      13    0.82    1628    2494
>        3      13    0.87    1528    2494
>      CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
>        -       6    0.58     963    2494
>        0       8    0.83     957    2494
>        1       1    0.08     984    2494
>        2      10    1.04     975    2494
>        3       3    0.35     934    2494
>=20

Great, thanks!

To me, the only area where things are really different before and after=
 the
revert is the initialization, so that likely is when the problem trigge=
rs.

And sure enough, there is an initialization problem in intel_pstate.

Please test the patch below instead of the revert and let me know if it
makes any difference.

It (or equivalent) will need to be applied anyway, so we'll work on top=
 of it
going forward, but also it may just be sufficient to address the proble=
m you're
seeing.

---
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] intel_pstate: Do not set utilization update hook too e=
arly

The utilization update hook in the intel_pstate driver is set too
early, as it only should be set after the policy has been fully
initialized by the core.  That may cause intel_pstate_update_util()
to use incorrect data and put the CPUs into incorrect P-states as
a result.

To prevent that from happening, make intel_pstate_set_policy() set
the utilization update hook instead of intel_pstate_init_cpu() so
intel_pstate_update_util() only runs when all things have been
initialized as appropriate.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1103,7 +1103,6 @@ static int intel_pstate_init_cpu(unsigne
 	intel_pstate_sample(cpu, 0);
=20
 	cpu->update_util.func =3D intel_pstate_update_util;
-	cpufreq_set_update_util_data(cpunum, &cpu->update_util);
=20
 	pr_debug("intel_pstate: controlling: cpu %d\n", cpunum);
=20
@@ -1122,18 +1121,29 @@ static unsigned int intel_pstate_get(uns
 	return get_avg_frequency(cpu);
 }
=20
+static void intel_pstate_set_update_util_hook(unsigned int cpu)
+{
+	cpufreq_set_update_util_data(cpu, &all_cpu_data[cpu]->update_util);
+}
+
+static void intel_pstate_clear_update_util_hook(unsigned int cpu)
+{
+	cpufreq_set_update_util_data(cpu, NULL);
+	synchronize_sched();
+}
+
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
=20
+	intel_pstate_clear_update_util_hook(policy->cpu);
+
 	if (policy->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE &&
 	    policy->max >=3D policy->cpuinfo.max_freq) {
 		pr_debug("intel_pstate: set performance\n");
 		limits =3D &performance_limits;
-		if (hwp_active)
-			intel_pstate_hwp_set(policy->cpus);
-		return 0;
+		goto out;
 	}
=20
 	pr_debug("intel_pstate: set powersave\n");
@@ -1163,6 +1173,9 @@ static int intel_pstate_set_policy(struc
 	limits->max_perf =3D div_fp(int_tofp(limits->max_perf_pct),
 				  int_tofp(100));
=20
+ out:
+	intel_pstate_set_update_util_hook(policy->cpu);
+
 	if (hwp_active)
 		intel_pstate_hwp_set(policy->cpus);
=20
@@ -1187,8 +1200,7 @@ static void intel_pstate_stop_cpu(struct
=20
 	pr_debug("intel_pstate: CPU %d exiting\n", cpu_num);
=20
-	cpufreq_set_update_util_data(cpu_num, NULL);
-	synchronize_sched();
+	intel_pstate_set_update_util_hook(cpu_num);
=20
 	if (hwp_active)
 		return;
@@ -1455,8 +1467,7 @@ out:
 	get_online_cpus();
 	for_each_online_cpu(cpu) {
 		if (all_cpu_data[cpu]) {
-			cpufreq_set_update_util_data(cpu, NULL);
-			synchronize_sched();
+			intel_pstate_clear_update_util_hook(cpu);
 			kfree(all_cpu_data[cpu]);
 		}
 	}

