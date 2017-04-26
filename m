From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/5] PM / wakeup: Integrate mechanism to abort transitions in progress
Date: Wed, 26 Apr 2017 23:22:09 +0200
Message-ID: <6281089.pVH57fyP0i@aspire.rjw.lan>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The system wakeup framework is not very consistent with respect to
the way it handles suspend-to-idle and generally wakeup events
occurring during transitions to system low-power states.

First off, system transitions in progress are aborted by the event
reporting helpers like pm_wakeup_event() only if the wakeup_count
sysfs attribute is in use (as documented), but there are cases in
which system-wide transitions should be aborted even if that is
not the case.  For example, a wakeup signal from a designated
wakeup device during system-wide PM transition, it should cause
the transition to be aborted right away.

Moreover, there is a freeze_wake() call in wakeup_source_activate(),
but that really is only effective after suspend_freeze_state has
been set to FREEZE_STATE_ENTER by freeze_enter().  However, it
is very unlikely that wakeup_source_activate() will ever be called
at that time, as it could only be triggered by a IRQF_NO_SUSPEND
interrupt handler, so wakeups from suspend-to-idle don't really
occur in wakeup_source_activate().

At the same time there is a way to abort a system suspend in
progress (or wake up the system from suspend-to-idle), which is by
calling pm_system_wakeup(), but in turn that doesn't cause any
wakeup source objects to be activated, so it will not be covered
by wakeup source statistics and will not prevent the system from
suspending again immediately (in case autosleep is used, for
example).  Consequently, if anyone wants to abort system transitions
in progress and allow the wakeup_count mechanism to work, they need
to use both pm_system_wakeup() and pm_wakeup_event(), say, at the
same time which is awkward.

For the above reasons, make it possible to trigger
pm_system_wakeup() from within wakeup_source_activate() and
provide a new pm_wakeup_hard_event() helper to do so within the
wakeup framework.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/wakeup.c |   36 ++++++++++++++++++------------------
 include/linux/pm_wakeup.h   |   25 +++++++++++++++++++++----
 2 files changed, 39 insertions(+), 22 deletions(-)

