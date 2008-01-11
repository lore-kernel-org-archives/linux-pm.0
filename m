From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] Suspend: Invoke suspend notifications after
	console switch
Date: Fri, 11 Jan 2008 01:22:23 +0100
Message-ID: <200801110122.23791.rjw__14927.743926137$1200011195$gmane$org@sisk.pl>
References: <200801110118.46106.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801110118.46106.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
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
---
 kernel/power/main.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -173,12 +173,12 @@ static int suspend_prepare(void)
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
@@ -198,9 +198,9 @@ static int suspend_prepare(void)
 
  Thaw:
 	suspend_thaw_processes();
-	pm_restore_console();
  Finish:
 	pm_notifier_call_chain(PM_POST_SUSPEND);
+	pm_restore_console();
 	return error;
 }
 
@@ -307,8 +307,8 @@ int suspend_devices_and_enter(suspend_st
 static void suspend_finish(void)
 {
 	suspend_thaw_processes();
-	pm_restore_console();
 	pm_notifier_call_chain(PM_POST_SUSPEND);
+	pm_restore_console();
 }
 
 
