From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 2/2] qcom: scm: Add scm_set_warm_boot_addr function
Date: Wed, 25 Feb 2015 15:54:12 -0700
Message-ID: <1424904852-12719-3-git-send-email-lina.iyer@linaro.org>
References: <1424904852-12719-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34103 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbbBYWyk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 17:54:40 -0500
Received: by pabrd3 with SMTP id rd3so8838365pab.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2015 14:54:40 -0800 (PST)
In-Reply-To: <1424904852-12719-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: galak@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

A core can be powered down for cpuidle or when it is hotplugged of. In
either case, the warmboot return address would be different. Allow
setting the warmboot address for a specific cpu, optimize and write to
the firmware if the address is different than the previously set
address.

Also we do not need to export the warmboot flags. Move them into the
implementation file.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/mach-qcom/scm-boot.c | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-qcom/scm-boot.h |  7 +++----
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-qcom/scm-boot.c b/arch/arm/mach-qcom/scm-boot.c
index 45cee3e..cb73134 100644
--- a/arch/arm/mach-qcom/scm-boot.c
+++ b/arch/arm/mach-qcom/scm-boot.c
@@ -1,4 +1,5 @@
 /* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ * Copyright (c) 2014, Linaro Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -21,6 +22,23 @@
 #include "scm.h"
 #include "scm-boot.h"
 
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
@@ -31,9 +49,29 @@ int scm_set_boot_addr(phys_addr_t addr, int flags)
 		phys_addr_t  addr;
 	} cmd;
 
+	might_sleep();
+
 	cmd.addr = addr;
 	cmd.flags = flags;
 	return scm_call(SCM_SVC_BOOT, SCM_BOOT_ADDR,
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
diff --git a/arch/arm/mach-qcom/scm-boot.h b/arch/arm/mach-qcom/scm-boot.h
index 02b445c..97dbf58 100644
--- a/arch/arm/mach-qcom/scm-boot.h
+++ b/arch/arm/mach-qcom/scm-boot.h
@@ -1,4 +1,5 @@
 /* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ * Copyright (c) 2014, Linaro Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -9,6 +10,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
+
 #ifndef __MACH_SCM_BOOT_H
 #define __MACH_SCM_BOOT_H
 
@@ -16,11 +18,8 @@
 #define SCM_FLAG_COLDBOOT_CPU1		0x01
 #define SCM_FLAG_COLDBOOT_CPU2		0x08
 #define SCM_FLAG_COLDBOOT_CPU3		0x20
-#define SCM_FLAG_WARMBOOT_CPU0		0x04
-#define SCM_FLAG_WARMBOOT_CPU1		0x02
-#define SCM_FLAG_WARMBOOT_CPU2		0x10
-#define SCM_FLAG_WARMBOOT_CPU3		0x40
 
 int scm_set_boot_addr(phys_addr_t addr, int flags);
+int scm_set_warm_boot_addr(void *entry, int cpu);
 
 #endif
-- 
2.1.0

