From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 8/9] Hibernation: Clean up Kconfig (V2)
Date: Sat, 8 Dec 2007 02:12:39 +0100
Message-ID: <200712080212.40440.rjw__8179.0805132643$1197075456$gmane$org@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Johannes Berg <johannes@sipsolutions.net>

This cleans up the hibernation Kconfig and removes the need to
declare centrally which architectures support hibernation. All
architectures that currently support hibernation are modified
accordingly.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: Paul Mackerras <paulus@samba.org>
Cc: Pavel Machek <pavel@suse.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/powerpc/Kconfig |   14 ++++++++++++--
 arch/x86/Kconfig     |    4 +++-
 kernel/power/Kconfig |   18 +++---------------
 3 files changed, 18 insertions(+), 18 deletions(-)

Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
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
Index: linux-2.6/kernel/power/Kconfig
===================================================================
--- linux-2.6.orig/kernel/power/Kconfig
+++ linux-2.6/kernel/power/Kconfig
@@ -84,7 +84,8 @@ config PM_TRACE_RTC
 
 config PM_SLEEP_SMP
 	bool
-	depends on SUSPEND_SMP_POSSIBLE || HIBERNATION_SMP_POSSIBLE
+	depends on SMP
+	depends on SUSPEND_SMP_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
 	depends on PM_SLEEP
 	select HOTPLUG_CPU
 	default y
@@ -118,22 +119,9 @@ config SUSPEND
 	  powered and thus its contents are preserved, such as the
 	  suspend-to-RAM state (i.e. the ACPI S3 state).
 
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
Index: linux-2.6/arch/x86/Kconfig
===================================================================
--- linux-2.6.orig/arch/x86/Kconfig
+++ linux-2.6/arch/x86/Kconfig
@@ -115,7 +115,9 @@ config GENERIC_TIME_VSYSCALL
 config ARCH_SUPPORTS_OPROFILE
 	bool
 	default y
-
+config ARCH_HIBERNATION_POSSIBLE
+	def_bool y
+	depends on !SMP || !X86_VOYAGER
 
 config ZONE_DMA32
 	bool
