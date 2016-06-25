From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: regression caused by bb6ab52f2bef ("intel_pstate: Do not set utilization update hook too early")
Date: Sat, 25 Jun 2016 02:14:28 +0200
Message-ID: <2958182.eDEME9b2CX@vostro.rjw.lan>
References: <20160617163023.5bb374f8@xhacker> <393b63b7caa7474a97baf248c4891b72@SC-EXCH02.marvell.com> <24e20dd7b2b047a19515ff52ad105c37@SC-EXCH02.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52565 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751665AbcFYAKT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jun 2016 20:10:19 -0400
In-Reply-To: <24e20dd7b2b047a19515ff52ad105c37@SC-EXCH02.marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>

On Friday, June 17, 2016 04:09:33 PM Jisheng Zhang wrote:
> Dear all,
> 
> If using acpi-cpufreq instead, v4.6, v4.6-rc3, v4.7-rc3 can't reproduce the issue. It seems
> only intel_pstate is impacted.

Which is quite obvious, since the commit your bisection led to was
intel_pstate-specific. :-)

If the issue is what I'm thinking it is, the patch below should help, so
can you please test it?

Thanks,
Rafael

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] intel_pstate: Do not clear utilization update hooks on policy changes

intel_pstate_set_policy() is invoked by the cpufreq core during
driver initialization, on changes of policy attributes (minimim and
maximum frequency, for example) via sysfs and via CPU notifications
from the platform firmware.  On some platforms the latter may occur
relatively often.

Commit bb6ab52f2bef (intel_pstate: Do not set utilization update hook
too early) made intel_pstate_set_policy() clear the CPU's utilization
update hook before updating the policy attributes for it (and set the
hook again after doind that), but that involves invoking
synchronize_sched() and adds overhead to the CPU notifications
mentioned above and to the sched-RCU handling in general.

That extra overhead is arguably not necessary, because updating
policy attributes when the CPU's utilization update hook is active
should not lead to any adverse effects, so drop the clearing of
the hook from intel_pstate_set_policy() and make it check if
the hook has been set already when attempting to set it.

Fixes: bb6ab52f2bef (intel_pstate: Do not set utilization update hook too early)
Reported-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1440,6 +1440,9 @@ static void intel_pstate_set_update_util
 {
 	struct cpudata *cpu = all_cpu_data[cpu_num];
 
+	if (cpu->update_util_set)
+		return;
+
 	/* Prevent intel_pstate_update_util() from using stale data. */
 	cpu->sample.time = 0;
 	cpufreq_add_update_util_hook(cpu_num, &cpu->update_util,
@@ -1480,8 +1483,6 @@ static int intel_pstate_set_policy(struc
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
-	intel_pstate_clear_update_util_hook(policy->cpu);
-
 	pr_debug("set_policy cpuinfo.max %u policy->max %u\n",
 		 policy->cpuinfo.max_freq, policy->max);
 

