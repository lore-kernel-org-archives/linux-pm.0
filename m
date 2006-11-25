From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 4/5] swsusp: Add PLATFORM_SNAPSHOT
	and PLATFORM_RESTORE ioctls
Date: Sat, 25 Nov 2006 22:45:28 +0100
Message-ID: <200611252245.28687.rjw@sisk.pl>
References: <200611252210.58203.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200611252210.58203.rjw@sisk.pl>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Since pm_ops->finish() has to be called after enable_nonboot_cpus() and before
device_resume(), from the userland interface perspective it should be treated
as a part of the atomic suspend and resume operations.  For this reason we
need two additional ioctls to be called instead of ATOMIC_SNAPSHOT and
ATOMIC_RESTORE, respectively, when the platform suspend mode is to be used.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/power.h |    4 ++
 kernel/power/user.c  |   71 +++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 64 insertions(+), 11 deletions(-)

Index: linux-2.6.19-rc6-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.19-rc6-mm1.orig/kernel/power/power.h
+++ linux-2.6.19-rc6-mm1/kernel/power/power.h
@@ -133,7 +133,9 @@ struct resume_swap_area {
 #define SNAPSHOT_PMOPS			_IOW(SNAPSHOT_IOC_MAGIC, 12, unsigned int)
 #define SNAPSHOT_SET_SWAP_AREA		_IOW(SNAPSHOT_IOC_MAGIC, 13, \
 							struct resume_swap_area)
-#define SNAPSHOT_IOC_MAXNR	13
+#define SNAPSHOT_PLATFORM_SNAPSHOT	_IOW(SNAPSHOT_IOC_MAGIC, 14, unsigned int)
+#define SNAPSHOT_PLATFORM_RESTORE	_IO(SNAPSHOT_IOC_MAGIC, 15)
+#define SNAPSHOT_IOC_MAXNR	15
 
 #define PMOPS_PREPARE	1
 #define PMOPS_ENTER	2
Index: linux-2.6.19-rc6-mm1/kernel/power/user.c
===================================================================
--- linux-2.6.19-rc6-mm1.orig/kernel/power/user.c
+++ linux-2.6.19-rc6-mm1/kernel/power/user.c
@@ -122,7 +122,23 @@ static ssize_t snapshot_write(struct fil
 	return res;
 }
 
-static int snapshot_suspend(void)
+static inline int platform_prepare(void)
+{
+	int error = 0;
+
+	if (pm_ops && pm_ops->prepare)
+		error = pm_ops->prepare(PM_SUSPEND_DISK);
+
+	return error;
+}
+
+static inline void platform_finish(void)
+{
+	if (pm_ops && pm_ops->finish)
+		pm_ops->finish(PM_SUSPEND_DISK);
+}
+
+static int snapshot_suspend(int platform_mode)
 {
 	int error;
 
@@ -132,6 +148,11 @@ static int snapshot_suspend(void)
 	if (error)
 		goto Finish;
 
+	if (platform_mode) {
+		error = platform_prepare();
+		if (error)
+			goto Finish;
+	}
 	suspend_console();
 	error = device_suspend(PMSG_FREEZE);
 	if (error)
@@ -144,6 +165,9 @@ static int snapshot_suspend(void)
 	}
 	enable_nonboot_cpus();
  Resume_devices:
+	if (platform_mode)
+		platform_finish();
+
 	device_resume();
 	resume_console();
  Finish:
@@ -151,12 +175,17 @@ static int snapshot_suspend(void)
 	return error;
 }
 
-static int snapshot_restore(void)
+static int snapshot_restore(int platform_mode)
 {
 	int error;
 
 	mutex_lock(&pm_mutex);
 	pm_prepare_console();
+	if (platform_mode) {
+		error = platform_prepare();
+		if (error)
+			goto Finish;
+	}
 	suspend_console();
 	error = device_suspend(PMSG_PRETHAW);
 	if (error)
@@ -168,8 +197,12 @@ static int snapshot_restore(void)
 
 	enable_nonboot_cpus();
  Resume_devices:
+	if (platform_mode)
+		platform_finish();
+
 	device_resume();
 	resume_console();
+ Finish:
 	pm_restore_console();
 	mutex_unlock(&pm_mutex);
 	return error;
@@ -221,7 +254,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
-		error = snapshot_suspend();
+		error = snapshot_suspend(0);
 		if (!error)
 			error = put_user(in_suspend, (unsigned int __user *)arg);
 		if (!error)
@@ -235,7 +268,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
-		error = snapshot_restore();
+		error = snapshot_restore(0);
 		break;
 
 	case SNAPSHOT_FREE:
@@ -345,9 +378,7 @@ static int snapshot_ioctl(struct inode *
 		switch (arg) {
 
 		case PMOPS_PREPARE:
-			if (pm_ops->prepare) {
-				error = pm_ops->prepare(PM_SUSPEND_DISK);
-			}
+			error = platform_prepare();
 			break;
 
 		case PMOPS_ENTER:
@@ -356,9 +387,7 @@ static int snapshot_ioctl(struct inode *
 			break;
 
 		case PMOPS_FINISH:
-			if (pm_ops && pm_ops->finish) {
-				pm_ops->finish(PM_SUSPEND_DISK);
-			}
+			platform_finish();
 			break;
 
 		default:
@@ -399,6 +428,28 @@ static int snapshot_ioctl(struct inode *
 		}
 		break;
 
+	case SNAPSHOT_PLATFORM_SNAPSHOT:
+		if (data->mode != O_RDONLY || !data->frozen  || data->ready) {
+			error = -EPERM;
+			break;
+		}
+		error = snapshot_suspend(1);
+		if (!error)
+			error = put_user(in_suspend, (unsigned int __user *)arg);
+		if (!error)
+			data->ready = 1;
+		break;
+
+	case SNAPSHOT_PLATFORM_RESTORE:
+		snapshot_write_finalize(&data->handle);
+		if (data->mode != O_WRONLY || !data->frozen ||
+		    !snapshot_image_loaded(&data->handle)) {
+			error = -EPERM;
+			break;
+		}
+		error = snapshot_restore(1);
+		break;
+
 	default:
 		error = -ENOTTY;
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
