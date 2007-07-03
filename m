From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 00:33:15 +0200
Message-ID: <200707040033.16819.rjw__1630.0123687417$1183501848$gmane$org@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707032259.59714.rjw@sisk.pl>
	<1183498518.3388.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183498518.3388.12.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 3 July 2007 23:35, Benjamin Herrenschmidt wrote:
> 
> > I don't think that would matter.
> > 
> > Still, I can remove the sync from the suspend code path only, leaving it in
> > the hibernation code path.  The patch will be bigger, but well.
> > 
> > Any objection to that?
> 
> Makes sense to sync before suspend tho, to limit the amount of dirty
> non-written pages in case things go wrong.

OK, below is the updated patch.

Greetings,
Rafael


---
From: Rafael J. Wysocki <rjw@sisk.pl>

The syncing of filesystems from within the freezer in not needed for suspend to
RAM and leads to problems with FUSE.  Change freeze_processes() so that it
doesn't execute sys_sync() and introduce the "syncing" version of it to be
called from the hibernation code paths.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/freezer.h |   14 ++++++++++++--
 kernel/power/disk.c     |    2 +-
 kernel/power/main.c     |    6 ++++++
 kernel/power/process.c  |    8 +++++---
 kernel/power/user.c     |    2 +-
 5 files changed, 25 insertions(+), 7 deletions(-)

Index: linux-2.6.22-rc7/include/linux/freezer.h
===================================================================
--- linux-2.6.22-rc7.orig/include/linux/freezer.h	2007-07-04 00:21:26.000000000 +0200
+++ linux-2.6.22-rc7/include/linux/freezer.h	2007-07-04 00:22:37.000000000 +0200
@@ -62,7 +62,7 @@ static inline int thaw_process(struct ta
 }
 
 extern void refrigerator(void);
-extern int freeze_processes(void);
+extern int __freeze_processes(int sync_filesystems);
 extern void thaw_processes(void);
 
 static inline int try_to_freeze(void)
@@ -134,7 +134,7 @@ static inline void clear_freeze_flag(str
 static inline int thaw_process(struct task_struct *p) { return 1; }
 
 static inline void refrigerator(void) {}
-static inline int freeze_processes(void) { BUG(); return 0; }
+static inline int __freeze_processes(int s) { BUG(); return 0; }
 static inline void thaw_processes(void) {}
 
 static inline int try_to_freeze(void) { return 0; }
@@ -145,4 +145,14 @@ static inline int freezer_should_skip(st
 static inline void set_freezable(void) {}
 #endif
 
+static inline int freeze_processes(void)
+{
+	return __freeze_processes(0);
+}
+
+static inline int freeze_processes_with_sync(void)
+{
+	return __freeze_processes(1);
+}
+
 #endif	/* FREEZER_H_INCLUDED */
Index: linux-2.6.22-rc7/kernel/power/disk.c
===================================================================
--- linux-2.6.22-rc7.orig/kernel/power/disk.c	2007-07-04 00:21:26.000000000 +0200
+++ linux-2.6.22-rc7/kernel/power/disk.c	2007-07-04 00:21:44.000000000 +0200
@@ -281,7 +281,7 @@ static int prepare_processes(void)
 	int error = 0;
 
 	pm_prepare_console();
-	if (freeze_processes()) {
+	if (freeze_processes_with_sync()) {
 		error = -EBUSY;
 		unprepare_processes();
 	}
Index: linux-2.6.22-rc7/kernel/power/main.c
===================================================================
--- linux-2.6.22-rc7.orig/kernel/power/main.c	2007-07-04 00:21:26.000000000 +0200
+++ linux-2.6.22-rc7/kernel/power/main.c	2007-07-04 00:23:40.000000000 +0200
@@ -20,6 +20,7 @@
 #include <linux/resume-trace.h>
 #include <linux/freezer.h>
 #include <linux/vmstat.h>
+#include <linux/syscalls.h>
 
 #include "power.h"
 
@@ -231,6 +232,11 @@ static int enter_state(suspend_state_t s
 
 	if (!valid_state(state))
 		return -ENODEV;
+
+	printk("Syncing filesystems ... ");
+	sys_sync();
+	printk("done.\n");
+
 	if (!mutex_trylock(&pm_mutex))
 		return -EBUSY;
 
Index: linux-2.6.22-rc7/kernel/power/process.c
===================================================================
--- linux-2.6.22-rc7.orig/kernel/power/process.c	2007-07-04 00:21:26.000000000 +0200
+++ linux-2.6.22-rc7/kernel/power/process.c	2007-07-04 00:21:44.000000000 +0200
@@ -179,9 +179,9 @@ static int try_to_freeze_tasks(int freez
 }
 
 /**
- *	freeze_processes - tell processes to enter the refrigerator
+ *	__freeze_processes - tell processes to enter the refrigerator
  */
-int freeze_processes(void)
+int __freeze_processes(int sync_filesystems)
 {
 	int error;
 
@@ -190,7 +190,9 @@ int freeze_processes(void)
 	if (error)
 		return error;
 
-	sys_sync();
+	if (sync_filesystems)
+		sys_sync();
+
 	error = try_to_freeze_tasks(FREEZER_KERNEL_THREADS);
 	if (error)
 		return error;
Index: linux-2.6.22-rc7/kernel/power/user.c
===================================================================
--- linux-2.6.22-rc7.orig/kernel/power/user.c	2007-07-04 00:21:26.000000000 +0200
+++ linux-2.6.22-rc7/kernel/power/user.c	2007-07-04 00:21:44.000000000 +0200
@@ -153,7 +153,7 @@ static int snapshot_ioctl(struct inode *
 		mutex_lock(&pm_mutex);
 		error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
 		if (!error) {
-			error = freeze_processes();
+			error = freeze_processes_with_sync();
 			if (error)
 				thaw_processes();
 		}
