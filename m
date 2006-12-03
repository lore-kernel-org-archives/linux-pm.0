From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 1/2]: PM: Fix handling of stopped tasks
Date: Sun, 3 Dec 2006 23:50:22 +0100
Message-ID: <200612032350.23067.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612032318.29030.rjw@sisk.pl>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Stephen Hemminger <shemminger@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Currently, if a task is stopped (ie. it's in the TASK_STOPPED state), it is
considered by the freezer as unfreezeable.  However, there may be a race
between the freezer and the delivery of the continuation signal to the task
resulting in the task running after we have finished freezing other tasks.
This, in turn, may lead to undesirable effects up to and including a
corruption of data.

To prevent this from happening we first need to make the freezer consider
stopped tasks as freezeable.  For this purpose we need to make freezeable()
stop returning 0 for these tasks.  We must remember, however, that the
stopped tasks need not receive the continuation signal before thaw_processes()
is called, so as soon as PF_FREEZE is set for them try_to_freeze_tasks()
should stop counting them as the ones to wait for.  Additionally, if there's a
traced task (ie. a task in the TASK_TRACED state) the parent of which has
PF_FREEZE set and is stopped, try_to_freeze_tasks() should not wait for it.
Moreover, if there are some stopped tasks that haven't received the continuation
signal before thaw_processes() is called, we must clear PF_FREEZE for them so
that they don't go to the refrigerator when it's no longer desirable.

Still if a stopped tasks receives the continuation signal after the freezer
has returned, it should immediately go to the refrigerator.  For this reason
we need to place the call to try_to_freeze() in get_signal_to_deliver() right
after the relock label.

It is also reasonable to change the error paths so that the names of stopped
or traced tasks which have not frozen are not reported to the user, because in
the majority of cases they would be false positives.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/process.c |   36 ++++++++++++++++++++++++++++++------
 kernel/signal.c        |    2 +-
 2 files changed, 31 insertions(+), 7 deletions(-)

Index: linux-2.6.19-rc6-mm2/kernel/power/process.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/power/process.c
+++ linux-2.6.19-rc6-mm2/kernel/power/process.c
@@ -28,8 +28,7 @@ static inline int freezeable(struct task
 	if ((p == current) || 
 	    (p->flags & PF_NOFREEZE) ||
 	    (p->exit_state == EXIT_ZOMBIE) ||
-	    (p->exit_state == EXIT_DEAD) ||
-	    (p->state == TASK_STOPPED))
+	    (p->exit_state == EXIT_DEAD))
 		return 0;
 	return 1;
 }
@@ -81,6 +80,11 @@ static void cancel_freezing(struct task_
 	}
 }
 
+static inline int stopped_and_freezing(struct task_struct *p)
+{
+	return p->state == TASK_STOPPED && freezing(p);
+}
+
 static inline int is_user_space(struct task_struct *p)
 {
 	return p->mm && !(p->flags & PF_BORROWED_MM);
@@ -103,9 +107,11 @@ static unsigned int try_to_freeze_tasks(
 			if (frozen(p))
 				continue;
 
-			if (p->state == TASK_TRACED &&
-			    (frozen(p->parent) ||
-			     p->parent->state == TASK_STOPPED)) {
+			if (stopped_and_freezing(p))
+				continue;
+
+			if (p->state == TASK_TRACED && (frozen(p->parent) ||
+			    stopped_and_freezing(p->parent))) {
 				cancel_freezing(p);
 				continue;
 			}
@@ -149,7 +155,8 @@ static unsigned int try_to_freeze_tasks(
 			if (is_user_space(p) == !freeze_user_space)
 				continue;
 
-			if (freezeable(p) && !frozen(p))
+			if (freezeable(p) && !frozen(p) &&
+			    p->state != TASK_STOPPED && p->state != TASK_TRACED)
 				printk(KERN_ERR " %s\n", p->comm);
 
 			cancel_freezing(p);
@@ -185,6 +192,18 @@ int freeze_processes(void)
 	return 0;
 }
 
+static void release_stopped_tasks(void)
+{
+	struct task_struct *g, *p;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (stopped_and_freezing(p))
+			cancel_freezing(p);
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+}
+
 static void thaw_tasks(int thaw_user_space)
 {
 	struct task_struct *g, *p;
@@ -197,6 +216,10 @@ static void thaw_tasks(int thaw_user_spa
 		if (is_user_space(p) == !thaw_user_space)
 			continue;
 
+		if (!frozen(p) &&
+		    (p->state == TASK_STOPPED || p->state == TASK_TRACED))
+			continue;
+
 		if (!thaw_process(p))
 			printk(KERN_WARNING " Strange, %s not stopped\n",
 				p->comm );
@@ -207,6 +230,7 @@ static void thaw_tasks(int thaw_user_spa
 void thaw_processes(void)
 {
 	printk("Restarting tasks ... ");
+	release_stopped_tasks();
 	thaw_tasks(FREEZER_KERNEL_THREADS);
 	thaw_tasks(FREEZER_USER_SPACE);
 	schedule();
Index: linux-2.6.19-rc6-mm2/kernel/signal.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/signal.c
+++ linux-2.6.19-rc6-mm2/kernel/signal.c
@@ -1937,9 +1937,9 @@ int get_signal_to_deliver(siginfo_t *inf
 	sigset_t *mask = &current->blocked;
 	int signr = 0;
 
+relock:
 	try_to_freeze();
 
-relock:
 	spin_lock_irq(&current->sighand->siglock);
 	for (;;) {
 		struct k_sigaction *ka;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
