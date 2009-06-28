From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 6)
Date: Sun, 28 Jun 2009 12:25:26 +0200
Message-ID: <200906281225.27596.rjw__14215.1476037272$1246184797$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906261707260.4155-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906261707260.4155-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday 26 June 2009, Alan Stern wrote:
> On Fri, 26 Jun 2009, Rafael J. Wysocki wrote:
> 
> > > It occurs to me that the problem would be solved if were a cancel_work
> > > routine.  In the same vein, it ought to be possible for
> > > cancel_delayed_work to run in interrupt context.  I'll see what can be
> > > done.
> > 
> > Having looked at the workqueue code I'm not sure if there's a way to implement
> > that in a non-racy way.  Which may be the reason why there are no such
> > functions already. :-)
> 
> Well, I'll give it a try.

I did that too. :-)

It seems that if we do something like in the appended patch, then
cancel_work() and cancel_delayed_work_dequeue() can be used to simplify the
$subject patch slightly.

Best,
Rafael

---
 include/linux/workqueue.h |    2 ++
 kernel/workqueue.c        |   40 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

Index: linux-2.6/include/linux/workqueue.h
===================================================================
--- linux-2.6.orig/include/linux/workqueue.h
+++ linux-2.6/include/linux/workqueue.h
@@ -223,6 +223,7 @@ int execute_in_process_context(work_func
 extern int flush_work(struct work_struct *work);
 
 extern int cancel_work_sync(struct work_struct *work);
+extern int cancel_work(struct work_struct *work);
 
 /*
  * Kill off a pending schedule_delayed_work().  Note that the work callback
@@ -241,6 +242,7 @@ static inline int cancel_delayed_work(st
 }
 
 extern int cancel_delayed_work_sync(struct delayed_work *work);
+extern int cancel_delayed_work_dequeue(struct delayed_work *dwork);
 
 /* Obsolete. use cancel_delayed_work_sync() */
 static inline
Index: linux-2.6/kernel/workqueue.c
===================================================================
--- linux-2.6.orig/kernel/workqueue.c
+++ linux-2.6/kernel/workqueue.c
@@ -536,7 +536,7 @@ static void wait_on_work(struct work_str
 		wait_on_cpu_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
 }
 
-static int __cancel_work_timer(struct work_struct *work,
+static int __cancel_work_timer(struct work_struct *work, bool wait,
 				struct timer_list* timer)
 {
 	int ret;
@@ -545,7 +545,8 @@ static int __cancel_work_timer(struct wo
 		ret = (timer && likely(del_timer(timer)));
 		if (!ret)
 			ret = try_to_grab_pending(work);
-		wait_on_work(work);
+		if (wait)
+			wait_on_work(work);
 	} while (unlikely(ret < 0));
 
 	work_clear_pending(work);
@@ -575,11 +576,27 @@ static int __cancel_work_timer(struct wo
  */
 int cancel_work_sync(struct work_struct *work)
 {
-	return __cancel_work_timer(work, NULL);
+	return __cancel_work_timer(work, true, NULL);
 }
 EXPORT_SYMBOL_GPL(cancel_work_sync);
 
 /**
+ * cancel_work - kill off a work without waiting for its callback to terminate
+ * @work: the work which is to be canceled
+ *
+ * Returns true if @work was pending.
+ *
+ * cancel_work() will cancel the work if it is queued, but it will not block
+ * until the works callback completes.  Apart from this, it works like
+ * cancel_work_sync().
+ */
+int cancel_work(struct work_struct *work)
+{
+	return __cancel_work_timer(work, false, NULL);
+}
+EXPORT_SYMBOL_GPL(cancel_work);
+
+/**
  * cancel_delayed_work_sync - reliably kill off a delayed work.
  * @dwork: the delayed work struct
  *
@@ -590,10 +607,25 @@ EXPORT_SYMBOL_GPL(cancel_work_sync);
  */
 int cancel_delayed_work_sync(struct delayed_work *dwork)
 {
-	return __cancel_work_timer(&dwork->work, &dwork->timer);
+	return __cancel_work_timer(&dwork->work, true, &dwork->timer);
 }
 EXPORT_SYMBOL(cancel_delayed_work_sync);
 
+/**
+ * cancel_delayed_work_dequeue - kill off a delayed work.
+ * @dwork: the delayed work struct
+ *
+ * Returns true if @dwork was pending.
+ *
+ * cancel_delayed_work_dequeue() will not wait for the work's callback to
+ * terminate.  Apart from this it works like cancel_delayed_work_sync().
+ */
+int cancel_delayed_work_dequeue(struct delayed_work *dwork)
+{
+	return __cancel_work_timer(&dwork->work, false, &dwork->timer);
+}
+EXPORT_SYMBOL(cancel_delayed_work_dequeue);
+
 static struct workqueue_struct *keventd_wq __read_mostly;
 
 /**
