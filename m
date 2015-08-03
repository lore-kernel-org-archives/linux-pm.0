From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] thermal: kconfig: select THERMAL_WRITABLE_TRIPS for x86 thermal
Date: Mon,  3 Aug 2015 04:13:16 -0700
Message-ID: <1438600396-3482-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1438600396-3482-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:50806 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683AbbHCSNq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Aug 2015 14:13:46 -0400
In-Reply-To: <1438600396-3482-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

After the commit "thermal: core: Add Kconfig option to enable writable
trips", by default the trips are read only. This cause user space thermal
controllers to poll for temperature as they can't set temperature
thresholds for getting a notification via uevents. These programs use RW
trip in a zone to register thresholds. Since we need to enable the new
config introduced by above commit to allow writable trips, selecting
CONFIG_THERMAL_WRITABLE_TRIP for x86 thermal drivers.

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

