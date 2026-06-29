Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BFD1862;
	Mon, 29 Jun 2026 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759977; cv=none; b=QzyLOiYHn5orKueGOJCiJDJuoUN0PQsVuAmzNm24C+As0UWhvmBWt1142EE4WWAhN8LZv2ABAZ4+GIyUtoFBhjA2VHuw0esFBJ1dn4rQLbYf3Tt/QRzJrZ9wvaAUWYYPG5237Q5VxdxANApWehzw+n4H1u7N3X9IANs4trD7WPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759977; c=relaxed/simple;
	bh=F+ByYIlzhDek98M/p8MCoXuERobJqN+LloLNnU+dMMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHKx2dBjGpHoXgWnnlpP1NHXL2HQVhvxRDOZHUUPdSAjB5fNLJJZTvY13+QoCJjnuf4FwR3X9dsGuYLeMvjGouLDRfMoo5v8vr+JrpmDsbLYoOWLmek5MW0cLu8Clw7aWrPyxbiTo+3H+cct4d5FBTsjfSBBm8xAlIDHkIRXfy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP1nTTDI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP1nTTDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB291F000E9;
	Mon, 29 Jun 2026 19:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782759975;
	bh=mXPR5CLlkP0uz8Me7uT6EcTwcacfqWNA2zDegCEppyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MP1nTTDIZd6up9Jrpkx5WWoyReXqb7W31uX+1v41iFHEFRbbupuO48AHHbFEmixxp
	 Mh+oEyUL4vNG0oCYNiRzWFn0A4ge7j4CTasyamjGNrsVmfkmwSQ01+HZIV2MJKCck2
	 biPoBHAgvJNwsVh4ekYjHHxoaN0lyLSenGR4sGrTDlVHyIcsi+X5ZgGTpB6565Tcmt
	 jDvHfoGN/sxLYeMZkJYQEScmnZEZsnDD0S+Z2BSv7BoJSeL7Vnf6y4Zd7Bbp7Jd5FH
	 MeE3+OthgEuEmkuH22xyhykxmw+iNzRoyjleFVhbIB2sp6B6drEyLIJY+1oZwY2crw
	 dqTdQ+Iw5BiFg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Lucas de Lima =?ISO-8859-1?Q?N=F3brega?= <lucaslnobrega38@gmail.com>
Cc: viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, kprateek.nayak@amd.com, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] sched/topology: Allow EAS without schedutil for artificial Energy
 Models
Date: Mon, 29 Jun 2026 21:06:10 +0200
Message-ID: <6021784.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0iVD90XPsWgT8B+fw9vmFRZTVL7MasPP-=Ci0OdUmNR=A@mail.gmail.com>
References:
 <20260629083542.10041-1-lucaslnobrega38@gmail.com>
 <CAJZ5v0iVD90XPsWgT8B+fw9vmFRZTVL7MasPP-=Ci0OdUmNR=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, June 29, 2026 5:16:17 PM CEST Rafael J. Wysocki (Intel) wrote:
> On Mon, Jun 29, 2026 at 10:36=E2=80=AFAM Lucas de Lima N=C3=B3brega
> <lucaslnobrega38@gmail.com> wrote:
> >
> > EAS currently refuses to enable energy-aware scheduling on a root
> > domain unless schedutil is the active CPUFreq governor for all of its
> > CPUs (cpufreq_ready_for_eas()). This requirement exists to protect the
> > accuracy of the energy estimate: EAS predicts the OPP a CPU will run
> > at from its utilization, which is only meaningful if the active
> > governor actually requests OPPs that way, and schedutil is the only
> > one that does.
> >
> > That requirement does not apply to artificial Energy Models
> > (EM_PERF_DOMAIN_ARTIFICIAL). An artificial EM is built from a
> > get_cost() callback instead of real power numbers, and only encodes a
> > cost ranking between CPUs (e.g. P-cores cost more than E-cores at a
> > given utilization). It never claims to predict real energy use at any
> > specific OPP, so there is no per-OPP accuracy for the governor
> > requirement to protect, regardless of which governor is in control or
> > whether it tracks utilization at all.
>=20
> But it is still about comparing the cost of running on different CPUs
> at different performance levels.
>=20
> For instance, say the scale-invariant utilization of a task is 256 and
> it can run either by itself on a P-core, or with another task whose
> utilization is 128 on an E-core, and say the P-core's and E-core's
> capacity is 1024 and 512, respectively.
>=20
> Say the cost function tells EAS that running a P-core at 1/4 of the
> capacity is cheaper than running an E-core at 3/4 capacity, so it will
> pick up the P-core to run that task, but if cpufreq ramps up the
> frequency of the P-core to the max when the task gets to it, it may
> actually turn out to be more expensive.
>=20
> This means that EAS still has an expectation regarding cpufreq which
> is that it will generally tend to run tasks at the performance level
> corresponding to the sum of their scale-invariant utilization at least
> roughly.
>=20
> IIUC this actually has nothing to do with whether or not the energy
> model used by EAS is artificial.  The schedutil requirement is about
> choosing a performance level proportional to the utilization (which
> schedutil generally tends to do by design).
>=20
> > intel_pstate registers exactly this kind of artificial EM for hybrid
> > (P/E-core) systems without SMT, regardless of whether it operates in
> > active or passive mode. In active mode it never uses schedutil, since
> > HWP picks frequency autonomously, so on these systems EAS never
> > engages even though SD_ASYM_CPUCAPACITY, frequency invariance and the
> > EM are all in place: find_energy_efficient_cpu() is never reached
> > because is_rd_overutilized() is hardcoded to true whenever
> > sched_energy_enabled() is false. cppc_cpufreq registers the same kind
> > of ranking-only artificial EM and is affected the same way with any
> > non-schedutil governor.
> >
> > Allow EAS to be enabled when every CPU's EM in the root domain is
> > artificial, even when schedutil is not the active governor.
> >
> > Tested on a Raptor Lake-P laptop with nosmt=3Dforce and intel_pstate in
> > active/HWP mode: find_energy_efficient_cpu() was never called before
> > this change (confirmed via the sched_overutilized_tp tracepoint and
> > ftrace) and is exercised as expected afterwards.
>=20
> If this is about allowing EAS to work with intel_pstate running in the
> active mode, you may argue that what the processor firmware is doing
> when intel_pstate runs in the active mode is not much different from
> what schedutil would do.  So a driver implementing an internal
> governor (that is, using the .set_policy() callback) would need to
> declare that its internal governor is as good as schedutil from EAS'
> perspective and so it will pass the "cpufreq readiness" check.

