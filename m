From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V2] cpuidle: improve governor Kconfig options
Date: Tue, 28 May 2013 17:51:54 +0200
Message-ID: <1369756314-20792-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:45614 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934575Ab3E1Pv7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2013 11:51:59 -0400
Received: by mail-we0-f170.google.com with SMTP id u59so5063024wes.1
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2013 08:51:58 -0700 (PDT)
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
   governor is optional, defaulting to 'yes'
 - If CONFIG_NO_HZ is not set, then the ladder governor is selected and the
   menu governor is optional, defaulting to 'yes'

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/Kconfig |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c4cc27e..e997f15 100644
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
+	bool "Ladder governor (for periodic timer tick)"
 	default y
 
 config CPU_IDLE_GOV_MENU
-	bool
-	depends on CPU_IDLE && NO_HZ
+	bool "Menu governor (for tickless system)"
 	default y
 
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

