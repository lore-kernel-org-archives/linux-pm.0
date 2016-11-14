From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Synchronize sysfs limits
Date: Mon, 14 Nov 2016 23:46:52 +0100
Message-ID: <5404733.dplQ1iSI2R@vostro.rjw.lan>
References: <1478909495-57026-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1479161257.6544.33.camel@linux.intel.com> <CAJZ5v0jUD7iDC6zY8USgDw=Z_0+nDnS-7DMCXLKxGSsG+Wz-BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47448 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933841AbcKNWjW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2016 17:39:22 -0500
In-Reply-To: <CAJZ5v0jUD7iDC6zY8USgDw=Z_0+nDnS-7DMCXLKxGSsG+Wz-BA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Monday, November 14, 2016 11:11:39 PM Rafael J. Wysocki wrote:
> On Mon, Nov 14, 2016 at 11:07 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On Mon, 2016-11-14 at 02:04 +0100, Rafael J. Wysocki wrote:
> >> On Sat, Nov 12, 2016 at 1:11 AM, Srinivas Pandruvada
> >>
> > [...]
> >> +       get_online_cpus();
> >> > +       for_each_online_cpu(cpu) {
> >> > +               if (all_cpu_data[cpu])
> >> > +                       cpufreq_update_policy(cpu);
> >>
> >> cpufreq_update_policy() calls cpufreq_cpu_get() to get the policy
> >> anyway which does the requisite policy existence check (although it
> >> is
> >> a bit racy now, but that's a bug in there that we should not have to
> >> work around here), so it should be sufficient to do this
> >> for_each_possible_cpu() without additional locking.
> >>
> > I will change in the next patch set.
> 
> Wait, wait, there's a better way I think, but I'll need to send a
> patch to explain what I mean. :-)  Will do that shortly.

Something like the below, modulo changes in ->verify() or in ->set_policy() to
update min/max (untested, but I don't see why it wouldn't work).

If we are going to call cpufreq_update_policy() anyway, we don't need to do
anything special for HWP then, because that will trigger ->set_policy()
eventually and we'll update HWP at the end of it.

---
 drivers/cpufreq/intel_pstate.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -572,13 +572,13 @@ static inline void update_turbo_state(vo
 		 cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
 }
 
-static void intel_pstate_hwp_set(const struct cpumask *cpumask)
+static void intel_pstate_hwp_set(struct cpufreq_policy *policy)
 {
 	int min, hw_min, max, hw_max, cpu, range, adj_range;
 	struct perf_limits *perf_limits = limits;
 	u64 value, cap;
 
-	for_each_cpu(cpu, cpumask) {
+	for_each_cpu(cpu, policy->cpus) {
 		int max_perf_pct, min_perf_pct;
 
 		if (per_cpu_limits)
@@ -615,16 +615,17 @@ static void intel_pstate_hwp_set(const s
 static int intel_pstate_hwp_set_policy(struct cpufreq_policy *policy)
 {
 	if (hwp_active)
-		intel_pstate_hwp_set(policy->cpus);
+		intel_pstate_hwp_set(policy);
 
 	return 0;
 }
 
-static void intel_pstate_hwp_set_online_cpus(void)
+static void intel_pstate_update_policies(void)
 {
-	get_online_cpus();
-	intel_pstate_hwp_set(cpu_online_mask);
-	put_online_cpus();
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		cpufreq_update_policy(cpu);
 }
 
 /************************** debugfs begin ************************/
@@ -751,9 +752,7 @@ static ssize_t store_no_turbo(struct kob
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
-	if (hwp_active)
-		intel_pstate_hwp_set_online_cpus();
-
+	intel_pstate_update_policies();
 	return count;
 }
 
@@ -780,8 +779,7 @@ static ssize_t store_max_perf_pct(struct
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
-	if (hwp_active)
-		intel_pstate_hwp_set_online_cpus();
+	intel_pstate_update_policies();
 	return count;
 }
 
@@ -808,8 +806,7 @@ static ssize_t store_min_perf_pct(struct
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
-	if (hwp_active)
-		intel_pstate_hwp_set_online_cpus();
+	intel_pstate_update_policies();
 	return count;
 }
 

