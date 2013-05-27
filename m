From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle: improve governor Kconfig options
Date: Mon, 27 May 2013 23:00:58 +0200
Message-ID: <1369688458-9114-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:49498 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362Ab3E0VBD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2013 17:01:03 -0400
Received: by mail-wi0-f175.google.com with SMTP id hn14so1909728wib.2
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2013 14:01:01 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org

Each governor is suitable for different kernel configurations: the menu
governor suits better for a tickless system, while the ladder governor fits
better for a periodic timer tick system.

The Kconfig does not allow to [un]select a governor, thus both are compiled in
the kernel but the init order makes the menu governor to be the last one to be
registered, so becoming the default. The only way to switch back to the ladder
governor is to enable the sysfs governor switch in the kernel command line.

Because it seems nobody complained about this, the menu governor is used by
default most of the time on the system, having both governors is not really
necessary on a tickless system but there isn't a config option to disable one
or another governor.

Create a submenu for cpuidle and add a label for each governor, so we can see
the option in the menu config and enable/disable it.

The governors will be enabled depending on the CONFIG_NO_HZ option:
 - If CONFIG_NO_HZ is set, then the menu governor is selected and the ladder
   governor is optional, defaulting to 'no'
 - If CONFIG_NO_HZ is not set, then the ladder governor is selected and the
   menu governor is optional, defaulting to 'no'

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/Kconfig |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c4cc27e..90c2f39 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -1,7 +1,9 @@
 
-config CPU_IDLE
+menuconfig CPU_IDLE
 	bool "CPU idle PM support"
 	default y if ACPI || PPC_PSERIES
+	select CPU_IDLE_GOV_LADDER if (!NO_HZ && !NO_HZ_IDLE)
+	select CPU_IDLE_GOV_MENU if (NO_HZ || NO_HZ_IDLE)
 	help
 	  CPU idle is a generic framework for supporting software-controlled
 	  idle processor power management.  It includes modular cross-platform
@@ -9,9 +11,10 @@ config CPU_IDLE
 
 	  If you're using an ACPI-enabled platform, you should say Y here.
 
+if CPU_IDLE
+
 config CPU_IDLE_MULTIPLE_DRIVERS
         bool "Support multiple cpuidle drivers"
-        depends on CPU_IDLE
         default n
         help
          Allows the cpuidle framework to use different drivers for each CPU.
@@ -19,24 +22,19 @@ config CPU_IDLE_MULTIPLE_DRIVERS
          states. If unsure say N.
 
 config CPU_IDLE_GOV_LADDER
-	bool
-	depends on CPU_IDLE
-	default y
+	bool "Ladder governor (for periodic timer tick)"
+	default n if (NO_HZ || NO_HZ_IDLE)
 
 config CPU_IDLE_GOV_MENU
-	bool
-	depends on CPU_IDLE && NO_HZ
-	default y
+	bool "Menu governor (for tickless system)"
+	default n if (!NO_HZ && !NO_HZ_IDLE)
 
 config ARCH_NEEDS_CPU_IDLE_COUPLED
 	def_bool n
 
-if CPU_IDLE
-
 config CPU_IDLE_CALXEDA
 	bool "CPU Idle Driver for Calxeda processors"
 	depends on ARCH_HIGHBANK
 	help
 	  Select this to enable cpuidle on Calxeda processors.
-
 endif
-- 
1.7.9.5

