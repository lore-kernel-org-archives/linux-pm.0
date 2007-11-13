From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] PM: make freezer optional for suspend
Date: Tue, 13 Nov 2007 20:04:30 +0100
Message-ID: <1194980670.6695.1.camel@johannes.berg>
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
To: Len Brown <len.brown@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch makes the freezer optional for suspend to allow the
system to work (or not work) like the original PMU suspend.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
In a quick test, playing sound across suspend failed to work,
it usually works when the freezer is enabled (unless you use
gstreamer.)

 kernel/power/Kconfig |   10 ++++++++++
 kernel/power/main.c  |    6 ++++++
 2 files changed, 16 insertions(+)

--- everything.orig/kernel/power/main.c	2007-11-13 20:00:16.406263508 +0100
+++ everything/kernel/power/main.c	2007-11-13 20:00:17.626268174 +0100
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
--- everything.orig/kernel/power/Kconfig	2007-11-13 20:00:16.476274685 +0100
+++ everything/kernel/power/Kconfig	2007-11-13 20:01:10.186257269 +0100
@@ -97,6 +97,16 @@ config SUSPEND
 	  powered and thus its contents are preserved, such as the
 	  suspend-to-RAM state (i.e. the ACPI S3 state).
 
+config SUSPEND_FREEZER
+	bool "Enable freezer for suspend to RAM/standby" if ADB_PMU || BROKEN
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
