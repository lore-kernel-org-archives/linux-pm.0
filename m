From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] PM: Add PM_RESUME_PREPARE and PM_POST_RESUME
	notifiers
Date: Wed, 31 Oct 2007 17:11:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0710311707250.8202-100000@iolanthe.rowland.org>
References: <200710302215.37728.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710302215.37728.rjw@sisk.pl>
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

On Tue, 30 Oct 2007, Rafael J. Wysocki wrote:

> > Drivers might want to do different things at the beginning of
> > hibernation and the beginning of a restore.
> > 
> > Alternatively, the user interface can be changed.  The current 
> > organization is slightly illogical; there should be different ioctls 
> > for prepare-to-create-snapshot and prepare-to-restore-snapshot instead 
> > of a single SNAPSHOT_FREEZE for both.  How about adding RESTORE_FREEZE 
> > and RESTORE_UNFREEZE; does this sound good?
> 
> Hm, we could define separate FREEZE ioctls for restore, but if they end up
> doing the same as the analogous snapshot ones, they'll be somewhat redundant
> ...

How do you like this version of the patch then?  Redundancy is kept to 
a minimum.

(Strictly speaking, we should have two different notification codes for 
PM_POST_HIBERNATION: one for use after the atomic snapshot has been 
created and one for use after it has been restored.  But I'm not going 
to worry about that right now.)

Alan Stern



