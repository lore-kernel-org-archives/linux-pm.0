From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] cpufreq: intel_pstate: Use locking in intel_cpufreq_verify_policy()
Date: Fri, 30 Dec 2016 15:57:11 +0100
Message-ID: <2958352.e0VhhpxTVR@aspire.rjw.lan>
References: <5344750.TOCWYON8QY@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5344750.TOCWYON8QY@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Race conditions are possible if intel_cpufreq_verify_policy()
is executed in parallel with global limits updates from sysfs,
so the invocation of intel_pstate_update_perf_limits() in it
should be carried out under intel_pstate_limits_lock.

Make that happen.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2157,8 +2157,12 @@ static int intel_cpufreq_verify_policy(s
 	if (per_cpu_limits)
 		perf_limits = cpu->perf_limits;
 
+	mutex_lock(&intel_pstate_limits_lock);
+
 	intel_pstate_update_perf_limits(policy, perf_limits);
 
+	mutex_unlock(&intel_pstate_limits_lock);
+
 	return 0;
 }
 
