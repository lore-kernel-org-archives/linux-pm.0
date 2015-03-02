From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] drivers: cpuidle: minor suspend-to-idle fixes
Date: Mon, 02 Mar 2015 14:13:05 +0100
Message-ID: <1809382.kscziWfTPN@vostro.rjw.lan>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com> <1504255.fW6WeRrizi@vostro.rjw.lan> <20150302100823.GA23990@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150302100823.GA23990@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Monday, March 02, 2015 10:08:23 AM Lorenzo Pieralisi wrote:
> On Sat, Feb 28, 2015 at 11:58:21PM +0000, Rafael J. Wysocki wrote:
> > On Saturday, February 28, 2015 11:54:23 AM Lorenzo Pieralisi wrote:

[cut]

> > Index: linux-pm/drivers/cpuidle/cpuidle.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> > +++ linux-pm/drivers/cpuidle/cpuidle.c
> > @@ -230,15 +230,39 @@ int cpuidle_select(struct cpuidle_driver
> >   * @dev:   the cpuidle device
> >   * @index: the index in the idle state table
> >   *
> > - * Returns the index in the idle state, < 0 in case of error.
> > - * The error code depends on the backend driver
> > + * Returns the index in the idle state, < 0 in case of error.  -EBUSY is
> > + * returned to indicate that the target state was temporarily inaccessible.
> > + * The other error codes depend on the backend driver.
> >   */
> >  int cpuidle_enter(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> >  		  int index)
> >  {
> > -	if (cpuidle_state_is_coupled(dev, drv, index))
> > -		return cpuidle_enter_state_coupled(dev, drv, index);
> > -	return cpuidle_enter_state(dev, drv, index);
> > +	unsigned int broadcast;
> > +	int ret;
> > +
> > +	broadcast = drv->states[index].flags & CPUIDLE_FLAG_TIMER_STOP;
> > +
> > +	/*
> > +	 * Tell the time framework to switch to a broadcast timer
> > +	 * because our local timer will be shutdown. If a local timer
> > +	 * is used from another cpu as a broadcast timer, this call may
> > +	 * fail if it is not available
> > +	 */
> > +	if (broadcast) {
> > +		ret = clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
> > +					 &dev->cpu);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ret = cpuidle_state_is_coupled(dev, drv, index) ?
> > +		cpuidle_enter_state_coupled(dev, drv, index) :
> > +		cpuidle_enter_state(dev, drv, index);
> > +
> > +	if (broadcast)
> > +		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
> > +
> > +	return ret;
> 
> You have to check this return value in cpuidle_enter_freeze() too
> otherwise we return to the idle thread on -EBUSY without
> even executing arch_cpu_idle() and with IRQ disabled, code hits
> the WARN_ON_ONCE line 180.

Right.

> There are multiple ways of fixing the issue, either you check the
> cpuidle_enter_freeze() return value (you add one) to cpuidle_idle_call()
> to make code consistent with the cpuidle_idle_call "normal" idle
> behaviour or you add the return value check in cpuidle_enter_freeze(),
> I am fine both ways.

Well, in both cases we'd end up with a function enabling interrupts on exit
in some cases and not doing that in some other ones.  Not nice.

Below is an alternative to that (on top of the previous patches).  Can you
test it please?

Rafael


---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: cpuidle / sleep: Use broadcast timer for states that stop local timer

Commit 381063133246 (PM / sleep: Re-implement suspend-to-idle handling)
overlooked the fact that entering some sufficiently deep idle states
by CPUs may cause their local timers to stop and in those cases it
is necessary to switch over to a broadcase timer prior to entering
the idle state.  If the cpuidle driver in use does not provide
the new ->enter_freeze callback for any of the idle states, that
problem affects suspend-to-idle too, but it is not taken into account
after the changes made by commit 381063133246.

Fix that by changing the definition of cpuidle_enter_freeze() and
re-arranging of the code in cpuidle_idle_call(), so the former does
not call cpuidle_enter() any more and the fallback case is handled
by cpuidle_idle_call() directly.

Fixes: 381063133246 (PM / sleep: Re-implement suspend-to-idle handling)
Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |   53 +++++++++++++++++++---------------------------
 include/linux/cpuidle.h   |    8 +++++-
 kernel/sched/idle.c       |   18 +++++++++++++--
 3 files changed, 43 insertions(+), 36 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -44,9 +44,11 @@ void disable_cpuidle(void)
 	off = 1;
 }
 
-static bool cpuidle_not_available(struct cpuidle_driver *drv,
-				  struct cpuidle_device *dev)
+bool cpuidle_not_available(void)
 {
+	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+
 	return off || !initialized || !drv || !dev || !dev->enabled;
 }
 
@@ -73,13 +75,13 @@ int cpuidle_play_dead(void)
 }
 
 /**
- * cpuidle_find_deepest_state - Find deepest state meeting specific conditions.
+ * find_deepest_state - Find deepest state meeting specific conditions.
  * @drv: cpuidle driver for the given CPU.
  * @dev: cpuidle device for the given CPU.
  * @freeze: Whether or not the state should be suitable for suspend-to-idle.
  */
