From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/2] intel_pstate: Add num_pstates to sysfs
Date: Wed, 28 Jan 2015 15:03:28 -0800
Message-ID: <1422486208-14367-3-git-send-email-kristen@linux.intel.com>
References: <1422486208-14367-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:34165 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755327AbbA2B2v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 Jan 2015 20:28:51 -0500
In-Reply-To: <1422486208-14367-1-git-send-email-kristen@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org

Add a sysfs interface to display the total number of supported
pstates.  This value is independent of whether turbo has been
enabled or disabled.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 Documentation/cpu-freq/intel-pstate.txt |  4 ++++
 drivers/cpufreq/intel_pstate.c          | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation/cpu-freq/intel-pstate.txt
index 7767ce6..6557507 100644
--- a/Documentation/cpu-freq/intel-pstate.txt
+++ b/Documentation/cpu-freq/intel-pstate.txt
@@ -41,6 +41,10 @@ controlling P state selection. These files have been added to
       is supported by hardware that is in the turbo range.  This number
       is independent of whether turbo has been disabled or not.
 
+      num_pstates: displays the number of pstates that are supported
+      by hardware.  This number is independent of whether turbo has
+      been disabled or not.
+
 For contemporary Intel processors, the frequency is controlled by the
 processor itself and the P-states exposed to software are related to
 performance levels.  The idea that frequency can be set to a single
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f558c2e..3ea9aff 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -354,6 +354,17 @@ static ssize_t show_turbo_pct(struct kobject *kobj,
 	return sprintf(buf, "%u\n", turbo_pct);
 }
 
+static ssize_t show_num_pstates(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	struct cpudata *cpu;
+	int total;
+
+	cpu = all_cpu_data[0];
+	total = cpu->pstate.turbo_pstate - cpu->pstate.min_pstate + 1;
+	return sprintf(buf, "%u\n", total);
+}
+
 static ssize_t show_no_turbo(struct kobject *kobj,
 			     struct attribute *attr, char *buf)
 {
@@ -435,12 +446,14 @@ define_one_global_rw(no_turbo);
 define_one_global_rw(max_perf_pct);
 define_one_global_rw(min_perf_pct);
 define_one_global_ro(turbo_pct);
+define_one_global_ro(num_pstates);
 
 static struct attribute *intel_pstate_attributes[] = {
 	&no_turbo.attr,
 	&max_perf_pct.attr,
 	&min_perf_pct.attr,
 	&turbo_pct.attr,
+	&num_pstates.attr,
 	NULL
 };
 
-- 
1.9.3

