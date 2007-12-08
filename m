From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 9/9] Suspend: Clean up Kconfig (V2)
Date: Sat, 8 Dec 2007 02:14:00 +0100
Message-ID: <200712080214.01044.rjw__20121.2515974932$1197075462$gmane$org@sisk.pl>
References: <200712080201.40661.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712080201.40661.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

From: Johannes Berg <johannes@sipsolutions.net>

This cleans up the suspend Kconfig and removes the need to
declare centrally which architectures support suspend. All
architectures that currently support suspend are modified
accordingly.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: Russell King <rmk@arm.linux.org.uk>
Acked-by: Paul Mackerras <paulus@samba.org>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Cc: Pavel Machek <pavel@suse.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/Kconfig      |    3 +++
 arch/blackfin/Kconfig |    4 ++++
 arch/frv/Kconfig      |    5 +++++
 arch/mips/Kconfig     |    4 ++++
 arch/powerpc/Kconfig  |    4 ++++
 arch/sh/Kconfig       |    4 ++++
 arch/x86/Kconfig      |    4 ++++
 kernel/power/Kconfig  |   21 +++------------------
 8 files changed, 31 insertions(+), 18 deletions(-)

Index: linux-2.6/arch/x86/Kconfig
===================================================================
--- linux-2.6.orig/arch/x86/Kconfig
+++ linux-2.6/arch/x86/Kconfig
@@ -119,6 +119,10 @@ config ARCH_HIBERNATION_POSSIBLE
 	def_bool y
 	depends on !SMP || !X86_VOYAGER
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on !X86_VOYAGER
+
 config ZONE_DMA32
 	bool
 	default X86_64
Index: linux-2.6/kernel/power/Kconfig
===================================================================
--- linux-2.6.orig/kernel/power/Kconfig
+++ linux-2.6/kernel/power/Kconfig
@@ -85,7 +85,7 @@ config PM_TRACE_RTC
 config PM_SLEEP_SMP
 	bool
 	depends on SMP
-	depends on SUSPEND_SMP_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
+	depends on ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
 	depends on PM_SLEEP
 	select HOTPLUG_CPU
 	default y
@@ -95,29 +95,14 @@ config PM_SLEEP
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
 
 config HIBERNATION
 	bool "Hibernation (aka 'suspend to disk')"
Index: linux-2.6/arch/blackfin/Kconfig
===================================================================
--- linux-2.6.orig/arch/blackfin/Kconfig
+++ linux-2.6/arch/blackfin/Kconfig
@@ -925,6 +925,10 @@ endmenu
 menu "Power management options"
 source "kernel/power/Kconfig"
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on !SMP
+
 choice
 	prompt "Select PM Wakeup Event Source"
 	default PM_WAKEUP_GPIO_BY_SIC_IWR
Index: linux-2.6/arch/arm/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm/Kconfig
+++ linux-2.6/arch/arm/Kconfig
@@ -977,6 +977,9 @@ menu "Power management options"
 
 source "kernel/power/Kconfig"
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+
 endmenu
 
 source "net/Kconfig"
Index: linux-2.6/arch/mips/Kconfig
===================================================================
--- linux-2.6.orig/arch/mips/Kconfig
+++ linux-2.6/arch/mips/Kconfig
@@ -2046,6 +2046,10 @@ endmenu
 
 menu "Power management options"
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on !SMP
+
 source "kernel/power/Kconfig"
 
 endmenu
Index: linux-2.6/arch/sh/Kconfig
===================================================================
--- linux-2.6.orig/arch/sh/Kconfig
+++ linux-2.6/arch/sh/Kconfig
@@ -746,6 +746,10 @@ endmenu
 menu "Power management options (EXPERIMENTAL)"
 depends on EXPERIMENTAL && SYS_SUPPORTS_PM
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on !SMP
+
 source kernel/power/Kconfig
 
 endmenu
Index: linux-2.6/arch/frv/Kconfig
===================================================================
--- linux-2.6.orig/arch/frv/Kconfig
+++ linux-2.6/arch/frv/Kconfig
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
 
Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
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