-static int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-				      struct cpuidle_device *dev, bool freeze)
+static int find_deepest_state(struct cpuidle_driver *drv,
+			      struct cpuidle_device *dev, bool freeze)
 {
 	unsigned int latency_req = 0;
 	int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
@@ -98,6 +100,17 @@ static int cpuidle_find_deepest_state(st
 	return ret;
 }
 
+/**
+ * cpuidle_find_deepest_state - Find the deepest available idle state.
+ */
+int cpuidle_find_deepest_state(void)
+{
+	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+
+	return find_deepest_state(drv, dev, false);
+}
+
 static void enter_freeze_proper(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev, int index)
 {
@@ -123,42 +136,23 @@ static void enter_freeze_proper(struct c
  * If there are states with the ->enter_freeze callback, find the deepest of
  * them and enter it with frozen tick.  Otherwise, find the deepest state
  * available and enter it normally.
- *
- * Returns with enabled interrupts.
  */
-void cpuidle_enter_freeze(void)
+int cpuidle_enter_freeze(void)
 {
 	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 	int index;
 
-	if (cpuidle_not_available(drv, dev))
-		goto fallback;
-
 	/*
 	 * Find the deepest state with ->enter_freeze present, which guarantees
 	 * that interrupts won't be enabled when it exits and allows the tick to
 	 * be frozen safely.
 	 */
-	index = cpuidle_find_deepest_state(drv, dev, true);
-	if (index >= 0) {
+	index = find_deepest_state(drv, dev, true);
+	if (index >= 0)
 		enter_freeze_proper(drv, dev, index);
-		local_irq_enable();
-		return;
-	}
-
-	/*
-	 * It is not safe to freeze the tick, find the deepest state available
-	 * at all and try to enter it normally.
-	 */
-	index = cpuidle_find_deepest_state(drv, dev, false);
-	if (index >= 0) {
-		cpuidle_enter(drv, dev, index);
-		return;
-	}
 
- fallback:
-	arch_cpu_idle();
+	return index;
 }
 
 /**
@@ -217,9 +211,6 @@ int cpuidle_enter_state(struct cpuidle_d
  */
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
-	if (cpuidle_not_available(drv, dev))
-		return -ENODEV;
-
 	return cpuidle_curr_governor->select(drv, dev);
 }
 
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -126,6 +126,7 @@ struct cpuidle_driver {
 
 #ifdef CONFIG_CPU_IDLE
 extern void disable_cpuidle(void);
+extern bool cpuidle_not_available(void);
 
 extern int cpuidle_select(struct cpuidle_driver *drv,
 			  struct cpuidle_device *dev);
@@ -150,11 +151,13 @@ extern void cpuidle_resume(void);
 extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
 extern int cpuidle_play_dead(void);
-extern void cpuidle_enter_freeze(void);
+extern int cpuidle_find_deepest_state(void);
+extern int cpuidle_enter_freeze(void);
 
 extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
 #else
 static inline void disable_cpuidle(void) { }
+static inline bool cpuidle_not_available(void) {return true; }
 static inline int cpuidle_select(struct cpuidle_driver *drv,
 				 struct cpuidle_device *dev)
 {return -ENODEV; }
@@ -183,7 +186,8 @@ static inline int cpuidle_enable_device(
 {return -ENODEV; }
 static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
 static inline int cpuidle_play_dead(void) {return -ENODEV; }
-static inline void cpuidle_enter_freeze(void) { }
+static inline int cpuidle_find_deepest_state(void) {return -ENODEV; }
+static inline int cpuidle_enter_freeze(void) {return -ENODEV; }
 static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
 	struct cpuidle_device *dev) {return NULL; }
 #endif
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -105,6 +105,9 @@ static void cpuidle_idle_call(void)
 	 */
 	rcu_idle_enter();
 
+	if (cpuidle_not_available())
+		goto use_default;
+
 	/*
 	 * Suspend-to-idle ("freeze") is a system state in which all user space
 	 * has been frozen, all I/O devices have been suspended and the only
@@ -115,8 +118,17 @@ static void cpuidle_idle_call(void)
 	 * until a proper wakeup interrupt happens.
 	 */
 	if (idle_should_freeze()) {
-		cpuidle_enter_freeze();
-		goto exit_idle;
+		entered_state = cpuidle_enter_freeze();
+		if (entered_state >= 0) {
+			local_irq_enable();
+			goto exit_idle;
+		}
+
+		next_state = cpuidle_find_deepest_state();
+		if (next_state >= 0)
+			goto enter_idle;
+		else
+			goto use_default;
 	}
 
 	/*
@@ -138,7 +150,7 @@ use_default:
 		goto exit_idle;
 	}
 
-
+enter_idle:
 	/*
 	 * The idle task must be scheduled, it is pointless to
 	 * go to idle, just update no idle residency and get
