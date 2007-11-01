From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] PM: Add PM_RESUME_PREPARE and PM_POST_RESUME
	notifiers
Date: Thu, 1 Nov 2007 10:40:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0711011019440.4146-100000@iolanthe.rowland.org>
References: <200710312309.01306.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710312309.01306.rjw@sisk.pl>
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

On Wed, 31 Oct 2007, Rafael J. Wysocki wrote:

> > (Strictly speaking, we should have two different notification codes for 
> > PM_POST_HIBERNATION: one for use after the atomic snapshot has been 
> > created and one for use after it has been restored.  But I'm not going 
> > to worry about that right now.)
> 
> IIRC, the notifiers are not called after creating the image.  Do you think that
> they should be called at that time?  If so, then why?

My mistake.  It's easy to forget that even though devices get resumed 
for writing after the image is created, tasks don't get thawed.  And 
since tasks don't get thawed, the notifiers shouldn't be called.

> As far as the patch is concerned, I'd prefer not to add new ioctls(), mainly
> because there's userland out there that doesn't know about them and we can't
> make people switch overnight.  I'd prever to move the notifier calls to
> snapshot_open() and snapshot_release().

Okay, here's a patch to do things that way.

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
Index: usb-2.6/kernel/power/user.c
===================================================================
--- usb-2.6.orig/kernel/power/user.c
+++ usb-2.6/kernel/power/user.c
@@ -44,6 +44,7 @@ atomic_t snapshot_device_available = ATO
 static int snapshot_open(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
+	int error;
 
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0))
 		return -EBUSY;
@@ -64,9 +65,15 @@ static int snapshot_open(struct inode *i
 		data->swap = swsusp_resume_device ?
 			swap_type_of(swsusp_resume_device, 0, NULL) : -1;
 		data->mode = O_RDONLY;
+		error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
 	} else {
 		data->swap = -1;
 		data->mode = O_WRONLY;
+		error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
+	}
+	if (error) {
+		atomic_inc(&snapshot_device_available);
+		return error;
 	}
 	data->frozen = 0;
 	data->ready = 0;
@@ -88,6 +95,8 @@ static int snapshot_release(struct inode
 		thaw_processes();
 		mutex_unlock(&pm_mutex);
 	}
+	pm_notifier_call_chain(data->mode == O_WRONLY ?
+			PM_POST_HIBERNATION : PM_POST_RESTORE);
 	atomic_inc(&snapshot_device_available);
 	return 0;
 }
@@ -151,18 +160,13 @@ static int snapshot_ioctl(struct inode *
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
@@ -173,7 +177,6 @@ static int snapshot_ioctl(struct inode *
 			break;
 		mutex_lock(&pm_mutex);
 		thaw_processes();
-		pm_notifier_call_chain(PM_POST_HIBERNATION);
 		mutex_unlock(&pm_mutex);
 		data->frozen = 0;
 		break;
