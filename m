From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [update] Re: [PATCH] PM: Make it possible to avoid
	wakeup events from being lost
Date: Thu, 1 Jul 2010 01:52:03 +0200
Message-ID: <201007010152.03869.rjw__36068.301605019$1277942107$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1006301535450.1707-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006301535450.1707-100000@iolanthe.rowland.org>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 30, 2010, Alan Stern wrote:
> On Wed, 30 Jun 2010, Rafael J. Wysocki wrote:
> 
> > > Since there's no longer any way to cancel a call to pm_wakeup_event()  
> > > or close the "no suspend" period early, there is no need to use
> > > dynamically-allocated delayed_work structures.  You can make do with a
> > > single static timer; always keep it set to expire at the latest time
> > > passed to pm_wakeup_event().
> > 
> > The decremenations of events_in_progress wouldn't be balanced with
> > incrementations this way.  Or do you have any clever way of dealing with
> > that in mind?
> 
> Keep track of the current expiration time in a static variable called
> wakeup_timeout, and use 0 to indicate there is no timeout.

I invented a slightly different version in the meantime, which is appended
as a patch on top of the original one (I don't want to modify the original
patch, since it's been reviewed already by several people and went to my
linux-next branch).

> In pm_wakeup_event() (everything protected by the spinlock):
> 
> 	unsigned long new_timeout = jiffies + msecs_to_jiffies(msecs);
> 	if (new_timeout == 0)
> 		new_timeout = 1;
> 
> 	++event_count;
> 	if (!wakeup_timeout || time_after(new_timeout, wakeup_timeout)) {
> 		if (!wakeup_timeout)
> 			++events_in_progress;
> 		wakeup_timeout = new_timeout;
> 		mod_timer(&wakeup_timer, wakeup_timeout);
> 	}
> 
> In the timer routine:
> 
> 	if (wakeup_timeout && time_before_eq(wakeup_timeout, jiffies)) {
> 		--events_in_progres;
> 		wakeup_timeout = 0;
> 	}
> 

---
 drivers/base/power/wakeup.c |   47 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

Index: linux-2.6/drivers/base/power/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/base/power/wakeup.c
+++ linux-2.6/drivers/base/power/wakeup.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/ktime.h>
 #include <linux/capability.h>
 #include <linux/suspend.h>
 #include <linux/pm.h>
@@ -28,6 +29,12 @@ static unsigned long events_in_progress;
 
 static DEFINE_SPINLOCK(events_lock);
 
+static void pm_wakeup_timer_fn(unsigned long data);
+
+static DEFINE_TIMER(events_timer, pm_wakeup_timer_fn, 0, 0);
+static unsigned long events_timer_expires;
+static unsigned long delayed_count;
+
 /*
  * The functions below use the observation that each wakeup event starts a
  * period in which the system should not be suspended.  The moment this period
@@ -103,17 +110,23 @@ void pm_relax(void)
 }
 
 /**
- * pm_wakeup_work_fn - Deferred closing of a wakeup event.
+ * pm_wakeup_timer_fn - Deferred closing of a wakeup event.
  *
  * Execute pm_relax() for a wakeup event detected in the past and free the
  * work item object used for queuing up the work.
  */
-static void pm_wakeup_work_fn(struct work_struct *work)
+static void pm_wakeup_timer_fn(unsigned long data)
 {
-	struct delayed_work *dwork = to_delayed_work(work);
+	unsigned long flags;
 
-	pm_relax();
-	kfree(dwork);
+	spin_lock_irqsave(&events_lock, flags);
+	if (events_timer_expires && time_after(jiffies, events_timer_expires)) {
+		events_in_progress -= delayed_count;
+		event_count += delayed_count;
+		delayed_count = 0;
+		events_timer_expires = 0;
+	}
+	spin_unlock_irqrestore(&events_lock, flags);
 }
 
 /**
@@ -132,19 +145,31 @@ static void pm_wakeup_work_fn(struct wor
 void pm_wakeup_event(struct device *dev, unsigned int msec)
 {
 	unsigned long flags;
-	struct delayed_work *dwork;
-
-	dwork = msec ? kzalloc(sizeof(*dwork), GFP_ATOMIC) : NULL;
 
 	spin_lock_irqsave(&events_lock, flags);
 	if (dev)
 		dev->power.wakeup_count++;
 
-	if (dwork) {
-		INIT_DELAYED_WORK(dwork, pm_wakeup_work_fn);
-		schedule_delayed_work(dwork, msecs_to_jiffies(msec));
+	if (msec) {
+		ktime_t kt;
+		struct timespec ts;
+		unsigned long expires;
+
+		kt = ktime_get();
+		kt = ktime_add_ns(kt, msec * NSEC_PER_MSEC);
+		ts = ktime_to_timespec(kt);
+		expires = timespec_to_jiffies(&ts);
+		if (!expires)
+			expires = 1;
+
+		if (!events_timer_expires
+		    || time_after(expires, events_timer_expires)) {
+			mod_timer(&events_timer, expires);
+			events_timer_expires = expires;
+		}
 
 		events_in_progress++;
+		delayed_count++;
 	} else {
 		event_count++;
 	}
