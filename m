From: Len Brown <lenb@kernel.org>
Subject: [PATCH 36/37] Hibernation: Invoke suspend notifications
	after console switch
Date: Thu, 31 Jan 2008 23:37:07 -0500
Message-ID: <6c6e1163d2b4833bf448f02aaf26e12053957078.1201840183.git.len.brown__31966.9363358573$1201843713$gmane$org@intel.com>
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
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Following the recent change in the suspend code path, switch consoles before
calling PM notifiers during hibernation.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/disk.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index 53c22d9..d09da08 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
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
-- 
1.5.4.rc5.16.gc0279
