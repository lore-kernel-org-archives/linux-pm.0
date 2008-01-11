From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] Hibernation: Invoke suspend notifications
	after console switch
Date: Fri, 11 Jan 2008 01:25:21 +0100
Message-ID: <200801110125.22240.rjw__734.078084542666$1200011204$gmane$org@sisk.pl>
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

From: Rafael J. Wysocki <rjw@sisk.pl>

Following the recent change in the suspend code path, switch consoles before
calling PM notifiers during hibernation.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

Index: linux-2.6/kernel/power/disk.c
===================================================================
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -458,20 +458,13 @@ static void power_down(void)
 	while(1);
 }
 
-static void unprepare_processes(void)
-{
-	thaw_processes();
-	pm_restore_console();
-}
-
 static int prepare_processes(void)
 {
 	int error = 0;
 
-	pm_prepare_console();
 	if (freeze_processes()) {
 		error = -EBUSY;
-		unprepare_processes();
+		thaw_processes();
 	}
 	return error;
 }
@@ -491,6 +484,7 @@ int hibernate(void)
 		goto Unlock;
 	}
 
+	pm_prepare_console();
 	error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
 	if (error)
 		goto Exit;
@@ -530,11 +524,12 @@ int hibernate(void)
 		swsusp_free();
 	}
  Thaw:
-	unprepare_processes();
+	thaw_processes();
  Finish:
 	free_basic_memory_bitmaps();
  Exit:
 	pm_notifier_call_chain(PM_POST_HIBERNATION);
+	pm_restore_console();
 	atomic_inc(&snapshot_device_available);
  Unlock:
 	mutex_unlock(&pm_mutex);
@@ -603,6 +598,7 @@ static int software_resume(void)
 		goto Unlock;
 	}
 
+	pm_prepare_console();
 	error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
 	if (error)
 		goto Finish;
@@ -626,11 +622,12 @@ static int software_resume(void)
 
 	printk(KERN_ERR "PM: Restore failed, recovering.\n");
 	swsusp_free();
-	unprepare_processes();
+	thaw_processes();
  Done:
 	free_basic_memory_bitmaps();
  Finish:
 	pm_notifier_call_chain(PM_POST_RESTORE);
+	pm_restore_console();
 	atomic_inc(&snapshot_device_available);
 	/* For success case, the suspend path will release the lock */
  Unlock:
