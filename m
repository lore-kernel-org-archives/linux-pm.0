From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: kconfig: select THERMAL_WRITABLE_TRIPS for x86 thermal
Date: Sat,  1 Aug 2015 22:46:41 -0700
Message-ID: <1438494401-3984-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64141 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbbHBFq7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Aug 2015 01:46:59 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

After the commit "thermal: core: Add Kconfig option to enable writable trips",
user space tools like thermal daemon and Chrome OS DPTF thermal controller
can no longer receive async events for thermal thresholds. Since we need to
enable the new config introduced by above commit to allow writable trips.
Selecting CONFIG_THERMAL_WRITABLE_TRIPS for x86 thermal drivers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 118938e..0e3b576 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -275,6 +275,7 @@ config X86_PKG_TEMP_THERMAL
 	tristate "X86 package temperature thermal driver"
 	depends on X86_THERMAL_VECTOR
 	select THERMAL_GOV_USER_SPACE
+	select THERMAL_WRITABLE_TRIPS
 	default m
 	help
 	  Enable this to register CPU digital sensor for package temperature as
@@ -296,6 +297,7 @@ config INTEL_SOC_DTS_THERMAL
 	tristate "Intel SoCs DTS thermal driver"
 	depends on X86
 	select INTEL_SOC_DTS_IOSF_CORE
+	select THERMAL_WRITABLE_TRIPS
 	help
 	  Enable this to register Intel SoCs (e.g. Bay Trail) platform digital
 	  temperature sensor (DTS). These SoCs have two additional DTSs in
@@ -322,6 +324,7 @@ config INT340X_THERMAL
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
 	select INTEL_SOC_DTS_IOSF_CORE
+	select THERMAL_WRITABLE_TRIPS
 	help
 	  Newer laptops and tablets that use ACPI may have thermal sensors and
 	  other devices with thermal control capabilities outside the core
-- 
2.4.3

