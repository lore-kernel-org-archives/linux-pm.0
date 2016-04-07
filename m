From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Skip all governor-related actions for cpufreq_suspended set
Date: Thu, 07 Apr 2016 03:29:14 +0200
Message-ID: <2044559.GVlD7a2JcO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since governor operations are generally skipped if cpufreq_suspended
is set, do nothing at all in cpufreq_start_governor() and
cpufreq_exit_governor() in that case.

In particular, this prevents fast frequency switching from being
disabled after a suspend-to-RAM cycle on all CPUs except for the
boot one.

Fixes: b7898fda5bc7 (cpufreq: Support for fast frequency switching)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2053,6 +2053,9 @@ static int cpufreq_start_governor(struct
 {
 	int ret;
 
+	if (cpufreq_suspended)
+		return 0;
+
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy)
 		cpufreq_update_current_freq(policy);
 
@@ -2062,6 +2065,9 @@ static int cpufreq_start_governor(struct
 
 static int cpufreq_exit_governor(struct cpufreq_policy *policy)
 {
+	if (cpufreq_suspended)
+		return 0;
+
 	cpufreq_disable_fast_switch(policy);
 	return cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
 }
