From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] hibernation: clean up Kconfig
Date: Tue, 04 Dec 2007 14:57:08 +0100
Message-ID: <1196776628.6060.57.camel@johannes.berg>
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

This cleans up the hibernation Kconfig and removes the need to
declare centrally which architectures support hibernation. All
architectures that currently support hibernation are modified
accordingly.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: Paul Mackerras <paulus@samba.org>
Cc: linux-pm@lists.linux-foundation.org
---
Rafael, does the x86 bit look ok to you? If so, I'll send to Andrew.

 arch/powerpc/Kconfig |   14 ++++++++++++--
 arch/x86/Kconfig     |    6 +++---
 kernel/power/Kconfig |   18 +++---------------
 3 files changed, 18 insertions(+), 20 deletions(-)

--- everything.orig/arch/powerpc/Kconfig	2007-12-04 14:52:29.536409993 +0100
+++ everything/arch/powerpc/Kconfig	2007-12-04 14:55:01.686411513 +0100
@@ -140,9 +140,19 @@ config DEFAULT_UIMAGE
 	  Used to allow a board to specify it wants a uImage built by default
 	default n
 
-config PPC64_SWSUSP
+config HIBERNATE_32
 	bool
-	depends on PPC64 && (BROKEN || (PPC_PMAC64 && EXPERIMENTAL))
+	depends on (PPC_PMAC && !SMP) || BROKEN
+	default y
+
+config HIBERNATE_64
+	bool
+	depends on BROKEN || (PPC_PMAC64 && EXPERIMENTAL)
+	default y
+
+config ARCH_HIBERNATION_POSSIBLE
+	bool
+	depends on (PPC64 && HIBERNATE_64) || (PPC32 && HIBERNATE_32)
 	default y
 
 config PPC_DCR_NATIVE
--- everything.orig/kernel/power/Kconfig	2007-12-04 14:52:29.536409993 +0100
+++ everything/kernel/power/Kconfig	2007-12-04 14:55:01.756411892 +0100
@@ -63,7 +63,8 @@ config PM_TRACE
 
 config PM_SLEEP_SMP
 	bool
-	depends on SUSPEND_SMP_POSSIBLE || HIBERNATION_SMP_POSSIBLE
+	depends on SMP
+	depends on SUSPEND_SMP_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
 	depends on PM_SLEEP
 	select HOTPLUG_CPU
 	default y
@@ -108,22 +109,9 @@ config SUSPEND_FREEZER
 
 	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
 
-config HIBERNATION_UP_POSSIBLE
-	bool
-	depends on X86 || PPC64_SWSUSP || PPC32
-	depends on !SMP
-	default y
-
-config HIBERNATION_SMP_POSSIBLE
-	bool
-	depends on (X86 && !X86_VOYAGER) || PPC64_SWSUSP
-	depends on SMP
-	default y
-
 config HIBERNATION
 	bool "Hibernation (aka 'suspend to disk')"
-	depends on PM && SWAP
-	depends on HIBERNATION_UP_POSSIBLE || HIBERNATION_SMP_POSSIBLE
+	depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
 	---help---
 	  Enable the suspend to disk (STD) functionality, which is usually
 	  called "hibernation" in user interfaces.  STD checkpoints the
--- everything.orig/arch/x86/Kconfig	2007-12-04 14:52:14.626416667 +0100
+++ everything/arch/x86/Kconfig	2007-12-04 14:55:01.256411079 +0100
@@ -112,9 +112,9 @@ config GENERIC_TIME_VSYSCALL
 	bool
 	default X86_64
 
-
-
-
+config ARCH_HIBERNATION_POSSIBLE
+	def_bool y
+	depends on !SMP || !X86_VOYAGER
 
 config ZONE_DMA32
 	bool
