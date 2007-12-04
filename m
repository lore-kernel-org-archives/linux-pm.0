From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] PM: make freezer optional for suspend
Date: Tue, 04 Dec 2007 15:02:13 +0100
Message-ID: <1196776933.6060.62.camel@johannes.berg>
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

This patch makes the freezer optional for suspend to allow the
system to work (or not work) like the original PMU suspend.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
In a quick test, playing sound across suspend failed to work,
it usually works when the freezer is enabled (unless you use
gstreamer.)

 arch/powerpc/Kconfig |    4 ++++
 kernel/power/Kconfig |   11 +++++++++++
 kernel/power/main.c  |    6 ++++++
 3 files changed, 21 insertions(+)

--- everything.orig/kernel/power/main.c	2007-12-04 14:59:03.126410862 +0100
+++ everything/kernel/power/main.c	2007-12-04 15:00:19.226410156 +0100
@@ -79,10 +79,12 @@ static int suspend_prepare(void)
 
 	pm_prepare_console();
 
+#ifdef CONFIG_SUSPEND_FREEZER
 	if (freeze_processes()) {
 		error = -EAGAIN;
 		goto Thaw;
 	}
+#endif
 
 	free_pages = global_page_state(NR_FREE_PAGES);
 	if (free_pages < FREE_PAGE_NUMBER) {
@@ -96,8 +98,10 @@ static int suspend_prepare(void)
 	if (!error)
 		return 0;
 
+#ifdef CONFIG_SUSPEND_FREEZER
  Thaw:
 	thaw_processes();
+#endif
 	pm_restore_console();
  Finish:
 	pm_notifier_call_chain(PM_POST_SUSPEND);
@@ -191,7 +195,9 @@ int suspend_devices_and_enter(suspend_st
  */
 static void suspend_finish(void)
 {
+#ifdef CONFIG_SUSPEND_FREEZER
 	thaw_processes();
+#endif
 	pm_restore_console();
 	pm_notifier_call_chain(PM_POST_SUSPEND);
 }
--- everything.orig/kernel/power/Kconfig	2007-12-04 14:59:03.176410807 +0100
+++ everything/kernel/power/Kconfig	2007-12-04 15:00:19.226410156 +0100
@@ -97,6 +97,17 @@ config SUSPEND
 	  powered and thus its contents are preserved, such as the
 	  suspend-to-RAM state (i.e. the ACPI S3 state).
 
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
 config HIBERNATION_UP_POSSIBLE
 	bool
 	depends on X86 || PPC64_SWSUSP || PPC32
--- everything.orig/arch/powerpc/Kconfig	2007-12-04 14:59:03.266409342 +0100
+++ everything/arch/powerpc/Kconfig	2007-12-04 15:00:19.226410156 +0100
@@ -365,6 +365,10 @@ config CMDLINE
 	  most cases you will need to specify the root device here.
 
 if !44x || BROKEN
+config ARCH_WANTS_FREEZER_CONTROL
+	def_bool y
+	depends on ADB_PMU
+
 source kernel/power/Kconfig
 endif
 
