From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] thermal: fix INTEL_SOC_DTS_IOSF_CORE dependencies
Date: Fri, 21 Jul 2017 18:16:28 +0200
Message-ID: <20170721161704.3335851-1-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:65093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdGUQRT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2017 12:17:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

We get a Kconfig warning when selecting this without also enabling
CONFIG_PCI:

warning: (X86_INTEL_LPSS && INTEL_SOC_DTS_IOSF_CORE && SND_SST_IPC_ACPI && MMC_SDHCI_ACPI && PUNIT_ATOM_DEBUG) selects IOSF_MBI which has unmet direct dependencies (PCI)

This adds a new depedency.

Fixes: 3a2419f865a6 ("Thermal: Intel SoC: DTS thermal use common APIs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thermal/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index b5b5facb8747..ac2a53823576 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -342,7 +342,7 @@ config X86_PKG_TEMP_THERMAL
 
 config INTEL_SOC_DTS_IOSF_CORE
 	tristate
-	depends on X86
+	depends on X86 && PCI
 	select IOSF_MBI
 	help
 	  This is becoming a common feature for Intel SoCs to expose the additional
@@ -352,7 +352,7 @@ config INTEL_SOC_DTS_IOSF_CORE
 
 config INTEL_SOC_DTS_THERMAL
 	tristate "Intel SoCs DTS thermal driver"
-	depends on X86
+	depends on X86 && PCI
 	select INTEL_SOC_DTS_IOSF_CORE
 	select THERMAL_WRITABLE_TRIPS
 	help
-- 
2.9.0
