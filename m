From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 2/3] Freezer: Measure the time of
	freezing tasks
Date: Wed, 1 Aug 2007 00:28:43 +0200
Message-ID: <200708010028.44511.rjw@sisk.pl>
References: <200707251401.48340.rjw@sisk.pl> <20070731100254.GC3462@elf.ucw.cz>
	<200708010025.27018.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708010025.27018.rjw@sisk.pl>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andres Salomon <dilinger@debian.org>, linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, David Woodhouse <dwmw2@infradead.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Measure the time of the freezing of tasks, even if it doesn't fail.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/process.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)
---
Index: linux-2.6.23-rc1/kernel/power/process.c
===================================================================
--- linux-2.6.23-rc1.orig/kernel/power/process.c	2007-07-31 23:00:43.000000000 +0200
+++ linux-2.6.23-rc1/kernel/power/process.c	2007-07-31 23:00:52.000000000 +0200
@@ -190,6 +190,11 @@ static int try_to_freeze_tasks(int freez
 	struct task_struct *g, *p;
 	unsigned long end_time;
 	unsigned int todo;
+	struct timeval start, end;
+	s64 elapsed_csecs64;
+	unsigned int elapsed_csecs;
+
+	do_gettimeofday(&start);
 
 	end_time = jiffies + TIMEOUT;
 	refrigerator_called = 0;
@@ -226,6 +231,11 @@ static int try_to_freeze_tasks(int freez
 			break;
 	} while (todo);
 
+	do_gettimeofday(&end);
+	elapsed_csecs64 = timeval_to_ns(&end) - timeval_to_ns(&start);
+	do_div(elapsed_csecs64, NSEC_PER_SEC / 100);
+	elapsed_csecs = elapsed_csecs64;
+
 	if (todo) {
 		/* This does not unfreeze processes that are already frozen
 		 * (we have slightly ugly calling convention in that respect,
@@ -233,10 +243,9 @@ static int try_to_freeze_tasks(int freez
 		 * but it cleans up leftover PF_FREEZE requests.
 		 */
 		printk("\n");
-		printk(KERN_ERR "Freezing of %s timed out after %d seconds "
+		printk(KERN_ERR "Freezing of tasks failed after %d.%d seconds "
 				"(%d tasks refusing to freeze):\n",
-				freeze_user_space ? "user space " : "tasks ",
-				TIMEOUT / HZ, todo);
+				elapsed_csecs / 100, elapsed_csecs % 100, todo);
 		show_state();
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
@@ -247,6 +256,9 @@ static int try_to_freeze_tasks(int freez
 			task_unlock(p);
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
+	} else {
+		printk("(elapsed %d.%d seconds) ", elapsed_csecs / 100,
+			elapsed_csecs % 100);
 	}
 
 	return todo ? -EBUSY : 0;
