From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 10] PM: Measure suspend and resume times for
	individual devices (was: Re: [PATCH 2/6] PM: Asynchronous
	resume of devices)
Date: Sun, 30 Aug 2009 23:13:52 +0200
Message-ID: <200908302313.52945.rjw__26004.5989453376$1251666887$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908292043500.26533-100000@netrider.rowland.org>
	<200908301515.11525.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908301515.11525.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 30 August 2009, Rafael J. Wysocki wrote:
> On Sunday 30 August 2009, Alan Stern wrote:
> > On Sat, 29 Aug 2009, Rafael J. Wysocki wrote:
> > 
> > > I only wanted to say that the advantage is not really that "big". :-)
> > > 
> > > > I must agree, 14 threads isn't a lot.  But at the moment that number is 
> > > > random, not under your control.
> > > 
> > > It's not directly controlled, but there are some interactions between the
> > > async threads, the main threads and the async framework that don't allow this
> > > number to grow too much.
> > > 
> > > IMO it sometimes is better to allow things to work themselves out, as long as
> > > they don't explode, than to try to keep everything under strict control.  YMMV.
> > 
> > For testing purposes it would be nice to have a one-line summary for
> > each device containing a thread ID, start timestamp, end timestamp, and
> > elapsed time.  With that information you could evaluate the amount of
> > parallelism and determine where the bottlenecks are.  It would give a
> > much more detailed picture of the entire process than the total time of
> > your recent patch 9.
> 
> Of course it would.  I think I'll implement it.

OK, below is a patch for that.  It only prints the time elapsed, because the
timestamps themselves can be obtained from the usual kernel timestamping.

It's on top of all the previous patches.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM: Measure suspend and resume times for individual devices

If verbose PM debugging is enabled, measure and print the time of
suspending and resuming of individual devices.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |   51 +++++++++++++++++++++++++++++++++++++++++-----
 kernel/power/swsusp.c     |    2 -
 2 files changed, 47 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -442,11 +442,11 @@ static bool pm_op_started(struct device 
  */
 int pm_time_elapsed(struct timeval *start, struct timeval *stop)
 {
-	s64 elapsed_centisecs64;
+	s64 elapsed_msecs64;
 
-	elapsed_centisecs64 = timeval_to_ns(stop) - timeval_to_ns(start);
-	do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);
-	return elapsed_centisecs64;
+	elapsed_msecs64 = timeval_to_ns(stop) - timeval_to_ns(start);
+	do_div(elapsed_msecs64, NSEC_PER_SEC / 1000);
+	return elapsed_msecs64;
 }
 
 static char *pm_verb(int event)
@@ -476,7 +476,7 @@ static char *pm_verb(int event)
 static void dpm_show_time(struct timeval *start, struct timeval *stop,
 			  pm_message_t state, const char *info)
 {
-	int centisecs = pm_time_elapsed(start, stop);
+	int centisecs = pm_time_elapsed(start, stop) / 10;
 
 	printk(KERN_INFO "PM: %s%s%s of devices complete in %d.%02d seconds\n",
 		info ? info : "", info ? " " : "", pm_verb(state.event),
@@ -497,6 +497,33 @@ static void pm_dev_err(struct device *de
 		kobject_name(&dev->kobj), pm_verb(state.event), info, error);
 }
 
+#ifdef DEBUG
+static void device_show_time(struct timeval *start, struct device *dev,
+			     pm_message_t state, char *info)
+{
+	struct timeval stop;
+	int msecs;
+
+	do_gettimeofday(&stop);
+	msecs = pm_time_elapsed(start, &stop);
+	dev_dbg(dev, "PID %d: %s%s%s complete in %d.%03d seconds\n",
+		task_pid_nr(current), info ? info : "", info ? " " : "",
+		pm_verb(state.event), msecs / 1000, msecs % 1000);
+}
+
+#define TIMER_DECLARE(timer)	struct timeval timer
+#define TIMER_START(timer)	do { \
+		do_gettimeofday(&timer); \
+	} while (0)
+#define TIMER_STOP(timer, dev, state, info)	do { \
+		device_show_time(&timer, dev, state, info); \
+	} while (0)
+#else /* !DEBUG */
+#define TIMER_DECLARE(timer)
+#define TIMER_START(timer)	do { } while (0)
+#define TIMER_STOP(timer, dev, state, info)	do { } while (0)
+#endif /* !DEBUG */
+
 /*------------------------- Resume routines -------------------------*/
 
 /**
@@ -510,7 +537,9 @@ static void pm_dev_err(struct device *de
 static int __device_resume_noirq(struct device *dev, pm_message_t state)
 {
 	int error = 0;
+	TIMER_DECLARE(timer);
 
+	TIMER_START(timer);
 	TRACE_DEVICE(dev);
 	TRACE_RESUME(0);
 
@@ -523,6 +552,7 @@ static int __device_resume_noirq(struct 
 	wake_up_all(&dev->power.wait_queue);
 
 	TRACE_RESUME(error);
+	TIMER_STOP(timer, dev, state, "EARLY");
 	return error;
 }
 
@@ -639,7 +669,9 @@ EXPORT_SYMBOL_GPL(dpm_resume_noirq);
 static int __device_resume(struct device *dev, pm_message_t state)
 {
 	int error = 0;
+	TIMER_DECLARE(timer);
 
+	TIMER_START(timer);
 	TRACE_DEVICE(dev);
 	TRACE_RESUME(0);
 
@@ -681,6 +713,7 @@ static int __device_resume(struct device
 	wake_up_all(&dev->power.wait_queue);
 
 	TRACE_RESUME(error);
+	TIMER_STOP(timer, dev, state, NULL);
 	return error;
 }
 
@@ -923,6 +956,9 @@ static pm_message_t resume_event(pm_mess
 static int __device_suspend_noirq(struct device *dev, pm_message_t state)
 {
 	int error = 0;
+	TIMER_DECLARE(timer);
+
+	TIMER_START(timer);
 
 	if (dev->bus && dev->bus->pm) {
 		pm_dev_dbg(dev, state, "LATE ");
@@ -932,6 +968,7 @@ static int __device_suspend_noirq(struct
 	dev->power.op_complete = true;
 	wake_up_all(&dev->power.wait_queue);
 
+	TIMER_STOP(timer, dev, state, "LATE");
 	return error;
 }
 
@@ -1063,6 +1100,9 @@ EXPORT_SYMBOL_GPL(dpm_suspend_noirq);
 static int __device_suspend(struct device *dev, pm_message_t state)
 {
 	int error = 0;
+	TIMER_DECLARE(timer);
+
+	TIMER_START(timer);
 
 	down(&dev->sem);
 
@@ -1103,6 +1143,7 @@ static int __device_suspend(struct devic
 	dev->power.op_complete = true;
 	wake_up_all(&dev->power.wait_queue);
 
+	TIMER_STOP(timer, dev, state, NULL);
 	return error;
 }
 
Index: linux-2.6/kernel/power/swsusp.c
===================================================================
--- linux-2.6.orig/kernel/power/swsusp.c
+++ linux-2.6/kernel/power/swsusp.c
@@ -169,7 +169,7 @@ int swsusp_swap_in_use(void)
 void swsusp_show_speed(struct timeval *start, struct timeval *stop,
 			unsigned nr_pages, char *msg)
 {
-	int centisecs = pm_time_elapsed(start, stop);
+	int centisecs = pm_time_elapsed(start, stop) / 10;
 	int k;
 	int kps;
 
