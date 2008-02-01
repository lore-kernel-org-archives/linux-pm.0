From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/37] Suspend: Add config option to disable the
	freezer if architecture wants that
Date: Thu, 31 Jan 2008 23:37:04 -0500
Message-ID: <16a00d127d8162c859537bbd8cb3934603a7985a.1201840183.git.len.brown__2621.65605458922$1201843705$gmane$org@intel.com>
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
Cc: linux-acpi@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Johannes Berg <johannes@sipsolutions.net>

This patch makes the freezer optional for suspend to allow the
system to work (or not work) like the original PMU suspend.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/powerpc/Kconfig |    4 ++++
 kernel/power/Kconfig |   11 +++++++++++
 kernel/power/main.c  |    6 +++---
 kernel/power/power.h |   22 ++++++++++++++++++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 824140d..4a22c99 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -405,6 +405,10 @@ config CMDLINE
 	  most cases you will need to specify the root device here.
 
 if !44x || BROKEN
+config ARCH_WANTS_FREEZER_CONTROL
+	def_bool y
+	depends on ADB_PMU
+
 source kernel/power/Kconfig
 endif
 
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index f8153fd..ef9b802 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
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
diff --git a/kernel/power/main.c b/kernel/power/main.c
index d9bba45..e47214c 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -181,7 +181,7 @@ static int suspend_prepare(void)
 
 	pm_prepare_console();
 
-	if (freeze_processes()) {
+	if (suspend_freeze_processes()) {
 		error = -EAGAIN;
 		goto Thaw;
 	}
@@ -199,7 +199,7 @@ static int suspend_prepare(void)
 		return 0;
 
  Thaw:
-	thaw_processes();
+	suspend_thaw_processes();
 	pm_restore_console();
  Finish:
 	pm_notifier_call_chain(PM_POST_SUSPEND);
@@ -308,7 +308,7 @@ int suspend_devices_and_enter(suspend_state_t state)
  */
 static void suspend_finish(void)
 {
-	thaw_processes();
+	suspend_thaw_processes();
 	pm_restore_console();
 	pm_notifier_call_chain(PM_POST_SUSPEND);
 }
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 8ec5499..700f44e 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -1,6 +1,7 @@
 #include <linux/suspend.h>
 #include <linux/suspend_ioctls.h>
 #include <linux/utsname.h>
+#include <linux/freezer.h>
 
 struct swsusp_info {
 	struct new_utsname	uts;
@@ -203,3 +204,24 @@ enum {
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
-- 
1.5.4.rc5.16.gc0279
