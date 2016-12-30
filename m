From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] cpufreq: intel_pstate: Use locking in intel_pstate_resume()
Date: Fri, 30 Dec 2016 15:56:14 +0100
Message-ID: <2964225.km2UYHItYB@aspire.rjw.lan>
References: <5344750.TOCWYON8QY@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61759 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754194AbcL3PCy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Dec 2016 10:02:54 -0500
In-Reply-To: <5344750.TOCWYON8QY@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Theoretically, intel_pstate_resume() may be executed in parallel
with intel_pstate_set_policy(), if the latter is invoked via
cpufreq_update_policy() as a result of a notification, so use
intel_pstate_limits_lock in there too to avoid race conditions.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -968,12 +968,20 @@ static int intel_pstate_hwp_save_state(s
 
 static int intel_pstate_resume(struct cpufreq_policy *policy)
 {
+	int ret;
+
 	if (!hwp_active)
 		return 0;
 
+	mutex_lock(&intel_pstate_limits_lock);
+
 	all_cpu_data[policy->cpu]->epp_policy = 0;
 
-	return intel_pstate_hwp_set_policy(policy);
+	ret = intel_pstate_hwp_set_policy(policy);
+
+	mutex_unlock(&intel_pstate_limits_lock);
+
+	return ret;
 }
 
 static void intel_pstate_hwp_set_online_cpus(void)

