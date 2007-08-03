From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM: Fix dependencies of CONFIG_SUSPEND and
	CONFIG_HIBERNATION
Date: Fri, 3 Aug 2007 23:59:36 +0200
Message-ID: <200708032359.37677.rjw__10267.2887071551$1186177876$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Dependencies of CONFIG_SUSPEND and CONFIG_HIBERNATION introduced by commit
296699de6bdc717189a331ab6bbe90e05c94db06 "Introduce CONFIG_SUSPEND for
suspend-to-Ram and standby" are incorrect, as they don't cover the facts that
(1) not all architectures support suspend and (2) SMP hibernation is only
possible on X86 and PPC64 (if PPC64_SWSUSP is set).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/Kconfig |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6/kernel/power/Kconfig
===================================================================
--- linux-2.6.orig/kernel/power/Kconfig	2007-07-30 07:58:48.000000000 +0200
+++ linux-2.6/kernel/power/Kconfig	2007-08-03 23:29:57.000000000 +0200
@@ -74,7 +74,8 @@ config PM_TRACE
 
 config SUSPEND_SMP_POSSIBLE
 	bool
-	depends on (X86 && !X86_VOYAGER) || (PPC64 && (PPC_PSERIES || PPC_PMAC))
+	depends on (X86 && !X86_VOYAGER) \
+		   || (PPC64 && (PPC_PSERIES || PPC_PMAC)) || ARM
 	depends on SMP
 	default y
 
@@ -92,7 +93,8 @@ config PM_SLEEP
 config SUSPEND
 	bool "Suspend to RAM and standby"
 	depends on PM
-	depends on !SMP || SUSPEND_SMP_POSSIBLE
+	depends on SUSPEND_SMP_POSSIBLE || ((BLACKFIN || MIPS || SUPERH || FRV \
+		    || (PPC32 && PPC_MPC52xx)) && !SMP)
 	default y
 	---help---
 	  Allow the system to enter sleep states in which main memory is
@@ -102,7 +104,8 @@ config SUSPEND
 config HIBERNATION
 	bool "Hibernation (aka 'suspend to disk')"
 	depends on PM && SWAP
-	depends on ((X86 || PPC64_SWSUSP || FRV || PPC32) && !SMP) || SUSPEND_SMP_POSSIBLE
+	depends on ((X86 || PPC64_SWSUSP || FRV || PPC32) && !SMP) \
+		   || ((X86 || PPC64_SWSUSP) && SUSPEND_SMP_POSSIBLE)
 	---help---
 	  Enable the suspend to disk (STD) functionality, which is usually
 	  called "hibernation" in user interfaces.  STD checkpoints the
