From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/6] PM: Asynchronous resume of devices
Date: Sat, 29 Aug 2009 01:20:14 +0200
Message-ID: <200908290120.14840.rjw__45172.6487059661$1251501712$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908281548140.2865-100000@iolanthe.rowland.org>
	<200908290022.00446.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908290022.00446.rjw@sisk.pl>
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

On Saturday 29 August 2009, Rafael J. Wysocki wrote:
> On Friday 28 August 2009, Alan Stern wrote:
> > On Fri, 28 Aug 2009, Rafael J. Wysocki wrote:
> > 
> > > > Given this design, why bother to invoke device_resume() for the async 
> > > > devices?  Why not just start up a bunch of async threads, each of which 
> > > > calls async_resume() repeatedly until everything is finished?  (And 
> > > > rearrange async_resume() to scan the list first and do the actual 
> > > > resume second.)
> > > > 
> > > > The same goes for the noirq versions.
> > > 
> > > I thought about that, but there are a few things to figure out:
> > > - how many threads to start
> > 
> > That's a tough question.  Right now you start roughly as many threads
> > as there are async devices.  That seems like overkill.
> 
> In fact they are substantially fewer than that, for the following reasons.
> 
> First, the async framework will not start more than MAX_THREADS threads,
> which is 256 at the moment.  This number is less than the number of async
> devices to handle on an average system.
> 
> Second, no new async threads are started while the main thread is handling the
> sync devices , so the existing threads have a chance to do their job.  If
> there's a "cluster" of sync devices in dpm_list, the number of async threads
> running is likely to drop rapidly while those devices are being handled.
> (BTW, if there were no sync devices, the whole thing would be much simpler,
> but I don't think it's realistic to assume we'll be able to get rid of them any
> time soon).
> 
> Finally, but not least importantly, async threads are not started for the
> async devices that were previously handled "out of order" by the already
> running async threads (or by async threads that have already finished).  My
> testing shows that there are quite a few of them on the average.  For example,
> on the HP nx6325 typically there are as many as 580 async devices handled "out
> of order" during a _single_ suspend-resume cycle (including the "early" and
> "late" phases), while only a few (below 10) devices are waited for by at least
> one async thread.
> 
> I can try to monitor the number of asyn threads started if you're interested.

I did that out of curiousity.  To be precise, I applied the appended patch on
top of the previous ones and the maximum number of scheduled async operations
I've got so far is 14 (strangely enough, during "late" suspend).

So, that's not like there are hundreds of async threads being started.

Thanks,
Rafael


---
 drivers/base/power/main.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -53,6 +53,8 @@ static pm_message_t pm_transition;
  */
 static bool transition_started;
 
+static unsigned int nr_async;
+
 /**
  * device_pm_lock - Lock the list of active devices used by the PM core.
  */
@@ -166,6 +168,8 @@ static void dpm_reset_all(void)
 
 	list_for_each_entry(dev, &dpm_list, power.entry)
 		dpm_reset(dev);
+	printk(KERN_INFO "PM: Scheduled %d async operations\n", nr_async);
+	nr_async = 0;
 }
 
 /**
@@ -563,6 +567,7 @@ static int device_resume_noirq(struct de
 
 	if (pm_async_enabled && !pm_trace_enabled && dev->power.async_suspend) {
 		async_schedule(async_resume_noirq, dev);
+		nr_async++;
 		return 0;
 	}
 
@@ -723,6 +728,7 @@ static int device_resume(struct device *
 	if (pm_async_enabled && !pm_trace_enabled && dev->power.async_suspend) {
 		get_device(dev);
 		async_schedule(async_resume, dev);
+		nr_async++;
 		return 0;
 	}
 
@@ -968,6 +974,7 @@ static int device_suspend_noirq(struct d
 
 	if (pm_async_enabled && dev->power.async_suspend) {
 		async_schedule(async_suspend_noirq, dev);
+		nr_async++;
 		return 0;
 	}
 
@@ -1143,6 +1150,7 @@ static int device_suspend(struct device 
 	if (pm_async_enabled && dev->power.async_suspend) {
 		get_device(dev);
 		async_schedule(async_suspend, dev);
+		nr_async++;
 		return 0;
 	}
 
@@ -1247,6 +1255,7 @@ static int dpm_prepare(pm_message_t stat
 	mutex_lock(&dpm_list_mtx);
 	transition_started = true;
 	atomic_set(&async_error, 0);
+	nr_async = 0;
 	while (!list_empty(&dpm_list)) {
 		struct device *dev = to_device(dpm_list.next);
 