Index: linux-pm/include/linux/pm_wakeup.h
===================================================================
--- linux-pm.orig/include/linux/pm_wakeup.h
+++ linux-pm/include/linux/pm_wakeup.h
@@ -106,8 +106,8 @@ extern void __pm_stay_awake(struct wakeu
 extern void pm_stay_awake(struct device *dev);
 extern void __pm_relax(struct wakeup_source *ws);
 extern void pm_relax(struct device *dev);
-extern void __pm_wakeup_event(struct wakeup_source *ws, unsigned int msec);
-extern void pm_wakeup_event(struct device *dev, unsigned int msec);
+extern void pm_wakeup_ws_event(struct wakeup_source *ws, unsigned int msec, bool hard);
+extern void pm_wakeup_dev_event(struct device *dev, unsigned int msec, bool hard);
 
 #else /* !CONFIG_PM_SLEEP */
 
@@ -182,9 +182,11 @@ static inline void __pm_relax(struct wak
 
 static inline void pm_relax(struct device *dev) {}
 
-static inline void __pm_wakeup_event(struct wakeup_source *ws, unsigned int msec) {}
+static inline void pm_wakeup_ws_event(struct wakeup_source *ws,
+				      unsigned int msec, bool hard) {}
 
-static inline void pm_wakeup_event(struct device *dev, unsigned int msec) {}
+static inline void pm_wakeup_dev_event(struct device *dev, unsigned int msec,
+				       bool hard) {}
 
 #endif /* !CONFIG_PM_SLEEP */
 
@@ -201,4 +203,19 @@ static inline void wakeup_source_trash(s
 	wakeup_source_drop(ws);
 }
 
+static inline void __pm_wakeup_event(struct wakeup_source *ws, unsigned int msec)
+{
+	return pm_wakeup_ws_event(ws, msec, false);
+}
+
+static inline void pm_wakeup_event(struct device *dev, unsigned int msec)
+{
+	return pm_wakeup_dev_event(dev, msec, false);
+}
+
+static inline void pm_wakeup_hard_event(struct device *dev)
+{
+	return pm_wakeup_dev_event(dev, 0, true);
+}
+
 #endif /* _LINUX_PM_WAKEUP_H */
Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -512,12 +512,13 @@ static bool wakeup_source_not_registered
 /**
  * wakup_source_activate - Mark given wakeup source as active.
  * @ws: Wakeup source to handle.
+ * @hard: If set, abort suspends in progress and wake up from suspend-to-idle.
  *
  * Update the @ws' statistics and, if @ws has just been activated, notify the PM
  * core of the event by incrementing the counter of of wakeup events being
  * processed.
  */
-static void wakeup_source_activate(struct wakeup_source *ws)
+static void wakeup_source_activate(struct wakeup_source *ws, bool hard)
 {
 	unsigned int cec;
 
@@ -525,11 +526,8 @@ static void wakeup_source_activate(struc
 			"unregistered wakeup source\n"))
 		return;
 
-	/*
-	 * active wakeup source should bring the system
-	 * out of PM_SUSPEND_FREEZE state
-	 */
-	freeze_wake();
+	if (hard)
+		pm_system_wakeup();
 
 	ws->active = true;
 	ws->active_count++;
@@ -546,8 +544,9 @@ static void wakeup_source_activate(struc
 /**
  * wakeup_source_report_event - Report wakeup event using the given source.
  * @ws: Wakeup source to report the event for.
+ * @hard: If set, abort suspends in progress and wake up from suspend-to-idle.
  */
-static void wakeup_source_report_event(struct wakeup_source *ws)
+static void wakeup_source_report_event(struct wakeup_source *ws, bool hard)
 {
 	ws->event_count++;
 	/* This is racy, but the counter is approximate anyway. */
@@ -555,7 +554,7 @@ static void wakeup_source_report_event(s
 		ws->wakeup_count++;
 
 	if (!ws->active)
-		wakeup_source_activate(ws);
+		wakeup_source_activate(ws, hard);
 }
 
 /**
@@ -573,7 +572,7 @@ void __pm_stay_awake(struct wakeup_sourc
 
 	spin_lock_irqsave(&ws->lock, flags);
 
-	wakeup_source_report_event(ws);
+	wakeup_source_report_event(ws, false);
 	del_timer(&ws->timer);
 	ws->timer_expires = 0;
 
@@ -739,9 +738,10 @@ static void pm_wakeup_timer_fn(unsigned
 }
 
 /**
- * __pm_wakeup_event - Notify the PM core of a wakeup event.
+ * pm_wakeup_ws_event - Notify the PM core of a wakeup event.
  * @ws: Wakeup source object associated with the event source.
  * @msec: Anticipated event processing time (in milliseconds).
+ * @hard: If set, abort suspends in progress and wake up from suspend-to-idle.
  *
  * Notify the PM core of a wakeup event whose source is @ws that will take
  * approximately @msec milliseconds to be processed by the kernel.  If @ws is
@@ -750,7 +750,7 @@ static void pm_wakeup_timer_fn(unsigned
  *
  * It is safe to call this function from interrupt context.
  */
-void __pm_wakeup_event(struct wakeup_source *ws, unsigned int msec)
+void pm_wakeup_ws_event(struct wakeup_source *ws, unsigned int msec, bool hard)
 {
 	unsigned long flags;
 	unsigned long expires;
@@ -760,7 +760,7 @@ void __pm_wakeup_event(struct wakeup_sou
 
 	spin_lock_irqsave(&ws->lock, flags);
 
-	wakeup_source_report_event(ws);
+	wakeup_source_report_event(ws, hard);
 
 	if (!msec) {
 		wakeup_source_deactivate(ws);
@@ -779,17 +779,17 @@ void __pm_wakeup_event(struct wakeup_sou
  unlock:
 	spin_unlock_irqrestore(&ws->lock, flags);
 }
-EXPORT_SYMBOL_GPL(__pm_wakeup_event);
-
+EXPORT_SYMBOL_GPL(pm_wakeup_ws_event);
 
 /**
  * pm_wakeup_event - Notify the PM core of a wakeup event.
  * @dev: Device the wakeup event is related to.
  * @msec: Anticipated event processing time (in milliseconds).
+ * @hard: If set, abort suspends in progress and wake up from suspend-to-idle.
  *
- * Call __pm_wakeup_event() for the @dev's wakeup source object.
+ * Call pm_wakeup_ws_event() for the @dev's wakeup source object.
  */
-void pm_wakeup_event(struct device *dev, unsigned int msec)
+void pm_wakeup_dev_event(struct device *dev, unsigned int msec, bool hard)
 {
 	unsigned long flags;
 
@@ -797,10 +797,10 @@ void pm_wakeup_event(struct device *dev,
 		return;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
-	__pm_wakeup_event(dev->power.wakeup, msec);
+	pm_wakeup_ws_event(dev->power.wakeup, msec, hard);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 }
-EXPORT_SYMBOL_GPL(pm_wakeup_event);
+EXPORT_SYMBOL_GPL(pm_wakeup_dev_event);
 
 void pm_print_active_wakeup_sources(void)
 {

