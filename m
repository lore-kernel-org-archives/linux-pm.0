From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 1/3] firmware: qcom: scm: Clean cold boot entry to export only the API
Date: Mon,  2 Mar 2015 16:30:28 -0700
Message-ID: <1425339030-45828-2-git-send-email-lina.iyer@linaro.org>
References: <1425339030-45828-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:38992 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbbCBXap (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2015 18:30:45 -0500
Received: by pablf10 with SMTP id lf10so47750941pab.6
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2015 15:30:44 -0800 (PST)
In-Reply-To: <1425339030-45828-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, khilman@linaro.org, Lina Iyer <lina.iyer@linaro.org>

We dont need to export the SCM specific cold boot flags to the platform
code. Export only a function to set the cold boot address.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/mach-qcom/platsmp.c | 21 +++------------------
 drivers/firmware/qcom_scm.c  | 41 +++++++++++++++++++++++++++++++++++++++--
 include/linux/qcom_scm.h     |  5 +----
 3 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
index 4b67e56..5cde63a 100644
--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -319,25 +319,10 @@ static int kpssv2_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static void __init qcom_smp_prepare_cpus(unsigned int max_cpus)
 {
-	int cpu, map;
-	unsigned int flags = 0;
-	static const int cold_boot_flags[] = {
-		0,
-		QCOM_SCM_FLAG_COLDBOOT_CPU1,
-		QCOM_SCM_FLAG_COLDBOOT_CPU2,
-		QCOM_SCM_FLAG_COLDBOOT_CPU3,
-	};
-
-	for_each_present_cpu(cpu) {
-		map = cpu_logical_map(cpu);
-		if (WARN_ON(map >= ARRAY_SIZE(cold_boot_flags))) {
-			set_cpu_present(cpu, false);
-			continue;
-		}
-		flags |= cold_boot_flags[map];
-	}
+	int cpu;
 
-	if (qcom_scm_set_boot_addr(virt_to_phys(secondary_startup_arm), flags)) {
+	if (qcom_scm_set_cold_boot_addr(secondary_startup_arm,
+					cpu_present_mask)) {
 		for_each_present_cpu(cpu) {
 			if (cpu == smp_processor_id())
 				continue;
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 6e7a72b..c953cc3 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -34,6 +34,11 @@
 #define QCOM_SCM_ERROR		-1
 #define QCOM_SCM_INTERRUPTED	1
 
+#define QCOM_SCM_FLAG_COLDBOOT_CPU0	0x00
+#define QCOM_SCM_FLAG_COLDBOOT_CPU1	0x01
+#define QCOM_SCM_FLAG_COLDBOOT_CPU2	0x08
+#define QCOM_SCM_FLAG_COLDBOOT_CPU3	0x20
+
 static DEFINE_MUTEX(qcom_scm_lock);
 
 /**
@@ -329,7 +334,7 @@ EXPORT_SYMBOL(qcom_scm_get_version);
 /*
  * Set the cold/warm boot address for one of the CPU cores.
  */
-int qcom_scm_set_boot_addr(u32 addr, int flags)
+static int qcom_scm_set_boot_addr(u32 addr, int flags)
 {
 	struct {
 		__le32 flags;
@@ -341,4 +346,36 @@ int qcom_scm_set_boot_addr(u32 addr, int flags)
 	return qcom_scm_call(QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_ADDR,
 			&cmd, sizeof(cmd), NULL, 0);
 }
-EXPORT_SYMBOL(qcom_scm_set_boot_addr);
+
+/**
+ * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
+ * @entry: Entry point function for the cpus
+ * @cpus: The cpumask of cpus that will use the entry point
+ *
+ * Set the cold boot address of the cpus. Any cpu outside the supported
+ * range would be removed from the cpu present mask.
+ */
+int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
+{
+	int flags = 0;
+	int cpu;
+	int scm_cb_flags[] = {
+		QCOM_SCM_FLAG_COLDBOOT_CPU0,
+		QCOM_SCM_FLAG_COLDBOOT_CPU1,
+		QCOM_SCM_FLAG_COLDBOOT_CPU2,
+		QCOM_SCM_FLAG_COLDBOOT_CPU3,
+	};
+
+	if (!cpus || (cpus && cpumask_empty(cpus)))
+		return -EINVAL;
+
+	for_each_cpu(cpu, cpus) {
+		if (cpu < ARRAY_SIZE(scm_cb_flags))
+			flags |= scm_cb_flags[cpu];
+		else
+			set_cpu_present(cpu, false);
+	}
+
+	return qcom_scm_set_boot_addr(virt_to_phys(entry), flags);
+}
+EXPORT_SYMBOL(qcom_scm_set_cold_boot_addr);
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 6bb84cf..68a1d88 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -12,15 +12,12 @@
 #ifndef __QCOM_SCM_H
 #define __QCOM_SCM_H
 
-#define QCOM_SCM_FLAG_COLDBOOT_CPU1		0x01
-#define QCOM_SCM_FLAG_COLDBOOT_CPU2		0x08
-#define QCOM_SCM_FLAG_COLDBOOT_CPU3		0x20
 #define QCOM_SCM_FLAG_WARMBOOT_CPU0		0x04
 #define QCOM_SCM_FLAG_WARMBOOT_CPU1		0x02
 #define QCOM_SCM_FLAG_WARMBOOT_CPU2		0x10
 #define QCOM_SCM_FLAG_WARMBOOT_CPU3		0x40
 
-extern int qcom_scm_set_boot_addr(u32 addr, int flags);
+extern int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus);
 
 #define QCOM_SCM_VERSION(major, minor) (((major) << 16) | ((minor) & 0xFF))
 
-- 
2.1.0

