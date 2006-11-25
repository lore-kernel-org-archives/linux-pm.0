From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 1/5] PM: Make freeze_processes
	SMP-safe
Date: Sat, 25 Nov 2006 22:29:51 +0100
Message-ID: <200611252229.52189.rjw@sisk.pl>
References: <200611252210.58203.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200611252210.58203.rjw@sisk.pl>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Currently, the PF_FREEZE process flag is used to indicate that the process
should enter the refrigerator as soon as possible.  Unfortunately it is set by
the freezer while the process may be changing its flags for another reason
and this may lead to a race between the freezer and the process itself.

This problem may be solved by introducing an additional member, called (for
example) 'freezing', into task_struct which will only be used to indicate that
the process should enter the refrigerator.  Then, if the 'freezing' member of
task_struct is reset by the process itself only after it has entered the
refrigerator, the modifications of it will be guaranteed to occur at different
times, because the freezer can only set it before the process enters the
refrigerator.  Thus the code will be SMP-safe even though no explicit locking
is used.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/freezer.h |   10 +++++-----
 include/linux/sched.h   |    4 +++-
 2 files changed, 8 insertions(+), 6 deletions(-)

Index: linux-2.6.19-rc6-mm1/include/linux/freezer.h
===================================================================
--- linux-2.6.19-rc6-mm1.orig/include/linux/freezer.h
+++ linux-2.6.19-rc6-mm1/include/linux/freezer.h
@@ -14,16 +14,15 @@ static inline int frozen(struct task_str
  */
 static inline int freezing(struct task_struct *p)
 {
-	return p->flags & PF_FREEZE;
+	return !!p->freezing;
 }
 
 /*
  * Request that a process be frozen
- * FIXME: SMP problem. We may not modify other process' flags!
  */
 static inline void freeze(struct task_struct *p)
 {
-	p->flags |= PF_FREEZE;
+	p->freezing = 1;
 }
 
 /*
@@ -31,7 +30,7 @@ static inline void freeze(struct task_st
  */
 static inline void do_not_freeze(struct task_struct *p)
 {
-	p->flags &= ~PF_FREEZE;
+	p->freezing = 0;
 }
 
 /*
@@ -52,7 +51,8 @@ static inline int thaw_process(struct ta
  */
 static inline void frozen_process(struct task_struct *p)
 {
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
+	p->flags |= PF_FROZEN;
+	p->freezing = 0;
 }
 
 extern void refrigerator(void);
Index: linux-2.6.19-rc6-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.19-rc6-mm1.orig/include/linux/sched.h
+++ linux-2.6.19-rc6-mm1/include/linux/sched.h
@@ -1065,6 +1065,9 @@ struct task_struct {
 #ifdef	CONFIG_TASK_DELAY_ACCT
 	struct task_delay_info *delays;
 #endif
+#ifdef CONFIG_PM
+	int freezing;		/* if set, we should be freezing for suspend */
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


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
