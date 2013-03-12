From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] cpuidle / kirkwood: remove redundant Kconfig option
Date: Tue, 12 Mar 2013 10:27:55 +0100
Message-ID: <1363080476-26555-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:33297 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231Ab3CLJ2A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Mar 2013 05:28:00 -0400
Received: by mail-we0-f176.google.com with SMTP id s43so4344072wey.21
        for <linux-pm@vger.kernel.org>; Tue, 12 Mar 2013 02:27:59 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org

When the CPU_IDLE and the ARCH_KIRKWOOD options are set it is
pointless to define a new option CPU_IDLE_KIRKWOOD because it
is redundant.

The Makefile drivers directory contains a condition to compile
the cpuidle drivers:

obj-$(CONFIG_CPU_IDLE)          += cpuidle/

Hence, if CPU_IDLE is not set we won't enter this directory.

This patch removes the useless Kconfig option and replaces the
condition in the Makefile by CONFIG_ARCH_KIRKWOOD.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/configs/kirkwood_defconfig |    1 -
 drivers/cpuidle/Kconfig             |    6 ------
 drivers/cpuidle/Makefile            |    2 +-
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 13482ea..93f3794 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -56,7 +56,6 @@ CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CPU_IDLE=y
-CONFIG_CPU_IDLE_KIRKWOOD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 071e2c3..c4cc27e 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -39,10 +39,4 @@ config CPU_IDLE_CALXEDA
 	help
 	  Select this to enable cpuidle on Calxeda processors.
 
-config CPU_IDLE_KIRKWOOD
-	bool "CPU Idle Driver for Kirkwood processors"
-	depends on ARCH_KIRKWOOD
-	help
-	  Select this to enable cpuidle on Kirkwood processors.
-
 endif
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 24c6e7d..0d8bd55 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -6,4 +6,4 @@ obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 
 obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
-obj-$(CONFIG_CPU_IDLE_KIRKWOOD) += cpuidle-kirkwood.o
+obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
-- 
1.7.9.5

