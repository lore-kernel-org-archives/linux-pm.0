From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 28/34] drivers/thermal/Makefile refactor
Date: Sun,  2 Dec 2012 22:45:02 +0800
Message-ID: <1354459508-3707-28-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29043 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630Ab2LBOpw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:52 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/Makefile |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index e5f7974..0b6b048 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -3,10 +3,16 @@
 #
 
 obj-$(CONFIG_THERMAL)		+= thermal_sys.o
-obj-$(CONFIG_CPU_THERMAL)		+= cpu_cooling.o
-obj-$(CONFIG_SPEAR_THERMAL)		+= spear_thermal.o
+
+# governors
+obj-$(CONFIG_FAIR_SHARE)	+= fair_share.o
+obj-$(CONFIG_STEP_WISE)		+= step_wise.o
+obj-$(CONFIG_USER_SPACE)	+= user_space.o
+
+# cpufreq cooling
+obj-$(CONFIG_CPU_THERMAL)	+= cpu_cooling.o
+
+# platform thermal drivers
+obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
-obj-$(CONFIG_EXYNOS_THERMAL)		+= exynos_thermal.o
-obj-$(CONFIG_FAIR_SHARE)		+= fair_share.o
-obj-$(CONFIG_STEP_WISE)			+= step_wise.o
-obj-$(CONFIG_USER_SPACE)		+= user_space.o
+obj-$(CONFIG_EXYNOS_THERMAL)	+= exynos_thermal.o
-- 
1.7.7.6

