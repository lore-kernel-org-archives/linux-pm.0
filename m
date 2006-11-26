From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/5] PM: Make freeze_processes
	SMP-safe
Date: Sun, 26 Nov 2006 14:34:17 +0100
Message-ID: <200611261434.18427.rjw@sisk.pl>
References: <200611252210.58203.rjw@sisk.pl> <200611261102.17091.rjw@sisk.pl>
	<200611261215.14326.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200611261215.14326.rjw@sisk.pl>
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
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Sunday, 26 November 2006 12:15, Rafael J. Wysocki wrote:
> On Sunday, 26 November 2006 11:02, Rafael J. Wysocki wrote:
> > On Sunday, 26 November 2006 08:47, Pavel Machek wrote:
<--snip--> 
> > Okay, I'll use atomic_t.
> 
> Patch with atomic_t follows.
> 
> The atomic_set(..., 0) are used to avoid the (theoretical) situation in which
> freezing might be decreased twice in a row and I've decided to explicitly
> initialize freezing in fork.c for clarity.

I've just realized that there is a race in freeze_process() where we should
check if the proces hasn't been frozen already (the process may have entered
the refrigerator and reset 'freezing' after we checked its PF_FROZEN flag,
so we have to check if PF_FROZEN is set for the process before we
set 'freezing' for it).  Since an explicit memory barrier is needed here, it
seems reasonable to add one in frozen_process() as well.

Also, it seems to me that stopped processes require special treatment.
Namely, one or more of them might receive the continuation signal after
we check their states in try_to_freeze_tasks() so we should make sure this
hasn't happened before we break the main loop in there.

Revised patch follows.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/freezer.h |   11 ++++++-----
 include/linux/sched.h   |    4 +++-
 kernel/fork.c           |    4 ++++
 kernel/power/process.c  |   36 +++++++++++++++++++++++++++++-------
 4 files changed, 42 insertions(+), 13 deletions(-)

Index: linux-2.6.19-rc6-mm1/include/linux/freezer.h
===================================================================
--- linux-2.6.19-rc6-mm1.orig/include/linux/freezer.h	2006-11-26 11:31:39.000000000 +0100
+++ linux-2.6.19-rc6-mm1/include/linux/freezer.h	2006-11-26 14:07:03.000000000 +0100
@@ -14,16 +14,15 @@ static inline int frozen(struct task_str
  */
 static inline int freezing(struct task_struct *p)
 {
-	return p->flags & PF_FREEZE;
+	return !!atomic_read(&p->freezing);
 }
 
 /*
  * Request that a process be frozen
- * FIXME: SMP problem. We may not modify other process' flags!
  */
 static inline void freeze(struct task_struct *p)
 {
-	p->flags |= PF_FREEZE;
+	atomic_inc(&p->freezing);
 }
 
 /*
@@ -31,7 +30,7 @@ static inline void freeze(struct task_st
  */
 static inline void do_not_freeze(struct task_struct *p)
 {
-	p->flags &= ~PF_FREEZE;
+	atomic_set(&p->freezing, 0);
 }
 
 /*
@@ -52,7 +51,9 @@ static inline int thaw_process(struct ta
  */
 static inline void frozen_process(struct task_struct *p)
 {
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
+	p->flags |= PF_FROZEN;
+	wmb();
+	atomic_set(&p->freezing, 0);
 }
 
 extern void refrigerator(void);
Index: linux-2.6.19-rc6-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.19-rc6-mm1.orig/include/linux/sched.h	2006-11-26 11:31:39.000000000 +0100
+++ linux-2.6.19-rc6-mm1/include/linux/sched.h	2006-11-26 11:33:29.000000000 +0100
@@ -1065,6 +1065,9 @@ struct task_struct {
 #ifdef	CONFIG_TASK_DELAY_ACCT
 	struct task_delay_info *delays;
 #endif
+#ifdef CONFIG_PM
+	atomic_t freezing;	/* if set, we should be freezing for suspend */
+#endif
 #ifdef CONFIG_FAULT_INJECTION
 	int make_it_fail;
 #endif
@@ -1161,7 +1164,6 @@ static inline void put_task_struct(struc
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
 #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
-#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
Index: linux-2.6.19-rc6-mm1/kernel/fork.c
===================================================================
--- linux-2.6.19-rc6-mm1.orig/kernel/fork.c	2006-11-25 21:26:52.000000000 +0100
+++ linux-2.6.19-rc6-mm1/kernel/fork.c	2006-11-26 11:45:00.000000000 +0100
@@ -1097,6 +1097,10 @@ static struct task_struct *copy_process(
 	p->blocked_on = NULL; /* not blocked yet */
 #endif
 
+#ifdef CONFIG_PM
+	atomic_set(&p->freezing, 0);
+#endif
+
 	p->tgid = p->pid;
 	if (clone_flags & CLONE_THREAD)
 		p->tgid = current->tgid;
Index: linux-2.6.19-rc6-mm1/kernel/power/process.c
===================================================================
--- linux-2.6.19-rc6-mm1.orig/kernel/power/process.c	2006-11-25 21:26:52.000000000 +0100
+++ linux-2.6.19-rc6-mm1/kernel/power/process.c	2006-11-26 14:17:11.000000000 +0100
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
@@ -61,10 +60,13 @@ static inline void freeze_process(struct
 	unsigned long flags;
 
 	if (!freezing(p)) {
-		freeze(p);
-		spin_lock_irqsave(&p->sighand->siglock, flags);
-		signal_wake_up(p, 0);
-		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		rmb();
+		if (!frozen(p)) {
+			freeze(p);
+			spin_lock_irqsave(&p->sighand->siglock, flags);
+			signal_wake_up(p, 0);
+			spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		}
 	}
 }
 
@@ -90,11 +92,12 @@ static unsigned int try_to_freeze_tasks(
 {
 	struct task_struct *g, *p;
 	unsigned long end_time;
-	unsigned int todo;
+	unsigned int todo, nr_stopped;
 
 	end_time = jiffies + TIMEOUT;
 	do {
 		todo = 0;
+		nr_stopped = 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			if (!freezeable(p))
@@ -103,6 +106,10 @@ static unsigned int try_to_freeze_tasks(
 			if (frozen(p))
 				continue;
 
+			if (p->state == TASK_STOPPED) {
+				nr_stopped++;
+				continue;
+			}
 			if (p->state == TASK_TRACED &&
 			    (frozen(p->parent) ||
 			     p->parent->state == TASK_STOPPED)) {
@@ -128,6 +135,21 @@ static unsigned int try_to_freeze_tasks(
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
 		yield();			/* Yield is okay here */
+		if (!todo) {
+			/* Make sure that none of the stopped processes has
+			 * received the continuation signal after we checked
+			 * last time.
+			 */
+			todo = nr_stopped;
+			nr_stopped = 0;
+			read_lock(&tasklist_lock);
+			do_each_thread(g, p) {
+				if (p->state == TASK_STOPPED)
+					nr_stopped++;
+			} while_each_thread(g, p);
+			read_unlock(&tasklist_lock);
+			todo -= nr_stopped;
+		}
 		if (todo && time_after(jiffies, end_time))
 			break;
 	} while (todo);

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
