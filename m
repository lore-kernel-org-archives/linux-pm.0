From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2] power: Fix unmet dependency on POWER_SUPPLY by POWER_RESET
 by uncoupling them
Date: Mon, 07 Dec 2015 12:45:12 +0900
Message-ID: <1449459912-29482-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:56213 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbbLGDp4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 6 Dec 2015 22:45:56 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: p.fedin@samsung.com, linux-samsung-soc@vger.kernel.org, arnd@arndb.de, olof@lixom.net, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Currently the reset/power off handlers (POWER_RESET) and Adaptive Voltage
Scaling class (POWER_AVS) are not built when POWER_SUPPLY is disabled.
The POWER_RESET is also not visible in drivers main section of config.

However they do not really depend on power supply so they can be built
always. The objects for power supply drivers already depend on
particular Kconfig symbols so there is no need for any changes in
drivers/power/Makefile.

This allows selecting POWER_RESET from main drivers config section and
fixes following build warning (encountered on ARM exynos defconfig when
POWER_SUPPLY is disabled manually):

warning: (ARCH_HISI && ARCH_INTEGRATOR && ARCH_EXYNOS && ARCH_VEXPRESS && REALVIEW_DT) selects POWER_RESET which has unmet direct dependencies (POWER_SUPPLY)
warning: (ARCH_EXYNOS) selects POWER_RESET_SYSCON which has unmet direct dependencies (POWER_SUPPLY && POWER_RESET && OF)
warning: (ARCH_EXYNOS) selects POWER_RESET_SYSCON_POWEROFF which has unmet direct dependencies (POWER_SUPPLY && POWER_RESET && OF)

Reported-by: Pavel Fedin <p.fedin@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes since v1:
1. Follow Sebastian's suggestion of changing drivers/power to obj-y.
   This makes patch 2/2 obsolete and everything (POWER_RESET +
   POWER_AVS) is fixed here.
---
 drivers/Makefile      | 2 +-
 drivers/power/Kconfig | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 795d0ca714bf..8f5d076baeb0 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -106,7 +106,7 @@ obj-y				+= i2c/ media/
 obj-$(CONFIG_PPS)		+= pps/
 obj-$(CONFIG_PTP_1588_CLOCK)	+= ptp/
 obj-$(CONFIG_W1)		+= w1/
-obj-$(CONFIG_POWER_SUPPLY)	+= power/
+obj-y				+= power/
 obj-$(CONFIG_HWMON)		+= hwmon/
 obj-$(CONFIG_THERMAL)		+= thermal/
 obj-$(CONFIG_WATCHDOG)		+= watchdog/
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
-- 
1.9.1

