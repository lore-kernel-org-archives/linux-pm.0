From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 1/6] Freezer: Do not sync filesystems
Date: Mon, 9 Jul 2007 22:31:45 +0200
Message-ID: <200707092231.46808.rjw@sisk.pl>
References: <200707092229.08898.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707092229.08898.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The syncing of filesystems from within the freezer is generally not needed.
Also, if FUSE implements sync, this will cause the freezer to deadlock with it.

Change freeze_processes() so that it doesn't execute sys_sync() and make the
suspend and hibernation code path sync filesystems independently of the freezer.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c    |    4 ++++
 kernel/power/main.c    |    6 ++++++
 kernel/power/process.c |    1 -
 kernel/power/user.c    |    4 ++++
 4 files changed, 14 insertions(+), 1 deletion(-)

Index: linux-2.6.22-rc6-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/kernel/power/disk.c
+++ linux-2.6.22-rc6-mm1/kernel/power/disk.c
@@ -297,6 +297,10 @@ int hibernate(void)
 	if (error)
 		goto Exit;
 
+	printk("Syncing filesystems ... ");
+	sys_sync();
+	printk("done.\n");
+
 	error = prepare_processes();
 	if (error)
 		goto Finish;
Index: linux-2.6.22-rc6-mm1/kernel/power/main.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/kernel/power/main.c
+++ linux-2.6.22-rc6-mm1/kernel/power/main.c
@@ -20,6 +20,7 @@
 #include <linux/resume-trace.h>
 #include <linux/freezer.h>
 #include <linux/vmstat.h>
+#include <linux/syscalls.h>
 
 #include "power.h"
 
@@ -234,9 +235,14 @@ static int enter_state(suspend_state_t s
 
 	if (!valid_state(state))
 		return -ENODEV;
+
 	if (!mutex_trylock(&pm_mutex))
 		return -EBUSY;
 
+	printk("Syncing filesystems ... ");
+	sys_sync();
+	printk("done.\n");
+
 	pr_debug("PM: Preparing system for %s sleep\n", pm_states[state]);
 	if ((error = suspend_prepare()))
 		goto Unlock;
Index: linux-2.6.22-rc6-mm1/kernel/power/process.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/kernel/power/process.c
+++ linux-2.6.22-rc6-mm1/kernel/power/process.c
@@ -191,7 +191,6 @@ int freeze_processes(void)
 	if (error)
 		return error;
 
-	sys_sync();
 	error = try_to_freeze_tasks(FREEZER_KERNEL_THREADS);
 	if (error)
 		return error;
Index: linux-2.6.22-rc6-mm1/kernel/power/user.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/kernel/power/user.c
+++ linux-2.6.22-rc6-mm1/kernel/power/user.c
@@ -153,6 +153,10 @@ static int snapshot_ioctl(struct inode *
 		mutex_lock(&pm_mutex);
 		error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
 		if (!error) {
+			printk("Syncing filesystems ... ");
+			sys_sync();
+			printk("done.\n");
+
 			error = freeze_processes();
 			if (error)
 				thaw_processes();
