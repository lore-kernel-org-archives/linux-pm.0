From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V2] cpufreq: powernv: Add boost files to export ultra-turbo frequencies
Date: Tue,  3 Jan 2017 16:36:00 +0530
Message-ID: <1483441560-11957-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53911 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756113AbdACLGS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2017 06:06:18 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id v03B41vh139631
        for <linux-pm@vger.kernel.org>; Tue, 3 Jan 2017 06:06:17 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
        by mx0b-001b2d01.pphosted.com with ESMTP id 27r9r2amg6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2017 06:06:17 -0500
Received: from localhost
        by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
        Tue, 3 Jan 2017 16:36:14 +0530
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, svaidy@linux.vnet.ibm.com
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

In P8+, Workload Optimized Frequency(WOF) provides the capability to
boost the cpu frequency based on the utilization of the other cpus
running in the chip. The On-Chip-Controller(OCC) firmware will control
the achievability of these frequencies depending on the power headroom
available in the chip. Currently the ultra-turbo frequencies provided
by this feature are exported along with the turbo and sub-turbo
frequencies as scaling_available_frequencies. This patch will export
the ultra-turbo frequencies separately as scaling_boost_frequencies in
WOF enabled systems. This patch will add the boost sysfs file which
can be used to disable/enable ultra-turbo frequencies.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
Changes from v1:
- Print if WOF is enabled
- s/clean_notifiers/cleanup_notifiers

 drivers/cpufreq/powernv-cpufreq.c | 50 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 37671b5..3ff5160 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -144,6 +144,7 @@ enum throttle_reason_type {
 	unsigned int max;
 	unsigned int nominal;
 	unsigned int nr_pstates;
+	bool wof_enabled;
 } powernv_pstate_info;
 
 /* Use following macros for conversions between pstate_id and index */
@@ -203,6 +204,7 @@ static int init_powernv_pstates(void)
 	const __be32 *pstate_ids, *pstate_freqs;
 	u32 len_ids, len_freqs;
 	u32 pstate_min, pstate_max, pstate_nominal;
+	u32 pstate_turbo, pstate_ultra_turbo;
 
 	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!power_mgt) {
@@ -225,8 +227,29 @@ static int init_powernv_pstates(void)
 		pr_warn("ibm,pstate-nominal not found\n");
 		return -ENODEV;
 	}
+
+	if (of_property_read_u32(power_mgt, "ibm,pstate-ultra-turbo",
+				 &pstate_ultra_turbo)) {
+		powernv_pstate_info.wof_enabled = false;
+		goto next;
+	}
+
+	if (of_property_read_u32(power_mgt, "ibm,pstate-turbo",
+				 &pstate_turbo)) {
+		powernv_pstate_info.wof_enabled = false;
+		goto next;
+	}
+
+	if (pstate_turbo == pstate_ultra_turbo)
+		powernv_pstate_info.wof_enabled = false;
+	else
+		powernv_pstate_info.wof_enabled = true;
+
+next:
 	pr_info("cpufreq pstate min %d nominal %d max %d\n", pstate_min,
 		pstate_nominal, pstate_max);
+	pr_info("Workload Optimized Frequency is %s in the platform\n",
+		(powernv_pstate_info.wof_enabled) ? "enabled" : "disabled");
 
 	pstate_ids = of_get_property(power_mgt, "ibm,pstate-ids", &len_ids);
 	if (!pstate_ids) {
@@ -268,6 +291,13 @@ static int init_powernv_pstates(void)
 			powernv_pstate_info.nominal = i;
 		else if (id == pstate_min)
 			powernv_pstate_info.min = i;
+
+		if (powernv_pstate_info.wof_enabled && id == pstate_turbo) {
+			int j;
+
+			for (j = i - 1; j >= (int)powernv_pstate_info.max; j--)
+				powernv_freqs[j].flags = CPUFREQ_BOOST_FREQ;
+		}
 	}
 
 	/* End of list marker entry */
@@ -305,9 +335,12 @@ static ssize_t cpuinfo_nominal_freq_show(struct cpufreq_policy *policy,
 struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq =
 	__ATTR_RO(cpuinfo_nominal_freq);
 
+#define SCALING_BOOST_FREQS_ATTR_INDEX		2
+
 static struct freq_attr *powernv_cpu_freq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	&cpufreq_freq_attr_cpuinfo_nominal_freq,
+	&cpufreq_freq_attr_scaling_boost_freqs,
 	NULL,
 };
 
@@ -1013,11 +1046,22 @@ static int __init powernv_cpufreq_init(void)
 	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
 	opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
 
+	if (powernv_pstate_info.wof_enabled)
+		powernv_cpufreq_driver.boost_enabled = true;
+	else
+		powernv_cpu_freq_attr[SCALING_BOOST_FREQS_ATTR_INDEX] = NULL;
+
 	rc = cpufreq_register_driver(&powernv_cpufreq_driver);
-	if (!rc)
-		return 0;
+	if (rc) {
+		pr_info("Failed to register the cpufreq driver (%d)\n", rc);
+		goto cleanup_notifiers;
+	}
 
-	pr_info("Failed to register the cpufreq driver (%d)\n", rc);
+	if (powernv_pstate_info.wof_enabled)
+		cpufreq_enable_boost_support();
+
+	return 0;
+cleanup_notifiers:
 	unregister_all_notifiers();
 	clean_chip_info();
 out:
-- 
1.8.3.1

