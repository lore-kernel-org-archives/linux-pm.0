From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 1/2] power: Fix unmet dependency on POWER_SUPPLY by POWER_RESET
 by uncoupling them
Date: Wed, 02 Dec 2015 14:59:06 +0900
Message-ID: <1449035947-16758-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:8257 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbbLBF7Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2015 00:59:16 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Pavel Fedin <p.fedin@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Actually reset/power off handlers do not really depend on power supply.
Move the power reset out of power supply block so it will appear in main
drivers section. This fixes following build warning (encountered on ARM
exynos defconfig when POWER_SUPPLY is disabled manually):

warning: (ARCH_HISI && ARCH_INTEGRATOR && ARCH_EXYNOS && ARCH_VEXPRESS && REALVIEW_DT) selects POWER_RESET which has unmet direct dependencies (POWER_SUPPLY)
warning: (ARCH_EXYNOS) selects POWER_RESET_SYSCON which has unmet direct dependencies (POWER_SUPPLY && POWER_RESET && OF)
warning: (ARCH_EXYNOS) selects POWER_RESET_SYSCON_POWEROFF which has unmet direct dependencies (POWER_SUPPLY && POWER_RESET && OF)

Reported-by: Pavel Fedin <p.fedin@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/Makefile       | 1 +
 drivers/power/Kconfig  | 3 +--
 drivers/power/Makefile | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 795d0ca714bf..0ebb49d0e57e 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -106,6 +106,7 @@ obj-y				+= i2c/ media/
 obj-$(CONFIG_PPS)		+= pps/
 obj-$(CONFIG_PTP_1588_CLOCK)	+= ptp/
 obj-$(CONFIG_W1)		+= w1/
+obj-$(CONFIG_POWER_RESET)	+= power/reset/
 obj-$(CONFIG_POWER_SUPPLY)	+= power/
 obj-$(CONFIG_HWMON)		+= hwmon/
 obj-$(CONFIG_THERMAL)		+= thermal/
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 2f944d742ed4..c031f901b497 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -509,8 +509,7 @@ config AXP20X_POWER
 	  This driver provides support for the power supply features of
 	  AXP20x PMIC.
 
-source "drivers/power/reset/Kconfig"
-
 endif # POWER_SUPPLY
 
+source "drivers/power/reset/Kconfig"
 source "drivers/power/avs/Kconfig"
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index b656638f8b39..ac430b373f84 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -69,6 +69,5 @@ obj-$(CONFIG_POWER_AVS)		+= avs/
 obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
 obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
 obj-$(CONFIG_CHARGER_TPS65217)	+= tps65217_charger.o
-obj-$(CONFIG_POWER_RESET)	+= reset/
 obj-$(CONFIG_AXP288_FUEL_GAUGE) += axp288_fuel_gauge.o
 obj-$(CONFIG_AXP288_CHARGER)	+= axp288_charger.o
-- 
1.9.1

