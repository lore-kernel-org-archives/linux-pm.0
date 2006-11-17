From: Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH] convert pm_sem to a mutex
Date: Fri, 17 Nov 2006 11:13:08 -0800
Message-ID: <20061117111308.5dbaa60e@freekitty>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>
Cc: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

The power management semaphore is only used as mutex, so convert it.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>


--- linux-2.6.19-rc6.orig/kernel/power/disk.c	2006-11-17 10:54:21.000000000=
 -0800
+++ linux-2.6.19-rc6/kernel/power/disk.c	2006-11-17 10:50:54.000000000 -0800
@@ -189,10 +189,10 @@
 {
 	int error;
 =

-	down(&pm_sem);
+	mutex_lock(&pm_mutex);
 	if (!swsusp_resume_device) {
 		if (!strlen(resume_file)) {
-			up(&pm_sem);
+			mutex_unlock(&pm_mutex);
 			return -ENOENT;
 		}
 		swsusp_resume_device =3D name_to_dev_t(resume_file);
@@ -207,7 +207,7 @@
 		 * FIXME: If noresume is specified, we need to find the partition
 		 * and reset it back to normal swap space.
 		 */
-		up(&pm_sem);
+		mutex_unlock(&pm_mutex);
 		return 0;
 	}
 =

@@ -251,7 +251,7 @@
 	unprepare_processes();
  Done:
 	/* For success case, the suspend path will release the lock */
-	up(&pm_sem);
+	mutex_unlock(&pm_mutex);
 	pr_debug("PM: Resume from disk failed.\n");
 	return 0;
 }
@@ -312,7 +312,7 @@
 	p =3D memchr(buf, '\n', n);
 	len =3D p ? p - buf : n;
 =

-	down(&pm_sem);
+	mutex_lock(&pm_mutex);
 	for (i =3D PM_DISK_FIRMWARE; i < PM_DISK_MAX; i++) {
 		if (!strncmp(buf, pm_disk_modes[i], len)) {
 			mode =3D i;
@@ -336,7 +336,7 @@
 =

 	pr_debug("PM: suspend-to-disk mode set to '%s'\n",
 		 pm_disk_modes[mode]);
-	up(&pm_sem);
+	mutex_unlock(&pm_mutex);
 	return error ? error : n;
 }
 =

@@ -361,9 +361,9 @@
 	if (maj !=3D MAJOR(res) || min !=3D MINOR(res))
 		goto out;
 =

-	down(&pm_sem);
+	mutex_lock(&pm_mutex);
 	swsusp_resume_device =3D res;
-	up(&pm_sem);
+	mutex_unlock(&pm_mutex);
 	printk("Attempting manual resume\n");
 	noresume =3D 0;
 	software_resume();
--- sky2.orig/kernel/power/main.c	2006-11-17 10:54:21.000000000 -0800
+++ sky2/kernel/power/main.c	2006-11-17 10:55:24.000000000 -0800
@@ -24,7 +24,7 @@
 /*This is just an arbitrary number */
 #define FREE_PAGE_NUMBER (100)
 =

-DECLARE_MUTEX(pm_sem);
+DEFINE_MUTEX(pm_mutex);
 =

 struct pm_ops *pm_ops;
 suspend_disk_method_t pm_disk_mode =3D PM_DISK_SHUTDOWN;
@@ -36,9 +36,9 @@
 =

 void pm_set_ops(struct pm_ops * ops)
 {
-	down(&pm_sem);
+	mutex_lock(&pm_mutex);
 	pm_ops =3D ops;
-	up(&pm_sem);
+	mutex_unlock(&pm_mutex);
 }
 =

 =

@@ -182,7 +182,7 @@
 =

 	if (!valid_state(state))
 		return -ENODEV;
-	if (down_trylock(&pm_sem))
+	if (mutex_trylock(&pm_mutex))
 		return -EBUSY;
 =

 	if (state =3D=3D PM_SUSPEND_DISK) {
@@ -200,7 +200,7 @@
 	pr_debug("PM: Finishing wakeup.\n");
 	suspend_finish(state);
  Unlock:
-	up(&pm_sem);
+	mutex_unlock(&pm_mutex);
 	return error;
 }
 =

--- sky2.orig/kernel/power/power.h	2006-11-17 10:49:25.000000000 -0800
+++ sky2/kernel/power/power.h	2006-11-17 10:49:55.000000000 -0800
@@ -22,7 +22,9 @@
 	return -EPERM;
 }
 #endif
