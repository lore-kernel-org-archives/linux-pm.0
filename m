From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH 3/3] cpufreq: acpi_cpufreq: Support base_frequency
Date: Fri,  4 Sep 2015 10:19:19 -0700
Message-ID: <1441387159-19860-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1441387159-19860-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51149 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932864AbbIDRTj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Sep 2015 13:19:39 -0400
In-Reply-To: <1441387159-19860-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Using new cpufreq base_frequency, displaying the correct base frequency.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 0136dfc..4350809 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -640,6 +640,19 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 }
 #endif
 
+static int acpi_cpufreq_get_base_frequency(int cpu, unsigned int *start)
+{
+	u64 tar;
+	int err;
+
+	err = rdmsrl_safe_on_cpu(cpu, MSR_TURBO_ACTIVATION_RATIO, &tar);
+	if (!err)
+		/* only supported in core cpus so scaling is fixed */
+		*start = tar * 100000;
+
+	return err;
+}
+
 static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int i;
@@ -916,6 +929,18 @@ static void __init acpi_cpufreq_boost_init(void)
 		__register_cpu_notifier(&boost_nb);
 
 		cpu_notifier_register_done();
+
+		/* Check if we need to register base freq */
+		if (boot_cpu_data.x86_vendor ==  X86_VENDOR_INTEL) {
+			u64 tar;
+			int err;
+
+			err = rdmsrl_safe(MSR_TURBO_ACTIVATION_RATIO, &tar);
+			if (!err)
+				acpi_cpufreq_driver.base_frequency =
+					acpi_cpufreq_get_base_frequency;
+		}
+
 	}
 }
 
-- 
2.4.3

