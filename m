From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] Hibernation: Add PM_RESTORE_PREPARE and
	PM_POST_RESTORE notifiers (rev. 2)
Date: Mon, 5 Nov 2007 23:46:09 +0100
Message-ID: <200711052346.10598.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Nigel Cunningham <nigel@suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

[Len, please disregard the previous iteration of this patch and add the one
below to the suspend branch, thanks.]
---
From: Alan Stern <stern@rowland.harvard.edu>

Add PM_RESTORE_PREPARE and PM_POST_RESTORE notifiers to the PM core, to be used
in analogy with the existing PM_HIBERNATION_PREPARE and PM_POST_HIBERNATION
notifiers.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>
Signed-off-by: "Rafael J. Wysocki" <rjw@sisk.pl>
---
 Documentation/power/notifiers.txt |    8 ++++++++
 include/linux/notifier.h          |    2 ++
 kernel/power/disk.c               |    5 +++++
 kernel/power/user.c               |   31 +++++++++++++++++++------------
 4 files changed, 34 insertions(+), 12 deletions(-)

Index: linux-2.6/Documentation/power/notifiers.txt
===================================================================
--- linux-2.6.orig/Documentation/power/notifiers.txt
+++ linux-2.6/Documentation/power/notifiers.txt
@@ -28,6 +28,14 @@ PM_POST_HIBERNATION	The system memory st
 			hibernation.  Device drivers' .resume() callbacks have
 			been executed and tasks have been thawed.
 
+PM_RESTORE_PREPARE	The system is going to restore a hibernation image.
+			If all goes well the restored kernel will issue a
+			PM_POST_HIBERNATION notification.
+
+PM_POST_RESTORE		An error occurred during the hibernation restore.
+			Device drivers' .resume() callbacks have been executed
+			and tasks have been thawed.
+
 PM_SUSPEND_PREPARE	The system is preparing for a suspend.
 
 PM_POST_SUSPEND		The system has just resumed or an error occured during
Index: linux-2.6/include/linux/notifier.h
===================================================================
--- linux-2.6.orig/include/linux/notifier.h
+++ linux-2.6/include/linux/notifier.h
@@ -230,6 +230,8 @@ static inline int notifier_to_errno(int 
 #define PM_POST_HIBERNATION	0x0002 /* Hibernation finished */
 #define PM_SUSPEND_PREPARE	0x0003 /* Going to suspend the system */
 #define PM_POST_SUSPEND		0x0004 /* Suspend finished */
+#define PM_RESTORE_PREPARE	0x0005 /* Going to restore a saved image */
+#define PM_POST_RESTORE		0x0006 /* Restore failed */
 
 /* Console keyboard events.
  * Note: KBD_KEYCODE is always sent before KBD_UNBOUND_KEYCODE, KBD_UNICODE and
Index: linux-2.6/kernel/power/disk.c
===================================================================
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -489,6 +489,10 @@ static int software_resume(void)
 		goto Unlock;
 	}
 
+	error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
+	if (error)
+		goto Finish;
+
 	error = create_basic_memory_bitmaps();
 	if (error)
 		goto Finish;
@@ -512,6 +516,7 @@ static int software_resume(void)
  Done:
 	free_basic_memory_bitmaps();
  Finish:
+	pm_notifier_call_chain(PM_POST_RESTORE);
 	atomic_inc(&snapshot_device_available);
 	/* For success case, the suspend path will release the lock */
  Unlock:
Index: linux-2.6/kernel/power/user.c
===================================================================
--- linux-2.6.orig/kernel/power/user.c
+++ linux-2.6/kernel/power/user.c
@@ -67,6 +67,7 @@ atomic_t snapshot_device_available = ATO
 static int snapshot_open(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
+	int error;
 
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0))
 		return -EBUSY;
@@ -87,9 +88,19 @@ static int snapshot_open(struct inode *i
 		data->swap = swsusp_resume_device ?
 			swap_type_of(swsusp_resume_device, 0, NULL) : -1;
 		data->mode = O_RDONLY;
+		error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
+		if (error)
+			pm_notifier_call_chain(PM_POST_RESTORE);
 	} else {
 		data->swap = -1;
 		data->mode = O_WRONLY;
+		error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
+		if (error)
+			pm_notifier_call_chain(PM_POST_HIBERNATION);
+	}
+	if (error) {
+		atomic_inc(&snapshot_device_available);
+		return error;
 	}
 	data->frozen = 0;
 	data->ready = 0;
@@ -111,6 +122,8 @@ static int snapshot_release(struct inode
 		thaw_processes();
 		mutex_unlock(&pm_mutex);
 	}
+	pm_notifier_call_chain(data->mode == O_WRONLY ?
+			PM_POST_HIBERNATION : PM_POST_RESTORE);
 	atomic_inc(&snapshot_device_available);
 	return 0;
 }
@@ -174,18 +187,13 @@ static int snapshot_ioctl(struct inode *
 		if (data->frozen)
 			break;
 		mutex_lock(&pm_mutex);
-		error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
-		if (!error) {
-			printk("Syncing filesystems ... ");
-			sys_sync();
-			printk("done.\n");
-
-			error = freeze_processes();
-			if (error)
-				thaw_processes();
-		}
+		printk("Syncing filesystems ... ");
+		sys_sync();
+		printk("done.\n");
+
+		error = freeze_processes();
 		if (error)
-			pm_notifier_call_chain(PM_POST_HIBERNATION);
+			thaw_processes();
 		mutex_unlock(&pm_mutex);
 		if (!error)
 			data->frozen = 1;
@@ -196,7 +204,6 @@ static int snapshot_ioctl(struct inode *
 			break;
 		mutex_lock(&pm_mutex);
 		thaw_processes();
-		pm_notifier_call_chain(PM_POST_HIBERNATION);
 		mutex_unlock(&pm_mutex);
 		data->frozen = 0;
 		break;
