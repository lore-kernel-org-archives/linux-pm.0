From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH] cpufreq: scpi: Add dependency on SCPI clk driver
Date: Tue, 17 Nov 2015 18:14:19 +0000
Message-ID: <1447784059-22769-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:57039 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753236AbbKQSYe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 13:24:34 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sudeep.holla@arm.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arnd@arndb.de, Punit Agrawal <punit.agrawal@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

The SCPI clk driver registers the virtual cpufreq device that kicks off
initialisation of the SCPI cpufreq driver. Make the dependendency
explicit in Kconfig.

Fixes: 8def31034d03 ("cpufreq: arm_big_little: add SCPI interface driver")
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1582c1c..dadfdd4 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -201,7 +201,7 @@ config ARM_SA1110_CPUFREQ
 
 config ARM_SCPI_CPUFREQ
         tristate "SCPI based CPUfreq driver"
-	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL
+	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
         help
 	  This adds the CPUfreq driver support for ARM big.LITTLE platforms
 	  using SCPI protocol for CPU power management.
-- 
2.6.2

