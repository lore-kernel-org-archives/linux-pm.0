From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/5] PM: Make freeze_processes
	SMP-safe
Date: Thu, 30 Nov 2006 16:07:04 +0100
Message-ID: <200611301607.05122.rjw@sisk.pl>
References: <200611252210.58203.rjw@sisk.pl> <20061129235523.GA1952@elf.ucw.cz>
	<200611300121.53975.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200611300121.53975.rjw@sisk.pl>
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
To: suspend-devel@lists.sourceforge.net
Cc: pm list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thursday, 30 November 2006 01:21, Rafael J. Wysocki wrote:
> On Thursday, 30 November 2006 00:55, Pavel Machek wrote:
> > Hi!
> > 
> > > > > I do not like the counting idea; it should be simpler to just check if
> > > > > all the processes are still stopped.
> > > > 
> > > > I thought about that but didn't invent anything reasonable enough.
> > > > 
> > > > > But I'm not sure if this is enough. What if signal is being delivered
> > > > > on another CPU while freezing, still being delivered while this second
> > > > > check runs, and then SIGCONT is delivered? 
> > > > 
> > > > Hm, is this possible in practice?  I mean, if todo is 0 and nr_stopped doesn't
> > > > change, then there are no processes that can send the SIGCONT (unless someone
> > > > creates a kernel thread with PF_NOFREEZE that will do just that).
> > > > 
> > > > Anyway, for now I've no idea how to fix this properly.  Will think about it
> > > > tomorrow.
> > > 
> > > As far as this particular problem is concerned, I think there are two possible
> > > solutions.
> > > 
> > > One of them would be do disable the delivery of continuation signals before
> > > we start freezing processes, but I don't know how to do this exactly so that
> > > it's not racy.  Also it would be quite intrusive.
> > > 
> > > The other one may be something along with the lines of the appended patch.
> > 
> > There has to be a better solution. Stopped tasks are suspended
> > somewhere in kernel, right? One try_to_freeze() and problem should be
> > solved, in regular way, and without tricks...?
> 
> Why?  _This_ is a regular way, IMHO.
> 
> The problem is that stopped tasks aren't actually running (obviously) so they
> _can't_ execute try_to_freeze() until someone sends them a signal.  However,
> once they actually have received the signal, we want them to freeze, so we
> must tell them to do so.  Still, if they don't receive the signal, we want them
> to stay stopped (IOW, the freezer by itself should not wake them up).

<--snip-->

In fact, I really mean that if we want a process to go to the refrigerator, we
have to set PF_FREEZE for it (otherwise try_to_freeze() won't do anytning).
Thus because we want stopped processes to go to the refrigerator once they
have received the continuation signal, we have to set PF_FREEZE for them,
so we should call either freeze_process() or just freeze() for them.

Now once we have set PF_FREEZE for a stopped process, we shouldn't count
it as freezeable any more, because we can't do anything more with it.
Moreover, if the process hasn't received the continuation signal before we
call freeze_processes(), PF_FREEZE set will still be set for it, so we have to
clear it (otherwise the process would go to the refrigerator as soon as it
receives the continuation signal).

Now the question remains if we should call the entire freeze_process() or just
freeze() for stopped tasks and I think it really doesn't matter.  Still, since we
call recalc_sigpending() in the refrigerator, I think it's reasonable to use
freeze_process() in this case (less lines of code).

Additionally, we can move the try_to_freeze() in get_signal_to_deliver() so
that processes receiving continuation signals are frozen immediately rather
than some time later, but this doesn't really change the rest of the patch
(which follows - untested for now, but I'll test it later today).

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/process.c |   41 +++++++++++++++++++++++++++++++++++------
 kernel/signal.c        |    2 +-
 2 files changed, 36 insertions(+), 7 deletions(-)

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
@@ -81,11 +80,21 @@ static void cancel_freezing(struct task_
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
 }
 
+static inline int unfrozen_stopped_or_traced(struct task_struct *p)
+{
+	return ;
+}
+
 static unsigned int try_to_freeze_tasks(int freeze_user_space)
 {
 	struct task_struct *g, *p;
@@ -103,9 +112,11 @@ static unsigned int try_to_freeze_tasks(
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
@@ -149,7 +160,8 @@ static unsigned int try_to_freeze_tasks(
 			if (is_user_space(p) == !freeze_user_space)
 				continue;
 
-			if (freezeable(p) && !frozen(p))
+			if (freezeable(p) && !frozen(p) &&
+			    p->state != TASK_STOPPED && p->state != TASK_TRACED)
 				printk(KERN_ERR " %s\n", p->comm);
 
 			cancel_freezing(p);
@@ -185,6 +197,18 @@ int freeze_processes(void)
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
@@ -197,6 +221,10 @@ static void thaw_tasks(int thaw_user_spa
 		if (is_user_space(p) == !thaw_user_space)
 			continue;
 
+		if (!frozen(p) &&
+		    (p->state == TASK_STOPPED || p->state == TASK_TRACED))
+			continue;
+
 		if (!thaw_process(p))
 			printk(KERN_WARNING " Strange, %s not stopped\n",
 				p->comm );
@@ -207,6 +235,7 @@ static void thaw_tasks(int thaw_user_spa
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
