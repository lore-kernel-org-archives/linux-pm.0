From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/2] intel_pstate: expose turbo range to sysfs
Date: Wed, 28 Jan 2015 15:03:27 -0800
Message-ID: <1422486208-14367-2-git-send-email-kristen@linux.intel.com>
References: <1422486208-14367-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35797 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113AbbA2B1z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 Jan 2015 20:27:55 -0500
In-Reply-To: <1422486208-14367-1-git-send-email-kristen@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org

This patch adds "turbo_pct" to the intel_pstate sysfs interface.
turbo_pct will display the percentage of the total supported
pstates that are in the turbo range.  This value is independent
of whether turbo has been disabled or not.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 Documentation/cpu-freq/intel-pstate.txt |  4 ++++
 drivers/cpufreq/intel_pstate.c          | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation/cpu-freq/intel-pstate.txt
index 765d7fc..7767ce6 100644
--- a/Documentation/cpu-freq/intel-pstate.txt
+++ b/Documentation/cpu-freq/intel-pstate.txt
@@ -37,6 +37,10 @@ controlling P state selection. These files have been added to
       no_turbo: limits the driver to selecting P states below the turbo
       frequency range.
 
+      turbo_pct: displays the percentage of the total performance that
+      is supported by hardware that is in the turbo range.  This number
+      is independent of whether turbo has been disabled or not.
+
 For contemporary Intel processors, the frequency is controlled by the
 processor itself and the P-states exposed to software are related to
 performance levels.  The idea that frequency can be set to a single
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 742eefb..f558c2e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -338,6 +338,22 @@ static void __init intel_pstate_debug_expose_params(void)
 		return sprintf(buf, "%u\n", limits.object);		\
 	}
 
+static ssize_t show_turbo_pct(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	struct cpudata *cpu;
+	int total, no_turbo, turbo_pct;
+	uint32_t turbo_fp;
+
+	cpu = all_cpu_data[0];
+
+	total = cpu->pstate.turbo_pstate - cpu->pstate.min_pstate + 1;
+	no_turbo = cpu->pstate.max_pstate - cpu->pstate.min_pstate + 1;
+	turbo_fp = div_fp(int_tofp(no_turbo), int_tofp(total));
+	turbo_pct = 100 - fp_toint(mul_fp(turbo_fp, int_tofp(100)));
+	return sprintf(buf, "%u\n", turbo_pct);
+}
+
 static ssize_t show_no_turbo(struct kobject *kobj,
 			     struct attribute *attr, char *buf)
 {
@@ -418,11 +434,13 @@ show_one(min_perf_pct, min_perf_pct);
 define_one_global_rw(no_turbo);
 define_one_global_rw(max_perf_pct);
 define_one_global_rw(min_perf_pct);
+define_one_global_ro(turbo_pct);
 
 static struct attribute *intel_pstate_attributes[] = {
 	&no_turbo.attr,
 	&max_perf_pct.attr,
 	&min_perf_pct.attr,
+	&turbo_pct.attr,
 	NULL
 };
 
-- 
1.9.3

