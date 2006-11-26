From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/5] PM: Make freeze_processes
	SMP-safe
Date: Sun, 26 Nov 2006 12:15:13 +0100
Message-ID: <200611261215.14326.rjw@sisk.pl>
References: <200611252210.58203.rjw@sisk.pl>
	<20061126074740.GB12479@elf.ucw.cz>
	<200611261102.17091.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200611261102.17091.rjw@sisk.pl>
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

On Sunday, 26 November 2006 11:02, Rafael J. Wysocki wrote:
> On Sunday, 26 November 2006 08:47, Pavel Machek wrote:
> > Hi!
> > 
> > > Currently, the PF_FREEZE process flag is used to indicate that the process
> > > should enter the refrigerator as soon as possible.  Unfortunately it is set by
> > > the freezer while the process may be changing its flags for another reason
> > > and this may lead to a race between the freezer and the process itself.
> > > 
> > > This problem may be solved by introducing an additional member, called (for
> > > example) 'freezing', into task_struct which will only be used to indicate that
> > > the process should enter the refrigerator.  Then, if the 'freezing' member of
> > > task_struct is reset by the process itself only after it has entered the
> > > refrigerator, the modifications of it will be guaranteed to occur at different
> > > times, because the freezer can only set it before the process enters the
> > > refrigerator.  Thus the code will be SMP-safe even though no explicit locking
> > > is used.
> > 
> > I do not think we can go without locking here.
> 
> Why exactly?
> 
> > > @@ -31,7 +30,7 @@ static inline void freeze(struct task_st
> > >   */
> > >  static inline void do_not_freeze(struct task_struct *p)
> > >  {
> > > -	p->flags &= ~PF_FREEZE;
> > > +	p->freezing = 0;
> > >  }
> > >  
> > >  /*
> > > @@ -52,7 +51,8 @@ static inline int thaw_process(struct ta
> > >   */
> > >  static inline void frozen_process(struct task_struct *p)
> > >  {
> > > -	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
> > > +	p->flags |= PF_FROZEN;
> > > +	p->freezing = 0;
> > >  }
> > 
> > Is mb() needed between |= and freezing = 0?
> 
> Hm, I'm not sure.  Are there architectures on which memory writes can be
> reordered?
>  
> > >  extern void refrigerator(void);
> > > Index: linux-2.6.19-rc6-mm1/include/linux/sched.h
> > > ===================================================================
> > > --- linux-2.6.19-rc6-mm1.orig/include/linux/sched.h
> > > +++ linux-2.6.19-rc6-mm1/include/linux/sched.h
> > > @@ -1065,6 +1065,9 @@ struct task_struct {
> > >  #ifdef	CONFIG_TASK_DELAY_ACCT
> > >  	struct task_delay_info *delays;
> > >  #endif
> > > +#ifdef CONFIG_PM
> > > +	int freezing;		/* if set, we should be freezing for suspend */
> > > +#endif
> > >  #ifdef CONFIG_FAULT_INJECTION
> > >  	int make_it_fail;
> > >  #endif
> > 
> > It is int, imagine machine that can't do 32-bit atomic access (only
> > does 64 bits). On such beast (alpha? something stranger?) this will
> > clobber make_it_fail field, sometimes.
> > 
> > OTOH on i386 normal instructions can be used. But that's okay, we
> > should just use atomic_t here. Should be as fast on i386/x86-64, and
> > still safe.
> 
> Okay, I'll use atomic_t.

Patch with atomic_t follows.

The atomic_set(..., 0) are used to avoid the (theoretical) situation in which
freezing might be decreased twice in a row and I've decided to explicitly
initialize freezing in fork.c for clarity.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/freezer.h |   10 +++++-----
 include/linux/sched.h   |    4 +++-
 kernel/fork.c           |    4 ++++
 3 files changed, 12 insertions(+), 6 deletions(-)

Index: linux-2.6.19-rc6-mm1/include/linux/freezer.h
===================================================================
--- linux-2.6.19-rc6-mm1.orig/include/linux/freezer.h	2006-11-26 11:31:39.000000000 +0100
+++ linux-2.6.19-rc6-mm1/include/linux/freezer.h	2006-11-26 11:52:29.000000000 +0100
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
@@ -52,7 +51,8 @@ static inline int thaw_process(struct ta
  */
 static inline void frozen_process(struct task_struct *p)
 {
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
+	p->flags |= PF_FROZEN;
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

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
