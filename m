From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] Freezer: Return int from freeze_processes
Date: Sat, 26 May 2007 23:24:34 +0200
Message-ID: <200705262324.34869.rjw@sisk.pl>
References: <200705262317.48604.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705262317.48604.rjw@sisk.pl>
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
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make try_to_freeze_tasks() and freeze_processes() return -EBUSY on failure
instead of the number of unfrozen tasks (none of the callers actually uses this
number).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/process.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

Index: linux-2.6.22-rc2/kernel/power/process.c
===================================================================
--- linux-2.6.22-rc2.orig/kernel/power/process.c
+++ linux-2.6.22-rc2/kernel/power/process.c
@@ -105,7 +105,7 @@ static void cancel_freezing(struct task_
 	}
 }
 
-static unsigned int try_to_freeze_tasks(int freeze_user_space)
+static int try_to_freeze_tasks(int freeze_user_space)
 {
 	struct task_struct *g, *p;
 	unsigned long end_time;
@@ -175,28 +175,25 @@ static unsigned int try_to_freeze_tasks(
 		read_unlock(&tasklist_lock);
 	}
 
-	return todo;
+	return todo ? -EBUSY : 0;
 }
 
 /**
  *	freeze_processes - tell processes to enter the refrigerator
- *
- *	Returns 0 on success, or the number of processes that didn't freeze,
- *	although they were told to.
  */
 int freeze_processes(void)
 {
-	unsigned int nr_unfrozen;
+	int error;
 
 	printk("Stopping tasks ... ");
-	nr_unfrozen = try_to_freeze_tasks(FREEZER_USER_SPACE);
-	if (nr_unfrozen)
-		return nr_unfrozen;
+	error = try_to_freeze_tasks(FREEZER_USER_SPACE);
+	if (error)
+		return error;
 
 	sys_sync();
-	nr_unfrozen = try_to_freeze_tasks(FREEZER_KERNEL_THREADS);
-	if (nr_unfrozen)
-		return nr_unfrozen;
+	error = try_to_freeze_tasks(FREEZER_KERNEL_THREADS);
+	if (error)
+		return error;
 
 	printk("done.\n");
 	BUG_ON(in_atomic());
