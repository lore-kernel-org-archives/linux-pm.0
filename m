From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 16/34] Thermal: Provide option to choose default thermal governor
Date: Sun,  2 Dec 2012 22:44:50 +0800
Message-ID: <1354459508-3707-16-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:33009 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814Ab2LBOpi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:38 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch provides option to choose the default thermal
governor. If no option is provided, the step_wise
governor is selected by default.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/Kconfig |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index f679eea..266c15e 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -73,3 +73,34 @@ config USER_SPACE
 	depends on THERMAL
 	help
 	  Enable this to let the user space manage the platform thermals.
+
+choice
+	prompt "Default Thermal governor"
+	depends on THERMAL
+	default THERMAL_DEFAULT_GOV_STEP_WISE
+	help
+	  This option sets which thermal governor shall be loaded at
+	  startup. If in doubt, select 'step_wise'.
+
+config THERMAL_DEFAULT_GOV_STEP_WISE
+	bool "step_wise"
+	select STEP_WISE
+	help
+	  Use the step_wise governor as default. This throttles the
+	  devices one step at a time.
+
+config THERMAL_DEFAULT_GOV_FAIR_SHARE
+	bool "fair_share"
+	select FAIR_SHARE
+	help
+	  Use the fair_share governor as default. This throttles the
+	  devices based on their 'contribution' to a zone. The
+	  contribution should be provided through platform data.
+
+config THERMAL_DEFAULT_GOV_USER_SPACE
+	bool "user_space"
+	select USER_SPACE
+	help
+	  Select this if you want to let the user space manage the
+	  platform thermals.
+endchoice
-- 
1.7.7.6

