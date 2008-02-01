From: Len Brown <lenb@kernel.org>
Subject: [PATCH 35/37] Suspend: Invoke suspend notifications
	after console switch
Date: Thu, 31 Jan 2008 23:37:06 -0500
Message-ID: <a7c630e98acfad228bd2b3bba59e163ad86ed6ee.1201840183.git.len.brown__37802.2210360088$1201843714$gmane$org@intel.com>
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

In order to fix APM emulation it is necessary to enable apm-emulation
notifications for suspends triggered in various ways via the suspend
notifiers.  However, this will cause the systems using APM emulation
to lock up between X being needed to switch away from the VT and X
already waiting for resume in the APM ioctl.

This patch moves the console switch (if enabled) before the suspend
notification (and after the resume notification) to avoid this issue.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/main.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index e47214c..6a6d5eb 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -175,12 +175,12 @@ static int suspend_prepare(void)
 	if (!suspend_ops || !suspend_ops->enter)
 		return -EPERM;
 
+	pm_prepare_console();
+
 	error = pm_notifier_call_chain(PM_SUSPEND_PREPARE);
 	if (error)
 		goto Finish;
 
-	pm_prepare_console();
-
 	if (suspend_freeze_processes()) {
 		error = -EAGAIN;
 		goto Thaw;
@@ -200,9 +200,9 @@ static int suspend_prepare(void)
 
  Thaw:
 	suspend_thaw_processes();
-	pm_restore_console();
  Finish:
 	pm_notifier_call_chain(PM_POST_SUSPEND);
+	pm_restore_console();
 	return error;
 }
 
@@ -309,8 +309,8 @@ int suspend_devices_and_enter(suspend_state_t state)
 static void suspend_finish(void)
 {
 	suspend_thaw_processes();
-	pm_restore_console();
 	pm_notifier_call_chain(PM_POST_SUSPEND);
+	pm_restore_console();
 }
 
 
-- 
1.5.4.rc5.16.gc0279
