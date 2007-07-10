From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC][PATCH -mm 5/6] Freezer: Use freezing timeout
	more efficiently
Date: Tue, 10 Jul 2007 12:04:42 +0200
Message-ID: <200707101204.42687.rjw@sisk.pl>
References: <200707092229.08898.rjw@sisk.pl> <20070709233414.GI1967@elf.ucw.cz>
	<200707100809.38466.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707100809.38466.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Oleg Nesterov <oleg@tv-sign.ru>, Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 10 July 2007 08:09, Rafael J. Wysocki wrote:
> On Tuesday, 10 July 2007 01:34, Pavel Machek wrote:
> > Hi!
> > 
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > The freezer fails if there are uninterruptible tasks waiting for some frozen
> > > tasks to let them continue.  Moreover, in that case try_to_freeze_tasks() loops
> > > uselessly until the timeout expires which is wasteful, so in principle we should
> > > make the freezer fail as soon as all the tasks that refuse to freeze are
> > > uninterruptible.  However, instead of failing the freezer we can try to use the
> > > time left and thaw the tasks that have already been frozen without
> > > clearing the
> > 
> > No, we can't do that:
> > 
> > Imagine we have single uninterruptible task that waits for disk. It
> > would exit uninterruptible state in 10msec, *but* you give up and
> > unfreeze all. Now, another task goes uninterruptible waiting for
> > disk and situation repeats. Livelock.
> 
> For how many times would that have to repeat before 30s of timeout expires?
> 
> Sorry, but I don't buy this argument. :-)
> 
> > Yes, this might play with races in interresting ways and help fuse,
> > but we do not want the livelock in the first place.
> 
> I think that the "livelock" will never happen.
> 
> Besides, we can add another timeout for breaking the loop from a "locked up"
> state.

Actually I like this idea. :-)

I have updated the patch to use the additional timeout, please have a look
(below).

Greetings,
Rafael


---
From: Rafael J. Wysocki <rjw@sisk.pl>

There is the problem with try_to_freeze_tasks() that it always loops until the
timeout expires, even if it is certain to fail much earlier.  Namely, if there
are uninterruptible tasks waiting for some frozen tasks to let them continue,
try_to_freeze_tasks() will certainly fail and it shouldn't waste time in that
cases.

To detect such situations, we can count the number of tasks that haven't been
frozen yet and the number of uninterruptible tasks among them.  If these two
numbers haven't been changing for sufficiently long time and are equal, then
most probably some uninterruptible tasks are blocked by some frozen tasks and we
should break out of this deadlock.  Thus, it seems reasonable to thaw the tasks
that have already been frozen without clearing the freeze requests of the tasks
that are refusing to freeze.  This way, if these tasks are really blocked by the
frozen ones, they will get extra chance to freeze themselves after we have
thawed the other tasks.  Next, we should repeat the freezing loop and so on,
until the timeout expires.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/process.c |   88 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 13 deletions(-)

Index: linux-2.6.22-rc6-mm1/kernel/power/process.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/kernel/power/process.c
+++ linux-2.6.22-rc6-mm1/kernel/power/process.c
@@ -14,10 +14,11 @@
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
 
-/* 
- * Timeout for stopping processes
- */
-#define TIMEOUT	(20 * HZ)
+/* Timeout for the freezing of tasks */
+#define TIMEOUT	(30 * HZ)
+
+/* Timeout for breaking the freezing loop if lock-up state is detected */
+#define BREAK_TIMEOUT	(HZ / 10)
 
 #define FREEZER_KERNEL_THREADS 0
 #define FREEZER_USER_SPACE 1
@@ -172,15 +173,33 @@ static void cancel_freezing(struct task_
 	}
 }
 
+/**
+ *	try_to_freeze_tasks - send freeze requests to all tasks and wait for
+ *		for them to enter the refrigerator
+ *	@freeze_user_space - if set, only tasks that have mm of their own are
+ *		requested to freeze
+ *
+ *	If this function fails, thaw_tasks() must be called to do the cleanup.
+ */
+
 static int try_to_freeze_tasks(int freeze_user_space)
 {
 	struct task_struct *g, *p;
-	unsigned long end_time;
-	unsigned int todo;
+	unsigned long end_time, break_time;
+	unsigned int todo, blocking, prev_blocking;
+	unsigned int i = 0;
+	char *tick = "-\\|/";
+
+	printk(" ");
 
 	end_time = jiffies + TIMEOUT;
+ Repeat:
+	break_time = 0;
+	blocking = 0;
 	do {
 		todo = 0;
+		prev_blocking = blocking;
+		blocking = 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			if (frozen(p) || !freezeable(p))
@@ -197,25 +216,68 @@ static int try_to_freeze_tasks(int freez
 			} else {
 				freeze_task(p);
 			}
-			if (!freezer_should_skip(p))
+			if (!freezer_should_skip(p)) {
 				todo++;
+				if (freeze_user_space &&
+				    (p->state == TASK_UNINTERRUPTIBLE))
+					blocking++;
+			}
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
+
 		yield();			/* Yield is okay here */
+
 		if (time_after(jiffies, end_time))
 			break;
+
+		/*
+		 * Check if we are making or we are likely to make any progress.
+		 * If not, we should better break out of this.
+		 */
+		if (todo && todo == blocking && blocking == prev_blocking) {
+			if (!break_time)
+				break_time = jiffies + BREAK_TIMEOUT;
+			else if (time_after(jiffies, break_time))
+				break;
+		} else {
+			break_time = 0;
+		}
 	} while (todo);
 
+	if (todo && freeze_user_space && !time_after(jiffies, end_time)) {
+		/*
+		 * Some tasks have not been able to freeze.  They might be stuck
+		 * in TASK_UNINTERRUPTIBLE waiting for the frozen tasks.  Try to
+		 * thaw the tasks that have frozen without clearing the freeze
+		 * requests of the remaining tasks and repeat.
+		 */
+		read_lock(&tasklist_lock);
+		do_each_thread(g, p) {
+			if (frozen(p)) {
+				p->flags &= ~PF_FROZEN;
+				wake_up_process(p);
+			}
+		} while_each_thread(g, p);
+		read_unlock(&tasklist_lock);
+
+		yield();
+
+		printk("\b%c", tick[i++%4]);
+
+		goto Repeat;
+	}
+
+	printk("\b");
+
 	if (todo) {
-		/* This does not unfreeze processes that are already frozen
-		 * (we have slightly ugly calling convention in that respect,
-		 * and caller must call thaw_processes() if something fails),
-		 * but it cleans up leftover PF_FREEZE requests.
+		/*
+		 * The freezing of tasks has failed.  List the tasks that have
+		 * refused to freeze.  This also clears all pending freeze
+		 * requests.
 		 */
 		printk("\n");
-		printk(KERN_ERR "Freezing of %s timed out after %d seconds "
+		printk(KERN_ERR "Freezing of tasks timed out after %d seconds "
 				"(%d tasks refusing to freeze):\n",
-				freeze_user_space ? "user space " : "tasks ",
 				TIMEOUT / HZ, todo);
 		show_state();
 		read_lock(&tasklist_lock);
