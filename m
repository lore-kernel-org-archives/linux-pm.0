From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: fix to earlier patch adding PM_RESTORE
	notifiers
Date: Mon, 5 Nov 2007 15:39:56 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711051536330.2800-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1007) fixes a mistake in the patch adding the PM RESTORE
notifiers.  The PM_POST_RESTORE notifier should be called if an error
occurs in the PM_RESTORE_PREPARE notifications.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Rafael:

Len may prefer to merge this with the earlier patch rather than keeping
the two separate.  It's a very small update.

Alan Stern


Index: usb-2.6/kernel/power/disk.c
===================================================================
--- usb-2.6.orig/kernel/power/disk.c
+++ usb-2.6/kernel/power/disk.c
@@ -491,7 +491,7 @@ static int software_resume(void)
 
 	error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
 	if (error)
-		goto Exit;
+		goto Finish;
 
 	error = create_basic_memory_bitmaps();
 	if (error)
@@ -517,7 +517,6 @@ static int software_resume(void)
 	free_basic_memory_bitmaps();
  Finish:
 	pm_notifier_call_chain(PM_POST_RESTORE);
- Exit:
 	atomic_inc(&snapshot_device_available);
 	/* For success case, the suspend path will release the lock */
  Unlock:
Index: usb-2.6/kernel/power/user.c
===================================================================
--- usb-2.6.orig/kernel/power/user.c
+++ usb-2.6/kernel/power/user.c
@@ -66,10 +66,14 @@ static int snapshot_open(struct inode *i
 			swap_type_of(swsusp_resume_device, 0, NULL) : -1;
 		data->mode = O_RDONLY;
 		error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
+		if (error)
+			pm_notifier_call_chain(PM_POST_RESTORE);
 	} else {
 		data->swap = -1;
 		data->mode = O_WRONLY;
 		error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
+		if (error)
+			pm_notifier_call_chain(PM_POST_HIBERNATION);
 	}
 	if (error) {
 		atomic_inc(&snapshot_device_available);
