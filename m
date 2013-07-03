From: kpark3469@gmail.com
Subject: [PATCH] cpuidle: Add Kconfig.arm and move calxeda and kirkwood
Date: Wed,  3 Jul 2013 14:26:39 +0900
Message-ID: <1372829199-27218-1-git-send-email-kpark3469@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:46335 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab3GCF0w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2013 01:26:52 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so14478192ieb.16
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2013 22:26:51 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: keun-o.park@windriver.com, rjw@sisk.pl

From: Sahara <keun-o.park@windriver.com>

This patch adds Kconfig.arm for cpuidle drivers for ARM. And, this
also moves calxeda and kirkwood to Kconfig.arm. Like cpufreq menu,
"CPU Idle" menu is added to drivers/cpuidle/Kconfig.

Signed-off-by: Sahara <keun-o.park@windriver.com>
---
 drivers/cpuidle/Kconfig     |   11 ++++++-----
 drivers/cpuidle/Kconfig.arm |   15 +++++++++++++++
 drivers/cpuidle/Makefile    |    6 ++++--
 3 files changed, 25 insertions(+), 7 deletions(-)
 create mode 100644 drivers/cpuidle/Kconfig.arm

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c4cc27e..1f16116 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -1,3 +1,4 @@
+menu "CPU Idle"
 
 config CPU_IDLE
 	bool "CPU idle PM support"
@@ -33,10 +34,10 @@ config ARCH_NEEDS_CPU_IDLE_COUPLED
 
 if CPU_IDLE
 
-config CPU_IDLE_CALXEDA
-	bool "CPU Idle Driver for Calxeda processors"
-	depends on ARCH_HIGHBANK
-	help
-	  Select this to enable cpuidle on Calxeda processors.
+menu "ARM CPU Idle Drivers"
+depends on ARM
+source "drivers/cpuidle/Kconfig.arm"
+endmenu
 
 endif
+endmenu
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
new file mode 100644
index 0000000..d335dd8
--- /dev/null
+++ b/drivers/cpuidle/Kconfig.arm
@@ -0,0 +1,15 @@
+#
+# ARM CPU Idle drivers
+#
+
+config ARM_HIGHBANK_CPUIDLE
+	bool "CPU Idle Driver for Calxeda processors"
+	depends on ARCH_HIGHBANK
+	help
+	  Select this to enable cpuidle on Calxeda processors.
+
+config ARM_KIRKWOOD_CPUIDLE
+	bool "CPU Idle Driver for Marvell Kirkwood SoCs"
+	depends on ARCH_KIRKWOOD
+	help
+	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 0d8bd55..1d7ba91 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -5,5 +5,7 @@
 obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 
-obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
-obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
+##################################################################################
+# ARM SoC drivers
+obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE) += cpuidle-calxeda.o
+obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE) += cpuidle-kirkwood.o
-- 
1.7.1

