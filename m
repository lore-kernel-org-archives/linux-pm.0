From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 3/4] swsusp: Change code ordering in
	user.c
Date: Sun, 17 Dec 2006 19:09:01 +0100
Message-ID: <200612171909.01832.rjw@sisk.pl>
References: <200612171858.16380.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612171858.16380.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: pm list <linux-pm@lists.osdl.org>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org, Stefan Seyfried <seife@suse.de>, Stephen Hemminger <shemminger@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Change the ordering of code in kernel/power/user.c so that device_suspend()
is called before disable_nonboot_cpus() and device_resume() is called after
enable_nonboot_cpus().  This is needed to make the userland suspend call
pm_ops->finish() after enable_nonboot_cpus() and before device_resume(),
as indicated by the recent discussion on Linux-PM
(cf. http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.html).

The changes here only affect the userland interface of swsusp.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/user.c |   92 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 34 deletions(-)

Index: linux-2.6.20-rc1/kernel/power/user.c
===================================================================
--- linux-2.6.20-rc1.orig/kernel/power/user.c	2006-12-14 22:35:52.000000000 +0100
+++ linux-2.6.20-rc1/kernel/power/user.c	2006-12-14 23:20:10.000000000 +0100
@@ -122,6 +122,59 @@ static ssize_t snapshot_write(struct fil
 	return res;
 }
 
+static inline int snapshot_suspend(void)
+{
+	int error;
+
+	mutex_lock(&pm_mutex);
+	/* Free memory before shutting down devices. */
+	error = swsusp_shrink_memory();
+	if (error)
+		goto Finish;
+
+	suspend_console();
+	error = device_suspend(PMSG_FREEZE);
+	if (error)
+		goto Resume_devices;
+
+	error = disable_nonboot_cpus();
+	if (!error) {
+		in_suspend = 1;
+		error = swsusp_suspend();
+	}
+	enable_nonboot_cpus();
+ Resume_devices:
+	device_resume();
+	resume_console();
+ Finish:
+	mutex_unlock(&pm_mutex);
+	return error;
+}
+
+static inline int snapshot_restore(void)
+{
+	int error;
+
+	mutex_lock(&pm_mutex);
+	pm_prepare_console();
+	suspend_console();
+	error = device_suspend(PMSG_PRETHAW);
+	if (error)
+		goto Resume_devices;
+
+	error = disable_nonboot_cpus();
+	if (!error)
+		error = swsusp_resume();
+
+	enable_nonboot_cpus();
+ Resume_devices:
+	device_resume();
+	resume_console();
+	pm_restore_console();
+	mutex_unlock(&pm_mutex);
+	return error;
+}
+
 static int snapshot_ioctl(struct inode *inode, struct file *filp,
                           unsigned int cmd, unsigned long arg)
 {
@@ -145,14 +198,9 @@ static int snapshot_ioctl(struct inode *
 		if (data->frozen)
 			break;
 		mutex_lock(&pm_mutex);
-		error = disable_nonboot_cpus();
-		if (!error) {
-			error = freeze_processes();
-			if (error) {
-				thaw_processes();
-				enable_nonboot_cpus();
-				error = -EBUSY;
-			}
+		if (freeze_processes()) {
+			thaw_processes();
+			error = -EBUSY;
 		}
 		mutex_unlock(&pm_mutex);
 		if (!error)
@@ -164,7 +212,6 @@ static int snapshot_ioctl(struct inode *
 			break;
 		mutex_lock(&pm_mutex);
 		thaw_processes();
-		enable_nonboot_cpus();
 		mutex_unlock(&pm_mutex);
 		data->frozen = 0;
 		break;
@@ -174,20 +221,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
-		mutex_lock(&pm_mutex);
-		/* Free memory before shutting down devices. */
-		error = swsusp_shrink_memory();
-		if (!error) {
-			suspend_console();
-			error = device_suspend(PMSG_FREEZE);
-			if (!error) {
-				in_suspend = 1;
-				error = swsusp_suspend();
-				device_resume();
-			}
-			resume_console();
-		}
-		mutex_unlock(&pm_mutex);
+		error = snapshot_suspend();
 		if (!error)
 			error = put_user(in_suspend, (unsigned int __user *)arg);
 		if (!error)
@@ -201,17 +235,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
-		mutex_lock(&pm_mutex);
-		pm_prepare_console();
-		suspend_console();
-		error = device_suspend(PMSG_PRETHAW);
-		if (!error) {
-			error = swsusp_resume();
-			device_resume();
-		}
-		resume_console();
-		pm_restore_console();
-		mutex_unlock(&pm_mutex);
+		error = snapshot_restore();
 		break;
 
 	case SNAPSHOT_FREE:


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
