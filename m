From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Sun, 10 Dec 2006 12:26:08 +0100
Message-ID: <200612101226.09452.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl> <20061208112123.GA4957@ucw.cz>
	<200612081249.48218.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612081249.48218.rjw@sisk.pl>
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
Cc: David Brownell <david-b@pacbell.net>, pm list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Friday, 8 December 2006 12:49, Rafael J. Wysocki wrote:
> On Friday, 8 December 2006 12:21, Pavel Machek wrote:
> > Hi!
> > 
<--snip--> 
> > In the meantime, perhaps we want 2/2 merged? That one was
> > safe&obvious.
> 
> Sort of.  Except I still don't know which architectures are supposed to use
> the freezer ...

I think it's reasonable to define TIF_FREEZE for the architectures that
include kernel/power/Kconfig into their Kconfigs. :-)

The appended patch does this (applies on top of
http://lists.osdl.org/pipermail/linux-pm/2006-December/004307.html).

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/asm-arm/thread_info.h     |    2 ++
 include/asm-frv/thread_info.h     |    2 ++
 include/asm-i386/thread_info.h    |    2 ++
 include/asm-ia64/thread_info.h    |    2 ++
 include/asm-powerpc/thread_info.h |    2 ++
 include/asm-sh/thread_info.h      |    2 ++
 include/asm-x86_64/thread_info.h  |    2 ++
 include/linux/freezer.h           |   11 ++++++-----
 include/linux/sched.h             |    1 -
 kernel/power/process.c            |   17 ++++++++++-------
 10 files changed, 30 insertions(+), 13 deletions(-)

Index: linux-2.6.19-rc6-mm2/include/asm-arm/thread_info.h
===================================================================
--- linux-2.6.19-rc6-mm2.orig/include/asm-arm/thread_info.h
+++ linux-2.6.19-rc6-mm2/include/asm-arm/thread_info.h
@@ -137,6 +137,7 @@ extern void iwmmxt_task_switch(struct th
 #define TIF_POLLING_NRFLAG	16
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18
+#define TIF_FREEZE		19
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -144,6 +145,7 @@ extern void iwmmxt_task_switch(struct th
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
+#define _TIF_FREEZE		(1 << TIF_FREEZE)
 
 /*
  * Change these and you break ASM code in entry-common.S
Index: linux-2.6.19-rc6-mm2/include/asm-ia64/thread_info.h
===================================================================
--- linux-2.6.19-rc6-mm2.orig/include/asm-ia64/thread_info.h
+++ linux-2.6.19-rc6-mm2/include/asm-ia64/thread_info.h
@@ -88,6 +88,7 @@ struct thread_info {
 #define TIF_MEMDIE		17
 #define TIF_MCA_INIT		18	/* this task is processing MCA or INIT */
 #define TIF_DB_DISABLED		19	/* debug trap disabled for fsyscall */
+#define TIF_FREEZE		20	/* is freezing for suspend */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
@@ -98,6 +99,7 @@ struct thread_info {
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_MCA_INIT		(1 << TIF_MCA_INIT)
 #define _TIF_DB_DISABLED	(1 << TIF_DB_DISABLED)
+#define _TIF_FREEZE		(1 << TIF_FREEZE)
 
 /* "work to do on user-return" bits */
 #define TIF_ALLWORK_MASK	(_TIF_NOTIFY_RESUME|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
Index: linux-2.6.19-rc6-mm2/include/asm-sh/thread_info.h
===================================================================
--- linux-2.6.19-rc6-mm2.orig/include/asm-sh/thread_info.h
+++ linux-2.6.19-rc6-mm2/include/asm-sh/thread_info.h
@@ -106,6 +106,7 @@ static inline struct thread_info *curren
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18
+#define TIF_FREEZE		19
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -114,6 +115,7 @@ static inline struct thread_info *curren
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
+#define _TIF_FREEZE		(1<<TIF_FREEZE)
 
 #define _TIF_WORK_MASK		0x000000FE	/* work to do on interrupt/exception return */
 #define _TIF_ALLWORK_MASK	0x000000FF	/* work to do on any return to u-space */
Index: linux-2.6.19-rc6-mm2/include/asm-frv/thread_info.h
===================================================================
--- linux-2.6.19-rc6-mm2.orig/include/asm-frv/thread_info.h
+++ linux-2.6.19-rc6-mm2/include/asm-frv/thread_info.h
@@ -116,6 +116,7 @@ register struct thread_info *__current_t
 #define TIF_RESTORE_SIGMASK	6	/* restore signal mask in do_signal() */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17	/* OOM killer killed process */
+#define TIF_FREEZE		18	/* freezing for suspend */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
@@ -125,6 +126,7 @@ register struct thread_info *__current_t
 #define _TIF_IRET		(1 << TIF_IRET)
 #define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
+#define _TIF_FREEZE		(1 << TIF_FREEZE)
 
 #define _TIF_WORK_MASK		0x0000FFFE	/* work to do on interrupt/exception return */
 #define _TIF_ALLWORK_MASK	0x0000FFFF	/* work to do on any return to u-space */
Index: linux-2.6.19-rc6-mm2/include/asm-i386/thread_info.h
===================================================================
--- linux-2.6.19-rc6-mm2.orig/include/asm-i386/thread_info.h
+++ linux-2.6.19-rc6-mm2/include/asm-i386/thread_info.h
@@ -134,6 +134,7 @@ static inline struct thread_info *curren
 #define TIF_MEMDIE		16
 #define TIF_DEBUG		17	/* uses debug registers */
 #define TIF_IO_BITMAP		18	/* uses I/O bitmap */
+#define TIF_FREEZE		19	/* is freezing for suspend */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -147,6 +148,7 @@ static inline struct thread_info *curren
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_DEBUG		(1<<TIF_DEBUG)
 #define _TIF_IO_BITMAP		(1<<TIF_IO_BITMAP)
+#define _TIF_FREEZE		(1<<TIF_FREEZE)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
Index: linux-2.6.19-rc6-mm2/include/asm-powerpc/thread_info.h
===================================================================
--- linux-2.6.19-rc6-mm2.orig/include/asm-powerpc/thread_info.h
+++ linux-2.6.19-rc6-mm2/include/asm-powerpc/thread_info.h
@@ -122,6 +122,7 @@ static inline struct thread_info *curren
 #define TIF_RESTOREALL		12	/* Restore all regs (implies NOERROR) */
 #define TIF_NOERROR		14	/* Force successful syscall return */
 #define TIF_RESTORE_SIGMASK	15	/* Restore signal mask in do_signal */
+#define TIF_FREEZE		16	/* Freezing for suspend */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -138,6 +139,7 @@ static inline struct thread_info *curren
 #define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
 #define _TIF_NOERROR		(1<<TIF_NOERROR)
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
+#define _TIF_FREEZE		(1<<TIF_FREEZE)
 #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP)
 
 #define _TIF_USER_WORK_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | \
Index: linux-2.6.19-rc6-mm2/include/asm-x86_64/thread_info.h
===================================================================
--- linux-2.6.19-rc6-mm2.orig/include/asm-x86_64/thread_info.h
+++ linux-2.6.19-rc6-mm2/include/asm-x86_64/thread_info.h
@@ -122,6 +122,7 @@ static inline struct thread_info *stack_
 #define TIF_MEMDIE		20
 #define TIF_DEBUG		21	/* uses debug registers */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
+#define TIF_FREEZE		23	/* is freezing for suspend */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -137,6 +138,7 @@ static inline struct thread_info *stack_
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
 #define _TIF_DEBUG		(1<<TIF_DEBUG)
 #define _TIF_IO_BITMAP		(1<<TIF_IO_BITMAP)
+#define _TIF_FREEZE		(1<<TIF_FREEZE)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
Index: linux-2.6.19-rc6-mm2/include/linux/freezer.h
===================================================================
--- linux-2.6.19-rc6-mm2.orig/include/linux/freezer.h
+++ linux-2.6.19-rc6-mm2/include/linux/freezer.h
@@ -14,16 +14,15 @@ static inline int frozen(struct task_str
  */
 static inline int freezing(struct task_struct *p)
 {
-	return p->flags & PF_FREEZE;
+	return test_tsk_thread_flag(p, TIF_FREEZE);
 }
 
 /*
  * Request that a process be frozen
- * FIXME: SMP problem. We may not modify other process' flags!
  */
 static inline void freeze(struct task_struct *p)
 {
-	p->flags |= PF_FREEZE;
+	set_tsk_thread_flag(p, TIF_FREEZE);
 }
 
 /*
@@ -31,7 +30,7 @@ static inline void freeze(struct task_st
  */
 static inline void do_not_freeze(struct task_struct *p)
 {
-	p->flags &= ~PF_FREEZE;
+	clear_tsk_thread_flag(p, TIF_FREEZE);
 }
 
 /*
@@ -52,7 +51,9 @@ static inline int thaw_process(struct ta
  */
 static inline void frozen_process(struct task_struct *p)
 {
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
+	p->flags |= PF_FROZEN;
+	wmb();
+	clear_tsk_thread_flag(p, TIF_FREEZE);
 }
 
 extern void refrigerator(void);
Index: linux-2.6.19-rc6-mm2/include/linux/sched.h
===================================================================
--- linux-2.6.19-rc6-mm2.orig/include/linux/sched.h
+++ linux-2.6.19-rc6-mm2/include/linux/sched.h
@@ -1161,7 +1161,6 @@ static inline void put_task_struct(struc
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
 #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
-#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
Index: linux-2.6.19-rc6-mm2/kernel/power/process.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/power/process.c
+++ linux-2.6.19-rc6-mm2/kernel/power/process.c
@@ -60,13 +60,16 @@ static inline void freeze_process(struct
 	unsigned long flags;
 
 	if (!freezing(p)) {
-		if (p->state == TASK_STOPPED)
-			force_sig_specific(SIGSTOP, p);
-
-		freeze(p);
-		spin_lock_irqsave(&p->sighand->siglock, flags);
-		signal_wake_up(p, p->state == TASK_STOPPED);
-		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		rmb();
+		if (!frozen(p)) {
+			if (p->state == TASK_STOPPED)
+				force_sig_specific(SIGSTOP, p);
+
+			freeze(p);
+			spin_lock_irqsave(&p->sighand->siglock, flags);
+			signal_wake_up(p, p->state == TASK_STOPPED);
+			spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		}
 	}
 }
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
