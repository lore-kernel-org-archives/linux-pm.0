From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v12 02/10] qcom: scm: Add SCM warmboot support for quad core SoCs
Date: Wed, 26 Nov 2014 17:13:07 -0700
Message-ID: <1417047195-18978-3-git-send-email-lina.iyer@linaro.org>
References: <1417047195-18978-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:48017 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbaK0ANe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 19:13:34 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so3748214pdj.7
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 16:13:34 -0800 (PST)
In-Reply-To: <1417047195-18978-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

Quad core SoCs like APQ8074, APQ8064, APQ8084 need SCM support set up
warm boot addresses in the Secure Monitor. Extend the SCM flags to
support warm boot addresses for secondary cores.

We do not need to export the warmboot flags. Move them into the
implementation file.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/soc/qcom/scm-boot.c | 35 +++++++++++++++++++++++++++++++++++
 include/soc/qcom/scm-boot.h |  3 +--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/scm-boot.c b/drivers/soc/qcom/scm-boot.c
index 60ff7b4..f653217a 100644
--- a/drivers/soc/qcom/scm-boot.c
+++ b/drivers/soc/qcom/scm-boot.c
@@ -21,6 +21,23 @@
 #include <soc/qcom/scm.h>
 #include <soc/qcom/scm-boot.h>
 
+#define SCM_FLAG_WARMBOOT_CPU0		0x04
+#define SCM_FLAG_WARMBOOT_CPU1		0x02
+#define SCM_FLAG_WARMBOOT_CPU2		0x10
+#define SCM_FLAG_WARMBOOT_CPU3		0x40
+
+struct scm_warmboot {
+	int flag;
+	void *entry;
+};
+
+static struct scm_warmboot scm_flags[] = {
+	{ .flag = SCM_FLAG_WARMBOOT_CPU0 },
+	{ .flag = SCM_FLAG_WARMBOOT_CPU1 },
+	{ .flag = SCM_FLAG_WARMBOOT_CPU2 },
+	{ .flag = SCM_FLAG_WARMBOOT_CPU3 },
+};
+
 /*
  * Set the cold/warm boot address for one of the CPU cores.
  */
@@ -37,3 +54,21 @@ int scm_set_boot_addr(phys_addr_t addr, int flags)
 			&cmd, sizeof(cmd), NULL, 0);
 }
 EXPORT_SYMBOL(scm_set_boot_addr);
+
+int scm_set_warm_boot_addr(void *entry, int cpu)
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
+	ret = scm_set_boot_addr(virt_to_phys(entry), scm_flags[cpu].flag);
+	if (!ret)
+		scm_flags[cpu].entry  = entry;
+
+	return ret;
+}
diff --git a/include/soc/qcom/scm-boot.h b/include/soc/qcom/scm-boot.h
index 6aabb24..529f55a 100644
--- a/include/soc/qcom/scm-boot.h
+++ b/include/soc/qcom/scm-boot.h
@@ -16,9 +16,8 @@
 #define SCM_FLAG_COLDBOOT_CPU1		0x01
 #define SCM_FLAG_COLDBOOT_CPU2		0x08
 #define SCM_FLAG_COLDBOOT_CPU3		0x20
-#define SCM_FLAG_WARMBOOT_CPU0		0x04
-#define SCM_FLAG_WARMBOOT_CPU1		0x02
 
 int scm_set_boot_addr(phys_addr_t addr, int flags);
+int scm_set_warm_boot_addr(void *entry, int cpu);
 
 #endif
-- 
2.1.0

