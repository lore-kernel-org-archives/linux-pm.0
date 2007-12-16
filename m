From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] Suspend: Add config option to disable the freezer if architecture wants that
Date: Mon, 17 Dec 2007 00:30:29 +0100
Message-ID: <200712170030.30578.rjw@sisk.pl>
References: <200712162346.10241.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200712162346.10241.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

From: Johannes Berg <johannes@sipsolutions.net>

This patch makes the freezer optional for suspend to allow the
system to work (or not work) like the original PMU suspend.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
In a quick test, playing sound across suspend failed to work,
it usually works when the freezer is enabled (unless you use
gstreamer.)

 arch/powerpc/Kconfig |    4 ++++
 kernel/power/Kconfig |   11 +++++++++++
 kernel/power/main.c  |    6 +++---
 kernel/power/power.h |   22 ++++++++++++++++++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -176,7 +176,7 @@ static int suspend_prepare(void)
 
 	pm_prepare_console();
 
-	if (freeze_processes()) {
+	if (suspend_freeze_processes()) {
 		error = -EAGAIN;
 		goto Thaw;
 	}
@@ -194,7 +194,7 @@ static int suspend_prepare(void)
 		return 0;
 
  Thaw:
-	thaw_processes();
+	suspend_thaw_processes();
 	pm_restore_console();
  Finish:
 	pm_notifier_call_chain(PM_POST_SUSPEND);
@@ -300,7 +300,7 @@ int suspend_devices_and_enter(suspend_st
  */
 static void suspend_finish(void)
 {
-	thaw_processes();
+	suspend_thaw_processes();
 	pm_restore_console();
 	pm_notifier_call_chain(PM_POST_SUSPEND);
 }
Index: linux-2.6/kernel/power/Kconfig
===================================================================
--- linux-2.6.orig/kernel/power/Kconfig
+++ linux-2.6/kernel/power/Kconfig
@@ -104,6 +104,17 @@ config SUSPEND
 	  powered and thus its contents are preserved, such as the
 	  suspend-to-RAM state (e.g. the ACPI S3 state).
 
+config SUSPEND_FREEZER
+	bool "Enable freezer for suspend to RAM/standby" \
+		if ARCH_WANTS_FREEZER_CONTROL || BROKEN
+	depends on SUSPEND
+	default y
+	help
+	  This allows you to turn off the freezer for suspend. If this is
+	  done, no tasks are frozen for suspend to RAM/standby.
+
+	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
+
 config HIBERNATION
 	bool "Hibernation (aka 'suspend to disk')"
 	depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
@@ -384,6 +384,10 @@ config CMDLINE
 	  most cases you will need to specify the root device here.
 
 if !44x || BROKEN
+config ARCH_WANTS_FREEZER_CONTROL
+	def_bool y
+	depends on ADB_PMU
+
 source kernel/power/Kconfig
 endif
 
Index: linux-2.6/kernel/power/power.h
===================================================================
--- linux-2.6.orig/kernel/power/power.h
+++ linux-2.6/kernel/power/power.h
@@ -1,6 +1,7 @@
 #include <linux/suspend.h>
 #include <linux/suspend_ioctls.h>
 #include <linux/utsname.h>
+#include <linux/freezer.h>
 
 struct swsusp_info {
 	struct new_utsname	uts;
@@ -205,3 +206,24 @@ enum {
 #define TEST_MAX	(__TEST_AFTER_LAST - 1)
 
 extern int pm_test_level;
+
+#ifdef CONFIG_SUSPEND_FREEZER
+static inline int suspend_freeze_processes(void)
+{
+	return freeze_processes();
+}
+
+static inline void suspend_thaw_processes(void)
+{
+	thaw_processes();
+}
+#else
+static inline int suspend_freeze_processes(void)
+{
+	return 0;
+}
+
+static inline void suspend_thaw_processes(void)
+{
+}
+#endif
