From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 1/1] thermal: add a warning for temperature emulation feature
Date: Tue, 26 Mar 2013 17:38:34 -0400
Message-ID: <1364333914-32586-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44068 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab3CZVi4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Mar 2013 17:38:56 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

Because this feature is for debuging purposes, it is highly
recommended to do not enable this on production systems.
This patch adds warnings for system integrators, so that
people are aware of this potential security issue.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 Documentation/thermal/sysfs-api.txt |    4 ++++
 drivers/thermal/Kconfig             |    5 +++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index a9abb84..0a7d6df 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -265,6 +265,10 @@ emul_temp
 	Unit: millidegree Celsius
 	WO, Optional
 
+	  WARNING: Be careful while enabling this option on production systems,
+	  because userland can easily disable the thermal policy by simply
+	  flooding this sysfs node with low temperature values.
+
 *****************************
 * Cooling device attributes *
 *****************************
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index a764f16..004e5f7 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -80,12 +80,17 @@ config CPU_THERMAL
 
 config THERMAL_EMULATION
 	bool "Thermal emulation mode support"
+	default false
 	help
 	  Enable this option to make a emul_temp sysfs node in thermal zone
 	  directory to support temperature emulation. With emulation sysfs node,
 	  user can manually input temperature and test the different trip
 	  threshold behaviour for simulation purpose.
 
+	  WARNING: Be careful while enabling this option on production systems,
+	  because userland can easily disable the thermal policy by simply
+	  flooding this sysfs node with low temperature values.
+
 config SPEAR_THERMAL
 	bool "SPEAr thermal sensor driver"
 	depends on PLAT_SPEAR
-- 
1.7.7.1.488.ge8e1c

