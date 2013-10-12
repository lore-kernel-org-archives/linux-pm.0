From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/2] ARM: at91: cpuidle: Move driver to drivers/cpuidle
Date: Sat, 12 Oct 2013 17:51:39 +0200
Message-ID: <1381593099-1184-2-git-send-email-daniel.lezcano@linaro.org>
References: <1381593099-1184-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36452 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab3JLPvn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 12 Oct 2013 11:51:43 -0400
Received: by mail-wi0-f181.google.com with SMTP id l12so1995843wiv.14
        for <linux-pm@vger.kernel.org>; Sat, 12 Oct 2013 08:51:42 -0700 (PDT)
In-Reply-To: <1381593099-1184-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com
Cc: linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

As the cpuidle driver code has no more the dependency with the pm code, the
'standby' callback being passed as a parameter to the device's platform data,
we can move the cpuidle driver in the drivers/cpuidle directory.

Tested-on usb-a9263 (at91sam9263)

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/Makefile                        |    1 -
 drivers/cpuidle/Kconfig.arm                        |    6 ++++++
 drivers/cpuidle/Makefile                           |    1 +
 .../cpuidle.c => drivers/cpuidle/cpuidle-at91.c    |    0
 4 files changed, 7 insertions(+), 1 deletion(-)
 rename arch/arm/mach-at91/cpuidle.c => drivers/cpuidle/cpuidle-at91.c (100%)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 3b0a953..c1b7370 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -98,7 +98,6 @@ obj-y				+= leds.o
 # Power Management
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_AT91_SLOW_CLOCK)	+= pm_slowclock.o
-obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
 
 ifeq ($(CONFIG_PM_DEBUG),y)
 CFLAGS_pm.o += -DDEBUG
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 8e36603..edecfc8 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -27,6 +27,12 @@ config ARM_U8500_CPUIDLE
 	help
 	  Select this to enable cpuidle for ST-E u8500 processors
 
+config ARM_AT91_CPUIDLE
+        bool "Cpu Idle Driver for the AT91 processors"
+	depends on ARCH_AT91
+	help
+	  Select this to enable cpuidle for AT91 processors
+
 config CPU_IDLE_BIG_LITTLE
 	bool "Support for ARM big.LITTLE processors"
 	depends on ARCH_VEXPRESS_TC2_PM
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index cea5ef5..60c4ae5 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -11,4 +11,5 @@ obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
 obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
+obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 obj-$(CONFIG_CPU_IDLE_BIG_LITTLE)	+= cpuidle-big_little.o
diff --git a/arch/arm/mach-at91/cpuidle.c b/drivers/cpuidle/cpuidle-at91.c
similarity index 100%
rename from arch/arm/mach-at91/cpuidle.c
rename to drivers/cpuidle/cpuidle-at91.c
-- 
1.7.9.5

