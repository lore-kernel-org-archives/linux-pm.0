From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 04/16] cpufreq: intel_pstate: Fold intel_pstate_reset_all_pid() into the caller
Date: Tue, 28 Mar 2017 00:07:15 +0200
Message-ID: <2138140.7OVzaumNXP@aspire.rjw.lan>
References: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44261 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752740AbdC0Wns (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 18:43:48 -0400
In-Reply-To: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is only one caller of intel_pstate_reset_all_pid(), which is
pid_param_set() used in the debugfs interface only, and having that
code split does not make it particularly convenient to follow.

For this reason, move the body of intel_pstate_reset_all_pid() into
its caller and drop that function.

Also change the loop from for_each_online_cpu() (which is obviously
racy with respect to CPU offline/online) to for_each_possible_cpu(),
so that all PID parameters are reset for all CPUs regardless of their
online/offline status (to prevent, for example, a previously offline
CPU from going online with a stale set of PID parameters).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -576,16 +576,6 @@ static inline void intel_pstate_busy_pid
 	pid_reset(&cpu->pid, pid_params.setpoint, 100, pid_params.deadband, 0);
 }
 
-static inline void intel_pstate_reset_all_pid(void)
-{
-	unsigned int cpu;
-
-	for_each_online_cpu(cpu) {
-		if (all_cpu_data[cpu])
-			intel_pstate_busy_pid_reset(all_cpu_data[cpu]);
-	}
-}
-
 static inline void update_turbo_state(void)
 {
 	u64 misc_en;
@@ -941,9 +931,14 @@ static void intel_pstate_update_policies
 /************************** debugfs begin ************************/
 static int pid_param_set(void *data, u64 val)
 {
+	unsigned int cpu;
+
 	*(u32 *)data = val;
 	pid_params.sample_rate_ns = pid_params.sample_rate_ms * NSEC_PER_MSEC;
-	intel_pstate_reset_all_pid();
+	for_each_possible_cpu(cpu)
+		if (all_cpu_data[cpu])
+			intel_pstate_busy_pid_reset(all_cpu_data[cpu]);
+
 	return 0;
 }
 
