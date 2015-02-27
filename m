From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2] qcom: scm: Add qcom_scm_set_warm_boot_addr function
Date: Fri, 27 Feb 2015 13:47:27 -0700
Message-ID: <1425070047-53449-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:45469 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbbB0Uri (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Feb 2015 15:47:38 -0500
Received: by pdjz10 with SMTP id z10so23530078pdj.12
        for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2015 12:47:38 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: galak@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org
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
 drivers/firmware/qcom_scm.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/qcom_scm.h    |  5 +----
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 6e7a72b..19133ca 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -34,6 +34,23 @@
 #define QCOM_SCM_ERROR		-1
 #define QCOM_SCM_INTERRUPTED	1
 
+#define QCOM_SCM_FLAG_WARMBOOT_CPU0	0x04
+#define QCOM_SCM_FLAG_WARMBOOT_CPU1	0x02
+#define QCOM_SCM_FLAG_WARMBOOT_CPU2	0x10
+#define QCOM_SCM_FLAG_WARMBOOT_CPU3	0x40
+
+struct scm_warmboot {
+	int flag;
+	void *entry;
+};
+
+static struct scm_warmboot scm_flags[] = {
+	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU0 },
+	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU1 },
+	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU2 },
+	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU3 },
+};
+
 static DEFINE_MUTEX(qcom_scm_lock);
 
 /**
@@ -342,3 +359,22 @@ int qcom_scm_set_boot_addr(u32 addr, int flags)
 			&cmd, sizeof(cmd), NULL, 0);
 }
 EXPORT_SYMBOL(qcom_scm_set_boot_addr);
+
+int qcom_scm_set_warm_boot_addr(void *entry, int cpu)
+{
+	int ret;
+
+	/*
+	 * Reassign only if we are switching from hotplug entry point
+	 * to cpuidle entry point or vice versa.
+	 */
+	if (entry == scm_flags[cpu].entry)
+		return 0;
+
+	ret = qcom_scm_set_boot_addr(virt_to_phys(entry), scm_flags[cpu].flag);
+	if (!ret)
+		scm_flags[cpu].entry  = entry;
+
+	return ret;
+}
+EXPORT_SYMBOL(qcom_scm_set_warm_boot_addr);
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 6bb84cf..fc5aae4 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -15,12 +15,9 @@
 #define QCOM_SCM_FLAG_COLDBOOT_CPU1		0x01
 #define QCOM_SCM_FLAG_COLDBOOT_CPU2		0x08
 #define QCOM_SCM_FLAG_COLDBOOT_CPU3		0x20
-#define QCOM_SCM_FLAG_WARMBOOT_CPU0		0x04
-#define QCOM_SCM_FLAG_WARMBOOT_CPU1		0x02
-#define QCOM_SCM_FLAG_WARMBOOT_CPU2		0x10
-#define QCOM_SCM_FLAG_WARMBOOT_CPU3		0x40
 
 extern int qcom_scm_set_boot_addr(u32 addr, int flags);
+extern int qcom_scm_set_warm_boot_addr(void *entry, int cpu);
 
 #define QCOM_SCM_VERSION(major, minor) (((major) << 16) | ((minor) & 0xFF))
 
-- 
2.1.0

