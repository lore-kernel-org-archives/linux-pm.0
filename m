From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM: Remove CONFIG_PM_VERBOSE
Date: Sat, 14 May 2011 00:42:03 +0200
Message-ID: <201105140042.04064.rjw__23286.1184086234$1305326685$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Now that we have CONFIG_DYNAMIC_DEBUG there is no need for yet
another flag causing dev_dbg() and pr_debug() statements in the
core PM code to produce output.  Moreover, CONFIG_PM_VERBOSE
causes so much output to be generated that it's not really useful
and almost no one sets it.

References: https://bugzilla.kernel.org/show_bug.cgi?id=23182
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/sh/configs/apsh4ad0a_defconfig |    1 -
 arch/sh/configs/sdk7786_defconfig   |    1 -
 drivers/base/power/Makefile         |    3 +--
 kernel/power/Kconfig                |    6 ------
 4 files changed, 1 insertion(+), 10 deletions(-)

Index: linux-2.6/arch/sh/configs/apsh4ad0a_defconfig
===================================================================
--- linux-2.6.orig/arch/sh/configs/apsh4ad0a_defconfig
+++ linux-2.6/arch/sh/configs/apsh4ad0a_defconfig
@@ -48,7 +48,6 @@ CONFIG_PREEMPT=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
 CONFIG_PM_DEBUG=y
-CONFIG_PM_VERBOSE=y
 CONFIG_PM_RUNTIME=y
 CONFIG_CPU_IDLE=y
 CONFIG_NET=y
Index: linux-2.6/arch/sh/configs/sdk7786_defconfig
===================================================================
--- linux-2.6.orig/arch/sh/configs/sdk7786_defconfig
+++ linux-2.6/arch/sh/configs/sdk7786_defconfig
@@ -83,7 +83,6 @@ CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
 CONFIG_PM_DEBUG=y
-CONFIG_PM_VERBOSE=y
 CONFIG_PM_RUNTIME=y
 CONFIG_CPU_IDLE=y
 CONFIG_NET=y
Index: linux-2.6/drivers/base/power/Makefile
===================================================================
--- linux-2.6.orig/drivers/base/power/Makefile
+++ linux-2.6/drivers/base/power/Makefile
@@ -5,5 +5,4 @@ obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_OPP)	+= opp.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
 
-ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
-ccflags-$(CONFIG_PM_VERBOSE)   += -DDEBUG
+ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
\ No newline at end of file
Index: linux-2.6/kernel/power/Kconfig
===================================================================
--- linux-2.6.orig/kernel/power/Kconfig
+++ linux-2.6/kernel/power/Kconfig
@@ -125,12 +125,6 @@ config PM_DEBUG
 	code. This is helpful when debugging and reporting PM bugs, like
 	suspend support.
 
-config PM_VERBOSE
-	bool "Verbose Power Management debugging"
-	depends on PM_DEBUG
-	---help---
-	This option enables verbose messages from the Power Management code.
-
 config PM_ADVANCED_DEBUG
 	bool "Extra PM attributes in sysfs for low-level debugging/testing"
 	depends on PM_DEBUG
