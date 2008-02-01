From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/37] Hibernation: Clean up Kconfig (V2)
Date: Thu, 31 Jan 2008 23:36:53 -0500
Message-ID: <03f5cd73a5b5b30f6f3bcf8d68b3b79afb8cb880.1201840183.git.len.brown__48407.8143061653$1201843119$gmane$org@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
In-Reply-To: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Pavel Machek <pavel@suse.cz>, Johannes Berg <johannes@sipsolutions.net>
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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/powerpc/Kconfig |   14 ++++++++++++--
 arch/x86/Kconfig     |    4 ++++
 kernel/power/Kconfig |   18 +++---------------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9c44af3..68f0cf7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -151,9 +151,19 @@ config DEFAULT_UIMAGE
 config REDBOOT
 	bool
 
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
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 65b4491..9c511dd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -109,6 +109,10 @@ config ARCH_SUPPORTS_OPROFILE
 
 select HAVE_KVM
 
+config ARCH_HIBERNATION_POSSIBLE
+	def_bool y
+	depends on !SMP || !X86_VOYAGER
+
 config ZONE_DMA32
 	bool
 	default X86_64
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 06a08f7..fd76d54 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
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
-- 
1.5.4.rc5.16.gc0279
