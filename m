From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Tue, 5 Dec 2006 22:26:09 +0100
Message-ID: <200612052226.10540.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl> <20061205103429.GB5306@elf.ucw.cz>
	<200612052203.43977.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612052203.43977.rjw@sisk.pl>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 5 December 2006 22:03, Rafael J. Wysocki wrote:
> Okay, I have replaced my [1/2] with the patch below ...
> 
> On Tuesday, 5 December 2006 11:34, Pavel Machek wrote:
<--snip--> 
> ... and it fails to freeze processes if there's a stopped task (to verify,
> run vi, press ^Z, and try to suspend).
> 
> It happens because we shouldn't count the stopped task as freezeable any
> more after we've set PF_FREEZE for it and we can fix that by adding
> 
> 	if (p->state == TASK_STOPPED && freezing(p))
> 		continue;
> 
> to the main loop in try_to_freeze_tasks().  Then we obtain the appended patch.
> 
> <tests again>
> 
> Now the stopped task doesn't prevent us from freezing processes.  So far so
> good.

Unfortunately, after the resume the task that was stopped before the suspend
goes to the refrigerator as soon as it receives the continuation signal (to verify,
run vi, press ^Z, suspend, resume, type fg and look at the output of ps ax -
on another terminal, becase this one will be unuseable ;-)).

Hm.  It looks like we have to clear the freezing request for the stopped task
before we thaw the other processes, but there may be more stopped tasks,
so we need to add something like this:

	read_lock(&tasklist_lock);
	do_each_thread(g, p) {
		if (p->state == TASK_STOPPED && freezing(p))
			cancel_freezing(p);
	} while_each_thread(g, p);
	read_unlock(&tasklist_lock);

to thaw_processes().  It's cleaner to add it as an inline function, though,
and once we've done it, we get the appended patch.

<tests again>

Well, now the task that was stopped before the suspend doesn't go to the
refrigerator when it's received the continuation signal after the resume.
Good, but is it sufficient?  [To be continued.]


Index: linux-2.6.19-rc6-mm2/kernel/power/process.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/power/process.c	2006-12-05 21:10:00.000000000 +0100
+++ linux-2.6.19-rc6-mm2/kernel/power/process.c	2006-12-05 22:28:56.000000000 +0100
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
@@ -103,6 +102,9 @@ static unsigned int try_to_freeze_tasks(
 			if (frozen(p))
 				continue;
 
+			if (p->state == TASK_STOPPED && freezing(p))
+				continue;
+
 			if (p->state == TASK_TRACED &&
 			    (frozen(p->parent) ||
 			     p->parent->state == TASK_STOPPED)) {
@@ -185,6 +187,18 @@ int freeze_processes(void)
 	return 0;
 }
 
+static inline void release_stopped_tasks(void)
+{
+	struct task_struct *g, *p;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (p->state == TASK_STOPPED && freezing(p))
+			cancel_freezing(p);
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+}
+
 static void thaw_tasks(int thaw_user_space)
 {
 	struct task_struct *g, *p;
@@ -207,6 +221,7 @@ static void thaw_tasks(int thaw_user_spa
 void thaw_processes(void)
 {
 	printk("Restarting tasks ... ");
+	release_stopped_tasks();
 	thaw_tasks(FREEZER_KERNEL_THREADS);
 	thaw_tasks(FREEZER_USER_SPACE);
 	schedule();
Index: linux-2.6.19-rc6-mm2/kernel/signal.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/signal.c	2006-12-05 21:10:00.000000000 +0100
+++ linux-2.6.19-rc6-mm2/kernel/signal.c	2006-12-05 21:11:31.000000000 +0100
@@ -1829,7 +1829,9 @@ finish_stop(int stop_count)
 		read_unlock(&tasklist_lock);
 	}
 
-	schedule();
+	do {
+		schedule();
+	} while (try_to_freeze());
 	/*
 	 * Now we don't run again until continued.
 	 */

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
