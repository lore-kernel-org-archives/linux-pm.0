From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 2/3] firmware: qcom: scm: Add qcom_scm_set_warm_boot_addr function
Date: Mon,  2 Mar 2015 16:30:29 -0700
Message-ID: <1425339030-45828-3-git-send-email-lina.iyer@linaro.org>
References: <1425339030-45828-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:43259 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbbCBXaq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2015 18:30:46 -0500
Received: by pablj1 with SMTP id lj1so9191705pab.10
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2015 15:30:46 -0800 (PST)
In-Reply-To: <1425339030-45828-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, khilman@linaro.org, Lina Iyer <lina.iyer@linaro.org>

A core can be powered down for cpuidle or when it is hotplugged off. In
either case, the warmboot return address would be different. Allow
setting the warmboot address for a specific cpu, optimize and write to
the firmware, if the address is different than the previously set
address.

Export qcom_scm_set_warm_boot_addr function move the warm boot flags to
implementation.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/firmware/qcom_scm.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/qcom_scm.h    |  7 ++----
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index c953cc3..4d8ede4 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1,4 +1,5 @@
 /* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ * Copyright (C) 2015 Linaro Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -39,6 +40,23 @@
 #define QCOM_SCM_FLAG_COLDBOOT_CPU2	0x08
 #define QCOM_SCM_FLAG_COLDBOOT_CPU3	0x20
 
+#define QCOM_SCM_FLAG_WARMBOOT_CPU0	0x04
+#define QCOM_SCM_FLAG_WARMBOOT_CPU1	0x02
+#define QCOM_SCM_FLAG_WARMBOOT_CPU2	0x10
+#define QCOM_SCM_FLAG_WARMBOOT_CPU3	0x40
+
+struct qcom_scm_entry {
+	int flag;
+	void *entry;
+};
+
+static struct qcom_scm_entry qcom_scm_wb[] = {
+	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU0 },
+	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU1 },
+	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU2 },
+	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU3 },
+};
+
 static DEFINE_MUTEX(qcom_scm_lock);
 
 /**
@@ -379,3 +397,41 @@ int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
 	return qcom_scm_set_boot_addr(virt_to_phys(entry), flags);
 }
 EXPORT_SYMBOL(qcom_scm_set_cold_boot_addr);
+
+/**
+ * qcom_scm_set_warm_boot_addr() - Set the warm boot address for cpus
+ * @entry: Entry point function for the cpus
+ * @cpus: The cpumask of cpus that will use the entry point
+ *
+ * Set the Linux entry point for the SCM to transfer control to when coming
+ * out of a power down. CPU power down may be executed on cpuidle or hotplug.
+ */
+int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
+{
+	int ret;
+	int flags = 0;
+	int cpu;
+
+	/*
+	 * Reassign only if we are switching from hotplug entry point
+	 * to cpuidle entry point or vice versa.
+	 */
+	for_each_cpu(cpu, cpus) {
+		if (entry == qcom_scm_wb[cpu].entry)
+			continue;
+		flags |= qcom_scm_wb[cpu].flag;
+	}
+
+	/* No change in entry function */
+	if (!flags)
+		return 0;
+
+	ret = qcom_scm_set_boot_addr(virt_to_phys(entry), flags);
+	if (!ret) {
+		for_each_cpu(cpu, cpus)
+			qcom_scm_wb[cpu].entry = entry;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(qcom_scm_set_warm_boot_addr);
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 68a1d88..95ef72a 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -1,4 +1,5 @@
 /* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ * Copyright (C) 2015 Linaro Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -12,12 +13,8 @@
 #ifndef __QCOM_SCM_H
 #define __QCOM_SCM_H
 
-#define QCOM_SCM_FLAG_WARMBOOT_CPU0		0x04
-#define QCOM_SCM_FLAG_WARMBOOT_CPU1		0x02
-#define QCOM_SCM_FLAG_WARMBOOT_CPU2		0x10
-#define QCOM_SCM_FLAG_WARMBOOT_CPU3		0x40
-
 extern int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus);
+extern int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus);
 
 #define QCOM_SCM_VERSION(major, minor) (((major) << 16) | ((minor) & 0xFF))
 
-- 
2.1.0

