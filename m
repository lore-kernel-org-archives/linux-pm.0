From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] PM: invoke suspend notifications after console
	switch
Date: Mon, 17 Dec 2007 02:09:58 +0100
Message-ID: <1197853799.4885.7.camel@johannes.berg>
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

A subsequent patch will enable apm-emulation notification for suspends
triggered in any way by using the suspend notifications. This causes
the system to lock up between X being needed to switch away from the
VT and X already waiting for resume in the apm ioctl.

This patch moves the console switch (if enabled) before the suspend
notification (and after the resume notification) to avoid this issue.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 kernel/power/main.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- everything.orig/kernel/power/main.c	2007-12-17 01:52:29.617085178 +0100
+++ everything/kernel/power/main.c	2007-12-17 01:53:23.547064887 +0100
@@ -73,12 +73,12 @@ static int suspend_prepare(void)
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
@@ -98,9 +98,9 @@ static int suspend_prepare(void)
 
  Thaw:
 	suspend_thaw_processes();
-	pm_restore_console();
  Finish:
 	pm_notifier_call_chain(PM_POST_SUSPEND);
+	pm_restore_console();
 	return error;
 }
 
@@ -192,8 +192,8 @@ int suspend_devices_and_enter(suspend_st
 static void suspend_finish(void)
 {
 	suspend_thaw_processes();
-	pm_restore_console();
 	pm_notifier_call_chain(PM_POST_SUSPEND);
+	pm_restore_console();
 }
 
 
