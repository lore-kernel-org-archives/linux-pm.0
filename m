From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] suspend: clean up Kconfig
Date: Tue, 04 Dec 2007 14:58:27 +0100
Message-ID: <1196776707.6060.60.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This cleans up the suspend Kconfig and removes the need to
declare centrally which architectures support suspend. All
architectures that currently support suspend are modified
accordingly.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Russell King <rmk@arm.linux.org.uk>
Acked-by: Paul Mackerras <paulus@samba.org>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Cc: linux-pm@lists.linux-foundation.org
---
this comes with an updated x86 version.

 arch/arm/Kconfig      |    3 +++
 arch/blackfin/Kconfig |    4 ++++
 arch/frv/Kconfig      |    5 +++++
 arch/mips/Kconfig     |    4 ++++
 arch/powerpc/Kconfig  |    4 ++++
 arch/sh/Kconfig       |    4 ++++
 arch/x86/Kconfig      |    4 ++++
 kernel/power/Kconfig  |   21 +++------------------
 8 files changed, 31 insertions(+), 18 deletions(-)

--- everything.orig/arch/x86/Kconfig	2007-12-04 14:55:01.256411079 +0100
+++ everything/arch/x86/Kconfig	2007-12-04 14:55:34.806408366 +0100
@@ -116,6 +116,10 @@ config ARCH_HIBERNATION_POSSIBLE
 	def_bool y
 	depends on !SMP || !X86_VOYAGER
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on !X86_VOYAGER
+
 config ZONE_DMA32
 	bool
 	default X86_64
--- everything.orig/kernel/power/Kconfig	2007-12-04 14:55:01.756411892 +0100
+++ everything/kernel/power/Kconfig	2007-12-04 14:55:03.016421929 +0100
@@ -64,7 +64,7 @@ config PM_TRACE
 config PM_SLEEP_SMP
 	bool
 	depends on SMP
-	depends on SUSPEND_SMP_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
+	depends on ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
 	depends on PM_SLEEP
 	select HOTPLUG_CPU
 	default y
@@ -74,29 +74,14 @@ config PM_SLEEP
 	depends on SUSPEND || HIBERNATION
 	default y
 
-config SUSPEND_UP_POSSIBLE
-	bool
-	depends on (X86 && !X86_VOYAGER) || PPC || ARM || BLACKFIN || MIPS \
-		   || SUPERH || FRV
-	depends on !SMP
-	default y
-
-config SUSPEND_SMP_POSSIBLE
-	bool
-	depends on (X86 && !X86_VOYAGER) \
-		   || (PPC && (PPC_PSERIES || PPC_PMAC)) || ARM
-	depends on SMP
-	default y
-
 config SUSPEND
 	bool "Suspend to RAM and standby"
-	depends on PM
-	depends on SUSPEND_UP_POSSIBLE || SUSPEND_SMP_POSSIBLE
+	depends on PM && ARCH_SUSPEND_POSSIBLE
 	default y
 	---help---
 	  Allow the system to enter sleep states in which main memory is
 	  powered and thus its contents are preserved, such as the
-	  suspend-to-RAM state (i.e. the ACPI S3 state).
+	  suspend-to-RAM state (e.g. the ACPI S3 state).
 
 config SUSPEND_FREEZER
 	bool "Enable freezer for suspend to RAM/standby" \
--- everything.orig/arch/blackfin/Kconfig	2007-12-04 14:55:01.376411296 +0100
+++ everything/arch/blackfin/Kconfig	2007-12-04 14:55:03.016421929 +0100
@@ -1004,6 +1004,10 @@ endmenu
 menu "Power management options"
 source "kernel/power/Kconfig"
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on !SMP
+
 choice
 	prompt "Select PM Wakeup Event Source"
 	default PM_WAKEUP_GPIO_BY_SIC_IWR
--- everything.orig/arch/arm/Kconfig	2007-12-04 14:55:01.486409615 +0100
+++ everything/arch/arm/Kconfig	2007-12-04 14:55:03.026410645 +0100
@@ -977,6 +977,9 @@ menu "Power management options"
 
 source "kernel/power/Kconfig"
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+
 endmenu
 
 source "net/Kconfig"
--- everything.orig/arch/mips/Kconfig	2007-12-04 14:55:01.536412056 +0100
+++ everything/arch/mips/Kconfig	2007-12-04 14:55:03.026410645 +0100
@@ -2009,6 +2009,10 @@ endmenu
 
 menu "Power management options"
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on !SMP
+
 source "kernel/power/Kconfig"
 
 endmenu
--- everything.orig/arch/sh/Kconfig	2007-12-04 14:55:01.576429199 +0100
+++ everything/arch/sh/Kconfig	2007-12-04 14:55:03.026410645 +0100
@@ -746,6 +746,10 @@ endmenu
 menu "Power management options (EXPERIMENTAL)"
 depends on EXPERIMENTAL && SYS_SUPPORTS_PM
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on !SMP
+
 source kernel/power/Kconfig
 
 endmenu
--- everything.orig/arch/frv/Kconfig	2007-12-04 14:55:01.636409614 +0100
+++ everything/arch/frv/Kconfig	2007-12-04 14:55:03.026410645 +0100
@@ -357,6 +357,11 @@ source "drivers/pcmcia/Kconfig"
 #	  should probably wait a while.
 
 menu "Power management options"
+
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on !SMP
+
 source kernel/power/Kconfig
 endmenu
 
--- everything.orig/arch/powerpc/Kconfig	2007-12-04 14:55:01.686411513 +0100
+++ everything/arch/powerpc/Kconfig	2007-12-04 14:55:03.026410645 +0100
@@ -155,6 +155,10 @@ config ARCH_HIBERNATION_POSSIBLE
 	depends on (PPC64 && HIBERNATE_64) || (PPC32 && HIBERNATE_32)
 	default y
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200
+
 config PPC_DCR_NATIVE
 	bool
 	default n
