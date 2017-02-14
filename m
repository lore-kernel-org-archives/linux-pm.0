From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpufreq: cppc: add ACPI_PROCESSOR dependency
Date: Tue, 14 Feb 2017 22:19:18 +0100
Message-ID: <20170214211934.2663689-1-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:57001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752860AbdBNVTm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2017 16:19:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Without the Kconfig dependency, we can get this warning:

warning: ACPI_CPPC_CPUFREQ selects ACPI_CPPC_LIB which has unmet direct dependencies (ACPI && ACPI_PROCESSOR)

Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 6d87742fc5aa..74fa5c5904d3 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -268,7 +268,7 @@ config ARM_PXA2xx_CPUFREQ
 
 config ACPI_CPPC_CPUFREQ
 	tristate "CPUFreq driver based on the ACPI CPPC spec"
-	depends on ACPI
+	depends on ACPI_PROCESSOR
 	select ACPI_CPPC_LIB
 	default n
 	help
-- 
2.9.0

