From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: GPF in
	run_workqueue()/list_del_init(cwq->worklist.next) on	resume
	(was: Re: Help needed: Resume problems in 2.6.32-rc,
	perhaps	related to preempt_count leakage in keventd)
Date: Wed, 11 Nov 2009 17:13:48 +0100
Message-ID: <20091111161348.GA27394__33153.8798207932$1257956445$gmane$org@redhat.com>
References: <200911091250.31626.rjw@sisk.pl> <200911092145.27485.rjw@sisk.pl>
	<alpine.LFD.2.01.0911091339290.31845@localhost.localdomain>
	<200911100119.38019.rjw@sisk.pl>
	<alpine.LFD.2.01.0911101343590.31845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0911101343590.31845@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 11/10, Linus Torvalds wrote:
>
> > In the meantime I got another trace, this time with a slab corruption involved.
> > Note that it crashed in exactly the same place as previously.
>
> I'm leaving your crash log appended for the new cc's, and I would not be
> at all surprised to hear that the slab corruption is related. The whole
> 6b6b6b6b pattern does imply a use-after-free on the workqueue,

Yes, RCX = 6b6b6b6b6b6b6b6b, and according to decodecode the faulting
instruction is "mov %rdx,0x8(%rcx)". Looks like the pending work was
freed.

Rafael, could you reproduce the problem with the debugging patch below?
It tries to detect the case when the pending work was corrupted and
prints its work->func (saved in the previous item). It should work
if the work_struct was freed and poisoned, or if it was re-initialized.
See ck_work().

Oleg.

--- TH/include/linux/workqueue.h~WQ_DBG	2009-10-15 12:09:50.000000000 +0200
+++ TH/include/linux/workqueue.h	2009-11-11 16:20:16.000000000 +0100
@@ -27,6 +27,7 @@ struct work_struct {
 #define WORK_STRUCT_PENDING 0		/* T if work item pending execution */
 #define WORK_STRUCT_FLAG_MASK (3UL)
 #define WORK_STRUCT_WQ_DATA_MASK (~WORK_STRUCT_FLAG_MASK)
+	work_func_t next_func;
 	struct list_head entry;
 	work_func_t func;
 #ifdef CONFIG_LOCKDEP
@@ -65,7 +66,7 @@ struct execute_work {
 #define __WORK_INITIALIZER(n, f) {				\
 	.data = WORK_DATA_INIT(),				\
 	.entry	= { &(n).entry, &(n).entry },			\
-	.func = (f),						\
+	.func = (f), .next_func = NULL,				\
 	__WORK_INIT_LOCKDEP_MAP(#n, &(n))			\
 	}
 
--- TH/kernel/workqueue.c~WQ_DBG	2009-10-17 20:25:07.000000000 +0200
+++ TH/kernel/workqueue.c	2009-11-11 16:49:53.000000000 +0100
@@ -36,6 +36,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/workqueue.h>
 
+#define tow(p) list_entry((p), struct work_struct, entry)
 /*
  * The per-CPU workqueue (if single thread, we always use the first
  * possible cpu).
@@ -44,7 +45,9 @@ struct cpu_workqueue_struct {
 
 	spinlock_t lock;
 
+	work_func_t next_func;
 	struct list_head worklist;
+
 	wait_queue_head_t more_work;
 	struct work_struct *current_work;
 
@@ -137,6 +140,10 @@ static void insert_work(struct cpu_workq
 	 */
 	smp_wmb();
 	list_add_tail(&work->entry, head);
+
+	work->next_func = tow(work->entry.next)->func;
+	tow(work->entry.prev)->next_func = work->func;
+
 	wake_up(&cwq->more_work);
 }
 
@@ -261,9 +268,22 @@ int queue_delayed_work_on(int cpu, struc
 }
 EXPORT_SYMBOL_GPL(queue_delayed_work_on);
 
+static int ck_work(struct cpu_workqueue_struct *cwq, struct work_struct *work)
+{
+	if (cwq->next_func == work->func && cwq == get_wq_data(work) &&
+	    work->entry.prev == &cwq->worklist &&
+	    test_bit(WORK_STRUCT_PENDING, work_data_bits(work)))
+		return 0;
+
+	printk(KERN_CRIT "ERR!! ");
+	print_symbol("%s\n", (unsigned long)cwq->next_func);
+	return 1;
+}
+
 static void run_workqueue(struct cpu_workqueue_struct *cwq)
 {
 	spin_lock_irq(&cwq->lock);
+again:
 	while (!list_empty(&cwq->worklist)) {
 		struct work_struct *work = list_entry(cwq->worklist.next,
 						struct work_struct, entry);
@@ -279,8 +299,20 @@ static void run_workqueue(struct cpu_wor
 		 */
 		struct lockdep_map lockdep_map = work->lockdep_map;
 #endif
+		if (ck_work(cwq, work)) {
+			struct list_head *pos = &cwq->worklist;
+			while (pos->prev != &work->entry)
+				pos = pos->prev;
+
+			cwq->next_func = tow(pos)->func;
+			cwq->worklist.next = pos;
+			pos->prev = &cwq->worklist;
+			goto again;
+		}
+
 		trace_workqueue_execution(cwq->thread, work);
 		cwq->current_work = work;
+		cwq->next_func = work->next_func;
 		list_del_init(cwq->worklist.next);
 		spin_unlock_irq(&cwq->lock);
 
@@ -485,6 +517,7 @@ static int try_to_grab_pending(struct wo
 		 */
 		smp_rmb();
 		if (cwq == get_wq_data(work)) {
+			tow(work->entry.prev)->next_func = work->next_func;
 			list_del_init(&work->entry);
 			ret = 1;
 		}
