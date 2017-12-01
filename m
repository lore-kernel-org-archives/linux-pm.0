From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 2/6] cpufreq: ARM: sort the Kconfig menu
Date: Fri,  1 Dec 2017 12:25:04 +0100
Message-ID: <20171201112508.14121-3-gregory.clement@free-electrons.com>
References: <20171201112508.14121-1-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60973 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbdLALZ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Dec 2017 06:25:27 -0500
In-Reply-To: <20171201112508.14121-1-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Hua Jing <jinghua@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Evan Wang <xswang@marvell.com>

Group all the related big LITTLE configuration together and sort the
other entries in alphabetic order.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/cpufreq/Kconfig.arm | 82 ++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index bdce4488ded1..17625115c67f 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -2,6 +2,23 @@
 # ARM CPU Frequency scaling drivers
 #
 
+config ACPI_CPPC_CPUFREQ
+	tristate "CPUFreq driver based on the ACPI CPPC spec"
+	depends on ACPI_PROCESSOR
+	select ACPI_CPPC_LIB
+	default n
+	help
+	  This adds a CPUFreq driver which uses CPPC methods
+	  as described in the ACPIv5.1 spec. CPPC stands for
+	  Collaborative Processor Performance Controls. It
+	  is based on an abstract continuous scale of CPU
+	  performance values which allows the remote power
+	  processor to flexibly optimize for power and
+	  performance. CPPC relies on power management firmware
+	  support for its operation.
+
+	  If in doubt, say N.
+
 # big LITTLE core layer and glue drivers
 config ARM_BIG_LITTLE_CPUFREQ
 	tristate "Generic ARM big LITTLE CPUfreq driver"
@@ -12,6 +29,30 @@ config ARM_BIG_LITTLE_CPUFREQ
 	help
 	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
 
+config ARM_DT_BL_CPUFREQ
+	tristate "Generic probing via DT for ARM big LITTLE CPUfreq driver"
+	depends on ARM_BIG_LITTLE_CPUFREQ && OF
+	help
+	  This enables probing via DT for Generic CPUfreq driver for ARM
+	  big.LITTLE platform. This gets frequency tables from DT.
+
+config ARM_VEXPRESS_SPC_CPUFREQ
+        tristate "Versatile Express SPC based CPUfreq driver"
+	depends on ARM_BIG_LITTLE_CPUFREQ && ARCH_VEXPRESS_SPC
+        help
+          This add the CPUfreq driver support for Versatile Express
+	  big.LITTLE platforms using SPC for power management.
+
+config ARM_SCPI_CPUFREQ
+        tristate "SCPI based CPUfreq driver"
+	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
+        help
+	  This adds the CPUfreq driver support for ARM big.LITTLE platforms
+	  using SCPI protocol for CPU power management.
+
+	  This driver uses SCPI Message Protocol driver to interact with the
+	  firmware providing the CPU DVFS functionality.
+
 config ARM_BRCMSTB_AVS_CPUFREQ
 	tristate "Broadcom STB AVS CPUfreq driver"
 	depends on ARCH_BRCMSTB || COMPILE_TEST
@@ -33,20 +74,6 @@ config ARM_BRCMSTB_AVS_CPUFREQ_DEBUG
 
 	  If in doubt, say N.
 
-config ARM_DT_BL_CPUFREQ
-	tristate "Generic probing via DT for ARM big LITTLE CPUfreq driver"
-	depends on ARM_BIG_LITTLE_CPUFREQ && OF
-	help
-	  This enables probing via DT for Generic CPUfreq driver for ARM
-	  big.LITTLE platform. This gets frequency tables from DT.
-
-config ARM_VEXPRESS_SPC_CPUFREQ
-        tristate "Versatile Express SPC based CPUfreq driver"
-	depends on ARM_BIG_LITTLE_CPUFREQ && ARCH_VEXPRESS_SPC
-        help
-          This add the CPUfreq driver support for Versatile Express
-	  big.LITTLE platforms using SPC for power management.
-
 config ARM_EXYNOS5440_CPUFREQ
 	tristate "SAMSUNG EXYNOS5440"
 	depends on SOC_EXYNOS5440
@@ -205,16 +232,6 @@ config ARM_SA1100_CPUFREQ
 config ARM_SA1110_CPUFREQ
 	bool
 
-config ARM_SCPI_CPUFREQ
-        tristate "SCPI based CPUfreq driver"
-	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
-        help
-	  This adds the CPUfreq driver support for ARM big.LITTLE platforms
-	  using SCPI protocol for CPU power management.
-
-	  This driver uses SCPI Message Protocol driver to interact with the
-	  firmware providing the CPU DVFS functionality.
-
 config ARM_SPEAR_CPUFREQ
 	bool "SPEAr CPUFreq support"
 	depends on PLAT_SPEAR
@@ -275,20 +292,3 @@ config ARM_PXA2xx_CPUFREQ
 	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
 
 	  If in doubt, say N.
-
-config ACPI_CPPC_CPUFREQ
-	tristate "CPUFreq driver based on the ACPI CPPC spec"
-	depends on ACPI_PROCESSOR
-	select ACPI_CPPC_LIB
-	default n
-	help
-	  This adds a CPUFreq driver which uses CPPC methods
-	  as described in the ACPIv5.1 spec. CPPC stands for
-	  Collaborative Processor Performance Controls. It
-	  is based on an abstract continuous scale of CPU
-	  performance values which allows the remote power
-	  processor to flexibly optimize for power and
-	  performance. CPPC relies on power management firmware
-	  support for its operation.
-
-	  If in doubt, say N.
-- 
2.15.0