And I have a prototype patch (on top of 7.2-rc1) doing this which is
appended.

I wonder if it works for you (that is, if it allows intel_pstate and EAS to
work together both with schedutil and when intel_pstate operates in the
active mode with the "powersave" policy on your system).

Also I wonder why exactly you want intel_pstate in the active mode to
work with EAS.  Do you see any significant improvement in that case?

=2D--
 drivers/cpufreq/cpufreq.c        |    2 +-
 drivers/cpufreq/intel_pstate.c   |   11 +++++++++++
 include/linux/cpufreq.h          |   16 +++++++---------
 kernel/sched/cpufreq_schedutil.c |    7 ++-----
 4 files changed, 21 insertions(+), 15 deletions(-)

=2D-- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -3058,7 +3058,7 @@ static bool cpufreq_policy_is_good_for_e
 		return false;
 	}
=20
=2D	return sugov_is_governor(policy);
+	return policy->eas_compatible;
 }
=20
 bool cpufreq_ready_for_eas(const struct cpumask *cpu_mask)
=2D-- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2921,6 +2921,9 @@ static int intel_pstate_set_policy(struc
 		if (!hwp_boost)
 			intel_pstate_clear_update_util_hook(policy->cpu);
 		intel_pstate_hwp_set(policy->cpu);
+
+		policy->eas_compatible =3D hwp_is_hybrid &&
+				cpu->policy !=3D CPUFREQ_POLICY_PERFORMANCE;
 	}
 	/*
 	 * policy->cur is never updated with the intel_pstate driver, but it
@@ -2930,6 +2933,9 @@ static int intel_pstate_set_policy(struc
=20
 	mutex_unlock(&intel_pstate_limits_lock);
=20
+	if (policy->eas_compatible)
+		em_rebuild_sched_domains();
+
 	return 0;
 }
=20
@@ -3030,6 +3036,11 @@ static void intel_pstate_cpu_exit(struct
 	pr_debug("CPU %d exiting\n", policy->cpu);
=20
 	policy->fast_switch_possible =3D false;
+
+	if (policy->eas_compatible) {
+		policy->eas_compatible =3D false;
+		em_rebuild_sched_domains();
+	}
 }
=20
 static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
=2D-- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -118,6 +118,13 @@ struct cpufreq_policy {
 	bool			strict_target;
=20
 	/*
+	 * Set if the current governor meets EAS' expectations regarding
+	 * performance scaling (that is, it selects performance levels
+	 * proportional to CPU utilization at least roughly).
+	 */
+	bool			eas_compatible;
+
+	/*
 	 * Set if inefficient frequencies were found in the frequency table.
 	 * This indicates if the relation flag CPUFREQ_RELATION_E can be
 	 * honored.
@@ -657,15 +664,6 @@ module_exit(__governor##_exit)
 struct cpufreq_governor *cpufreq_default_governor(void);
 struct cpufreq_governor *cpufreq_fallback_governor(void);
=20
=2D#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
=2Dbool sugov_is_governor(struct cpufreq_policy *policy);
=2D#else
=2Dstatic inline bool sugov_is_governor(struct cpufreq_policy *policy)
=2D{
=2D	return false;
=2D}
=2D#endif
=2D
 static inline void cpufreq_policy_apply_limits(struct cpufreq_policy *poli=
cy)
 {
 	if (policy->max < policy->cur)
=2D-- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -797,6 +797,7 @@ out:
 	 * Schedutil is the preferred governor for EAS, so rebuild sched domains
 	 * on governor changes to make sure the scheduler knows about them.
 	 */
+	policy->eas_compatible =3D true;
 	em_rebuild_sched_domains();
 	mutex_unlock(&global_tunables_lock);
 	return 0;
@@ -839,6 +840,7 @@ static void sugov_exit(struct cpufreq_po
 	sugov_policy_free(sg_policy);
 	cpufreq_disable_fast_switch(policy);
=20
+	policy->eas_compatible =3D false;
 	em_rebuild_sched_domains();
 }
=20
@@ -931,9 +933,4 @@ struct cpufreq_governor *cpufreq_default
 }
 #endif
=20
=2Dbool sugov_is_governor(struct cpufreq_policy *policy)
=2D{
=2D	return policy->governor =3D=3D &schedutil_gov;
=2D}
=2D
 cpufreq_governor_init(schedutil_gov);