-extern struct semaphore pm_sem;
+
+extern struct mutex pm_mutex;
+
 #define power_attr(_name) \
 static struct subsys_attribute _name##_attr =3D {	\
 	.attr	=3D {				\
--- sky2.orig/kernel/power/user.c	2006-11-17 10:54:21.000000000 -0800
+++ sky2/kernel/power/user.c	2006-11-17 10:55:42.000000000 -0800
@@ -76,10 +76,10 @@
 	free_all_swap_pages(data->swap, data->bitmap);
 	free_bitmap(data->bitmap);
 	if (data->frozen) {
-		down(&pm_sem);
+		mutex_lock(&pm_mutex);
 		thaw_processes();
 		enable_nonboot_cpus();
-		up(&pm_sem);
+		mutex_unlock(&pm_mutex);
 	}
 	atomic_inc(&device_available);
 	return 0;
@@ -140,7 +140,7 @@
 	case SNAPSHOT_FREEZE:
 		if (data->frozen)
 			break;
-		down(&pm_sem);
+		mutex_lock(&pm_mutex);
 		error =3D disable_nonboot_cpus();
 		if (!error) {
 			error =3D freeze_processes();
@@ -150,7 +150,7 @@
 				error =3D -EBUSY;
 			}
 		}
-		up(&pm_sem);
+		mutex_unlock(&pm_mutex);
 		if (!error)
 			data->frozen =3D 1;
 		break;
@@ -158,10 +158,10 @@
 	case SNAPSHOT_UNFREEZE:
 		if (!data->frozen)
 			break;
-		down(&pm_sem);
+		mutex_lock(&pm_mutex);
 		thaw_processes();
 		enable_nonboot_cpus();
-		up(&pm_sem);
+		mutex_unlock(&pm_mutex);
 		data->frozen =3D 0;
 		break;
 =

@@ -170,7 +170,7 @@
 			error =3D -EPERM;
 			break;
 		}
-		down(&pm_sem);
+		mutex_lock(&pm_mutex);
 		/* Free memory before shutting down devices. */
 		error =3D swsusp_shrink_memory();
 		if (!error) {
@@ -183,7 +183,7 @@
 			}
 			resume_console();
 		}
-		up(&pm_sem);
+		mutex_unlock(&pm_mutex);
 		if (!error)
 			error =3D put_user(in_suspend, (unsigned int __user *)arg);
 		if (!error)
@@ -197,7 +197,7 @@
 			break;
 		}
 		snapshot_free_unused_memory(&data->handle);
-		down(&pm_sem);
+		mutex_lock(&pm_mutex);
 		pm_prepare_console();
 		suspend_console();
 		error =3D device_suspend(PMSG_PRETHAW);
@@ -207,7 +207,7 @@
 		}
 		resume_console();
 		pm_restore_console();
-		up(&pm_sem);
+		mutex_unlock(&pm_mutex);
 		break;
 =

 	case SNAPSHOT_FREE:
@@ -282,7 +282,7 @@
 			break;
 		}
 =

-		if (down_trylock(&pm_sem)) {
+		if (mutex_trylock(&pm_mutex)) {
 			error =3D -EBUSY;
 			break;
 		}
@@ -310,7 +310,7 @@
 			pm_ops->finish(PM_SUSPEND_MEM);
 =

 OutS3:
-		up(&pm_sem);
+		mutex_unlock(&pm_mutex);
 		break;
 =

 	default:
