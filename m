From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC/RFT] [PATCH v2 5/6] cpufreq: intel_pstate: New sysfs entry to control HWP boost
Date: Wed, 23 May 2018 18:47:37 -0700
Message-ID: <20180524014738.52924-6-srinivas.pandruvada@linux.intel.com>
References: <20180524014738.52924-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524014738.52924-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net, peterz@infradead.org, mgorman@techsingularity.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com, viresh.kumar@linaro.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

A new attribute is added to intel_pstate sysfs to enable/disable
HWP dynamic performance boost.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6d0ebe4fe1c7..b2613c9775d5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1033,6 +1033,30 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 	return count;
 }
 
+static ssize_t show_hwp_dynamic_boost(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", hwp_boost);
+}
+
+static ssize_t store_hwp_dynamic_boost(struct kobject *a, struct attribute *b,
+				       const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &input);
+	if (ret)
+		return ret;
+
+	mutex_lock(&intel_pstate_driver_lock);
+	hwp_boost = !!input;
+	intel_pstate_update_policies();
+	mutex_unlock(&intel_pstate_driver_lock);
+
+	return count;
+}
+
 show_one(max_perf_pct, max_perf_pct);
 show_one(min_perf_pct, min_perf_pct);
 
@@ -1042,6 +1066,7 @@ define_one_global_rw(max_perf_pct);
 define_one_global_rw(min_perf_pct);
 define_one_global_ro(turbo_pct);
 define_one_global_ro(num_pstates);
+define_one_global_rw(hwp_dynamic_boost);
 
 static struct attribute *intel_pstate_attributes[] = {
 	&status.attr,
@@ -1082,6 +1107,11 @@ static void __init intel_pstate_sysfs_expose_params(void)
 	rc = sysfs_create_file(intel_pstate_kobject, &min_perf_pct.attr);
 	WARN_ON(rc);
 
+	if (hwp_active) {
+		rc = sysfs_create_file(intel_pstate_kobject,
+				       &hwp_dynamic_boost.attr);
+		WARN_ON(rc);
+	}
 }
 /************************** sysfs end ************************/
 
-- 
2.13.6
