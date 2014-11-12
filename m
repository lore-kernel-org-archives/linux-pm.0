From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Remove architecture specific menu entries
Date: Wed, 12 Nov 2014 09:40:43 +0530
Message-ID: <92d6fb45a43b8d800cbcdf690bbf6f8e4713b95e.1415765396.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:55236 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbaKLELD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Nov 2014 23:11:03 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so11424712pdb.11
        for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2014 20:11:03 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, scottwood@freescale.com, Yuantian.Tang@freescale.com, Viresh Kumar <viresh.kumar@linaro.org>

CPUFreq driver's Kconfig entries are added in Kconfig.<arch> files and they are
all included from the main Kconfig file using a menu entry. This creates another
level of (unnecessary) hierarchy within the menuconfig entries.

The problem occurs when there are drivers usable across architectures. Either
their config entry is duplicated in all the supported architectures or is put
into the main Kconfig entry. With the later one, we have menuconfig entries for
drivers at two levels then.

Fix these issues by getting rid of another level of menuconfig entries and
populate all drivers within the main cpufreq menu.

Reported-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Suggested-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig | 48 +++++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 3489f8f..a24d678 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -196,19 +196,19 @@ config CPUFREQ_DT
 
 	  If in doubt, say N.
 
-menu "x86 CPU frequency scaling drivers"
-depends on X86
+if X86
 source "drivers/cpufreq/Kconfig.x86"
-endmenu
+endif
 
-menu "ARM CPU frequency scaling drivers"
-depends on ARM || ARM64
+if ARM || ARM64
 source "drivers/cpufreq/Kconfig.arm"
-endmenu
+endif
 
-menu "AVR32 CPU frequency scaling drivers"
-depends on AVR32
+if PPC32 || PPC64
+source "drivers/cpufreq/Kconfig.powerpc"
+endif
 
+if AVR32
 config AVR32_AT32AP_CPUFREQ
 	bool "CPU frequency driver for AT32AP"
 	depends on PLATFORM_AT32AP
@@ -216,12 +216,9 @@ config AVR32_AT32AP_CPUFREQ
 	help
 	  This enables the CPU frequency driver for AT32AP processors.
 	  If in doubt, say N.
+endif
 
-endmenu
-
-menu "CPUFreq processor drivers"
-depends on IA64
-
+if IA64
 config IA64_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
 	depends on ACPI_PROCESSOR
@@ -232,12 +229,9 @@ config IA64_ACPI_CPUFREQ
 	For details, take a look at <file:Documentation/cpu-freq/>.
 
 	If in doubt, say N.
+endif
 
-endmenu
-
-menu "MIPS CPUFreq processor drivers"
-depends on MIPS
-
+if MIPS
 config LOONGSON2_CPUFREQ
 	tristate "Loongson2 CPUFreq Driver"
 	help
@@ -249,16 +243,9 @@ config LOONGSON2_CPUFREQ
 	  For details, take a look at <file:Documentation/cpu-freq/>.
 
 	  If in doubt, say N.
+endif
 
-endmenu
-
-menu "PowerPC CPU frequency scaling drivers"
-depends on PPC32 || PPC64
-source "drivers/cpufreq/Kconfig.powerpc"
-endmenu
-
-menu "SPARC CPU frequency scaling drivers"
-depends on SPARC64
+if SPARC64
 config SPARC_US3_CPUFREQ
 	tristate "UltraSPARC-III CPU Frequency driver"
 	help
@@ -276,10 +263,9 @@ config SPARC_US2E_CPUFREQ
 	  For details, take a look at <file:Documentation/cpu-freq>.
 
 	  If in doubt, say N.
-endmenu
+endif
 
-menu "SH CPU Frequency scaling"
-depends on SUPERH
+if SUPERH
 config SH_CPU_FREQ
 	tristate "SuperH CPU Frequency driver"
 	help
@@ -293,7 +279,7 @@ config SH_CPU_FREQ
 	  For details, take a look at <file:Documentation/cpu-freq>.
 
 	  If unsure, say N.
-endmenu
+endif
 
 endif
 endmenu
-- 
2.0.3.693.g996b0fd