Index: usb-2.6/Documentation/power/notifiers.txt
===================================================================
--- usb-2.6.orig/Documentation/power/notifiers.txt
+++ usb-2.6/Documentation/power/notifiers.txt
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
Index: usb-2.6/include/linux/notifier.h
===================================================================
--- usb-2.6.orig/include/linux/notifier.h
+++ usb-2.6/include/linux/notifier.h
@@ -230,6 +230,8 @@ static inline int notifier_to_errno(int 
 #define PM_POST_HIBERNATION	0x0002 /* Hibernation finished */
 #define PM_SUSPEND_PREPARE	0x0003 /* Going to suspend the system */
 #define PM_POST_SUSPEND		0x0004 /* Suspend finished */
+#define PM_RESTORE_PREPARE	0x0005 /* Going to restore a saved image */
+#define PM_POST_RESTORE		0x0006 /* Restore failed */
 
 /* Console keyboard events.
  * Note: KBD_KEYCODE is always sent before KBD_UNBOUND_KEYCODE, KBD_UNICODE and
Index: usb-2.6/kernel/power/disk.c
===================================================================
--- usb-2.6.orig/kernel/power/disk.c
+++ usb-2.6/kernel/power/disk.c
@@ -489,6 +489,10 @@ static int software_resume(void)
 		goto Unlock;
 	}
 
+	error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
+	if (error)
+		goto Exit;
+
 	error = create_basic_memory_bitmaps();
 	if (error)
 		goto Finish;
@@ -512,6 +516,8 @@ static int software_resume(void)
  Done:
 	free_basic_memory_bitmaps();
  Finish:
+	pm_notifier_call_chain(PM_POST_RESTORE);
+ Exit:
 	atomic_inc(&snapshot_device_available);
 	/* For success case, the suspend path will release the lock */
  Unlock:
Index: usb-2.6/Documentation/power/userland-swsusp.txt
===================================================================
--- usb-2.6.orig/Documentation/power/userland-swsusp.txt
+++ usb-2.6/Documentation/power/userland-swsusp.txt
@@ -26,11 +26,12 @@ once at a time.
 
 The ioctl() commands recognized by the device are:
 
-SNAPSHOT_FREEZE - freeze user space processes (the current process is
-	not frozen); this is required for SNAPSHOT_ATOMIC_SNAPSHOT
-	and SNAPSHOT_ATOMIC_RESTORE to succeed
+SNAPSHOT_FREEZE - freeze user space processes in preparation for creating
+	an atomic snapshot (the current process is not frozen); this is
+	required for SNAPSHOT_ATOMIC_SNAPSHOT to succeed
 
 SNAPSHOT_UNFREEZE - thaw user space processes frozen by SNAPSHOT_FREEZE
+	after the snapshot has been created or restored
 
 SNAPSHOT_ATOMIC_SNAPSHOT - create a snapshot of the system memory; the
 	last argument of ioctl() should be a pointer to an int variable,
@@ -41,6 +42,15 @@ SNAPSHOT_ATOMIC_SNAPSHOT - create a snap
 	has been created the read() operation can be used to transfer
 	it out of the kernel
 
+SNAPSHOT_RESTORE_FREEZE - freeze user space processes in preparation for
+	restoring an atomic snapshot (the current pocess is not frozen);
+	this is required for SNAPSHOT_ATOMIC_RESTORE to succeed
+
+SNAPSHOT_RESTORE_UNFREEZE - thaw user space processes frozen by
+	SNAPSHOT_RESTORE_FREEZE; this should be used when
+	SNAPSHOT_ATOMIC_RESTORE fails (if it succeeds the current process
+	won't exist any more)
+
 SNAPSHOT_ATOMIC_RESTORE - restore the system memory state from the
 	uploaded snapshot image; before calling it you should transfer
 	the system memory snapshot back to the kernel using the write()
@@ -157,7 +167,8 @@ mechanism and the userland utilities usi
 means, such as checksums, to ensure the integrity of the snapshot image.
 
 The suspending and resuming utilities MUST lock themselves in memory,
-preferrably using mlockall(), before calling SNAPSHOT_FREEZE.
+preferrably using mlockall(), before calling SNAPSHOT_FREEZE or
+SNAPSHOT_RESTORE_FREEZE.
 
 The suspending utility MUST check the value stored by SNAPSHOT_ATOMIC_SNAPSHOT
 in the memory location pointed to by the last argument of ioctl() and proceed
Index: usb-2.6/kernel/power/power.h
===================================================================
--- usb-2.6.orig/kernel/power/power.h
+++ usb-2.6/kernel/power/power.h
@@ -160,7 +160,9 @@ struct resume_swap_area {
 #define SNAPSHOT_PMOPS			_IOW(SNAPSHOT_IOC_MAGIC, 12, unsigned int)
 #define SNAPSHOT_SET_SWAP_AREA		_IOW(SNAPSHOT_IOC_MAGIC, 13, \
 							struct resume_swap_area)
-#define SNAPSHOT_IOC_MAXNR	13
+#define SNAPSHOT_RESTORE_FREEZE		_IO(SNAPSHOT_IOC_MAGIC, 14)
+#define SNAPSHOT_RESTORE_UNFREEZE	_IO(SNAPSHOT_IOC_MAGIC, 15)
+#define SNAPSHOT_IOC_MAXNR	15
 
 #define PMOPS_PREPARE	1
 #define PMOPS_ENTER	2
Index: usb-2.6/kernel/power/user.c
===================================================================
--- usb-2.6.orig/kernel/power/user.c
+++ usb-2.6/kernel/power/user.c
@@ -128,6 +128,42 @@ static ssize_t snapshot_write(struct fil
 	return res;
 }
 
+static int user_freeze(struct snapshot_data *data, int pre_msg, int err_msg)
+{
+	int error = 0;
+
+	if (data->frozen)
+		return error;
+	mutex_lock(&pm_mutex);
+	error = pm_notifier_call_chain(pre_msg);
+	if (!error) {
+		printk("Syncing filesystems ... ");
+		sys_sync();
+		printk("done.\n");
+
+		error = freeze_processes();
+		if (error)
+			thaw_processes();
+	}
+	if (error)
+		pm_notifier_call_chain(err_msg);
+	mutex_unlock(&pm_mutex);
+	if (!error)
+		data->frozen = 1;
+	return error;
+}
+
+static void user_unfreeze(struct snapshot_data *data, int post_msg)
+{
+	if (!data->frozen || data->ready)
+		return;
+	mutex_lock(&pm_mutex);
+	thaw_processes();
+	pm_notifier_call_chain(post_msg);
+	mutex_unlock(&pm_mutex);
+	data->frozen = 0;
+}
+
 static int snapshot_ioctl(struct inode *inode, struct file *filp,
                           unsigned int cmd, unsigned long arg)
 {
@@ -148,34 +184,20 @@ static int snapshot_ioctl(struct inode *
 	switch (cmd) {
 
 	case SNAPSHOT_FREEZE:
-		if (data->frozen)
-			break;
-		mutex_lock(&pm_mutex);
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
-		if (error)
-			pm_notifier_call_chain(PM_POST_HIBERNATION);
-		mutex_unlock(&pm_mutex);
-		if (!error)
-			data->frozen = 1;
+		error = user_freeze(data, PM_HIBERNATION_PREPARE,
+				PM_POST_HIBERNATION);
+		break;
+
+	case SNAPSHOT_RESTORE_FREEZE:
+		error = user_freeze(data, PM_RESTORE_PREPARE, PM_POST_RESTORE);
 		break;
 
 	case SNAPSHOT_UNFREEZE:
-		if (!data->frozen || data->ready)
-			break;
-		mutex_lock(&pm_mutex);
-		thaw_processes();
-		pm_notifier_call_chain(PM_POST_HIBERNATION);
-		mutex_unlock(&pm_mutex);
-		data->frozen = 0;
+		user_unfreeze(data, PM_POST_HIBERNATION);
+		break;
+
+	case SNAPSHOT_RESTORE_UNFREEZE:
+		user_unfreeze(data, PM_POST_RESTORE);
 		break;
 
 	case SNAPSHOT_ATOMIC_SNAPSHOT:
