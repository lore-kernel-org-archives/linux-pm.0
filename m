From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpuidle: move ARCH_NEEDS_CPU_IDLE_COUPLED Kconfig option
Date: Wed, 05 Jun 2013 14:38:30 +0200
Message-ID: <1460854.rT4b7LefMM@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62130 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab3FEMi6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2013 08:38:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org

There is no reason why ARCH_NEEDS_CPU_IDLE_COUPLED needs to be
hidden inside of "if CPU_IDLE", since it is a silent option.
Moving it outside lets platforms select this symbol unconditionally,
which avoid a warning from the ARM omap2plus_defconfig build:

warning: (ARCH_OMAP4 && ARCH_TEGRA_2x_SOC) selects
	ARCH_NEEDS_CPU_IDLE_COUPLED which has unmet direct
	dependencies (CPU_IDLE)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index f4511e6..2caddb0 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -29,9 +29,6 @@ config CPU_IDLE_GOV_MENU
 	bool "Menu governor (for tickless system)"
 	default y
 
-config ARCH_NEEDS_CPU_IDLE_COUPLED
-	def_bool n
-
 config CPU_IDLE_CALXEDA
 	bool "CPU Idle Driver for Calxeda processors"
 	depends on ARCH_HIGHBANK
@@ -39,3 +36,6 @@ config CPU_IDLE_CALXEDA
 	help
 	  Select this to enable cpuidle on Calxeda processors.
 endif
+
+config ARCH_NEEDS_CPU_IDLE_COUPLED
+	def_bool n

