From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 08/09] tick/xen: Provide and use tick_suspend_local() and tick_resume_local()
Date: Wed, 25 Mar 2015 22:36:11 +0100
Message-ID: <2125782.sQ1Ad8t2QI@vostro.rjw.lan>
References: <20150216121435.203983131@infradead.org> <3797850.XzqKU1ZfKa@vostro.rjw.lan> <20150325204445.GA4065@l.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61244 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750884AbbCYVMS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 17:12:18 -0400
In-Reply-To: <20150325204445.GA4065@l.oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Linux PM list <linux-pm@vger.kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Vrabel <david.vrabel@citrix.com>

On Wednesday, March 25, 2015 04:44:45 PM Konrad Rzeszutek Wilk wrote:
> On Wed, Mar 25, 2015 at 09:57:18PM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, March 25, 2015 04:13:09 PM Konrad Rzeszutek Wilk wrote:
> > > On Wed, Mar 25, 2015 at 01:11:04PM +0100, Rafael J. Wysocki wrote:
> > > > From: Thomas Gleixner <tglx@linutronix.de>
> > > > 
> > > > Xen calls on every cpu into tick_resume() which is just wrong.
> > > > tick_resume() is for the syscore global suspend/resume invocation.
> > > > What XEN really wants is a per cpu local resume function.
> > > > 
> > > > Provide a tick_resume_local() function and use it in XEN.
> > > > 
> > > > Also provide a complementary tick_suspend_local() and modify
> > > > tick_unfreeze() and tick_freeze(), respectively, to use the
> > > > new local tick resume/suspend functions.
> > > > 
> > > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > > > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > > Cc: David Vrabel <david.vrabel@citrix.com>
> > > > [ rjw: Combined two patches, rebased, modified subject/changelog ]
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  arch/x86/xen/suspend.c       |    2 -
> > > >  include/linux/tick.h         |    6 ++--
> > > >  kernel/time/tick-broadcast.c |   24 ++++++++++++------
> > > >  kernel/time/tick-common.c    |   57 +++++++++++++++++++++++++++++--------------
> > > >  kernel/time/tick-internal.h  |    8 ++++--
> > > >  5 files changed, 66 insertions(+), 31 deletions(-)
> > > > 
> > > > Index: linux-pm/arch/x86/xen/suspend.c
> > > > ===================================================================
> > > > --- linux-pm.orig/arch/x86/xen/suspend.c
> > > > +++ linux-pm/arch/x86/xen/suspend.c
> > > > @@ -85,7 +85,7 @@ static void xen_vcpu_notify_restore(void
> > > >  	if (smp_processor_id() == 0)
> > > >  		return;
> > > >  
> > > > -	tick_resume();
> > > > +	tick_resume_local();
> > > 
> > > I am looking at Linus's tree and I see:
> > > 
> > > 82 static void xen_vcpu_notify_restore(void *data)                                 
> > >  83 {                                                                               
> > >  84         unsigned long reason = (unsigned long)data;                             
> > >  85                                                                                 
> > >  86         /* Boot processor notified via generic timekeeping_resume() */          
> > >  87         if ( smp_processor_id() == 0)                                           
> > >  88                 return;                                                         
> > >  89                                                                                 
> > >  90         clockevents_notify(reason, NULL);                                       
> > >  91 }                             
> > > 
> > > So there must be another patch that altered the clockevents_notify?
> > 
> > Yes, there is.  It is the [06/09] in this series
> > (https://patchwork.kernel.org/patch/6090631/).
> > 
> > I should have CCed it to you too, sorry about that.
> 
> That is alright.
> > 
> > > Is there an git tree with all of these patches?
> > 
> > Not yet, but they all are in the linux-pm patchwork at
> > 
> > https://patchwork.kernel.org/project/linux-pm/list/
> > 
> > I can create a branch in the linux-pm.git tree for them if that helps,
> > please let me know.
> 
> If it is not too much trouble.. 

Done:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git tick-pm

Also turns out that the $subject patch was actually on top of some debug stuff
I have in tick_freeze()/tick_unfreeze(), so here goes a cleaned-up updated.

---
From: Thomas Gleixner <tglx@linutronix.de>
Subject: tick/xen: Provide and use tick_suspend_local() and tick_resume_local()

Xen calls on every cpu into tick_resume() which is just wrong.
tick_resume() is for the syscore global suspend/resume invocation.
What XEN really wants is a per cpu local resume function.

Provide a tick_resume_local() function and use it in XEN.

Also provide a complementary tick_suspend_local() and modify
tick_unfreeze() and tick_freeze(), respectively, to use the
new local tick resume/suspend functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
[ rjw: Combined two patches, rebased, modified subject/changelog ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/xen/suspend.c       |    2 -
 include/linux/tick.h         |    6 ++--
 kernel/time/tick-broadcast.c |   24 +++++++++++-----
 kernel/time/tick-common.c    |   62 ++++++++++++++++++++++++++++---------------
 kernel/time/tick-internal.h  |    8 ++++-
 5 files changed, 68 insertions(+), 34 deletions(-)

Index: linux-pm/arch/x86/xen/suspend.c
===================================================================
--- linux-pm.orig/arch/x86/xen/suspend.c
+++ linux-pm/arch/x86/xen/suspend.c
@@ -85,7 +85,7 @@ static void xen_vcpu_notify_restore(void
 	if (smp_processor_id() == 0)
 		return;
 
-	tick_resume();
+	tick_resume_local();
 }
 
 void xen_arch_resume(void)
Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -29,13 +29,13 @@ extern struct tick_device *tick_get_devi
 extern void __init tick_init(void);
 extern void tick_freeze(void);
 extern void tick_unfreeze(void);
-/* Should be core only, but XEN resume magic abuses this interface */
-extern void tick_resume(void);
+/* Should be core only, but XEN resume magic requires this */
+extern void tick_resume_local(void);
 #else /* CONFIG_GENERIC_CLOCKEVENTS */
 static inline void tick_init(void) { }
 static inline void tick_freeze(void) { }
 static inline void tick_unfreeze(void) { }
-static inline void tick_resume(void) { }
+static inline void tick_resume_local(void) { }
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
 
 #ifdef CONFIG_TICK_ONESHOT
Index: linux-pm/kernel/time/tick-broadcast.c
===================================================================
--- linux-pm.orig/kernel/time/tick-broadcast.c
+++ linux-pm/kernel/time/tick-broadcast.c
@@ -455,11 +455,26 @@ void tick_suspend_broadcast(void)
 	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
 
-int tick_resume_broadcast(void)
+/*
+ * This is called from tick_resume_local() on a resuming CPU. That's
+ * called from the core resume function, tick_unfreeze() and the magic XEN
+ * resume hackery.
+ *
+ * In none of these cases the broadcast device mode can change and the
+ * bit of the resuming CPU in the broadcast mask is safe as well.
+ */
+bool tick_resume_check_broadcast(void)
+{
+	if (tick_broadcast_device.mode == TICKDEV_MODE_ONESHOT)
+		return false;
+	else
+		return cpumask_test_cpu(smp_processor_id(), tick_broadcast_mask);
+}
+
+void tick_resume_broadcast(void)
 {
 	struct clock_event_device *bc;
 	unsigned long flags;
-	int broadcast = 0;
 
 	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
 
@@ -472,8 +487,6 @@ int tick_resume_broadcast(void)
 		case TICKDEV_MODE_PERIODIC:
 			if (!cpumask_empty(tick_broadcast_mask))
 				tick_broadcast_start_periodic(bc);
-			broadcast = cpumask_test_cpu(smp_processor_id(),
-						     tick_broadcast_mask);
 			break;
 		case TICKDEV_MODE_ONESHOT:
 			if (!cpumask_empty(tick_broadcast_mask))
@@ -482,11 +495,8 @@ int tick_resume_broadcast(void)
 		}
 	}
 	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
-
-	return broadcast;
 }
 
-
 #ifdef CONFIG_TICK_ONESHOT
 
 static cpumask_var_t tick_broadcast_oneshot_mask;
Index: linux-pm/kernel/time/tick-common.c
===================================================================
--- linux-pm.orig/kernel/time/tick-common.c
+++ linux-pm/kernel/time/tick-common.c
@@ -373,40 +373,32 @@ void tick_shutdown(unsigned int *cpup)
 }
 
 /**
- * tick_suspend - Suspend the tick and the broadcast device
+ * tick_suspend_local - Suspend the local tick device
  *
- * Called from syscore_suspend() via timekeeping_suspend with only one
- * CPU online and interrupts disabled or from tick_unfreeze() under
- * tick_freeze_lock.
+ * Called from the local cpu for freeze with interrupts disabled.
  *
  * No locks required. Nothing can change the per cpu device.
  */
-void tick_suspend(void)
+static void tick_suspend_local(void)
 {
 	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 
 	clockevents_shutdown(td->evtdev);
-	tick_suspend_broadcast();
 }
 
 /**
- * tick_resume - Resume the tick and the broadcast device
+ * tick_resume_local - Resume the local tick device
  *
- * Called from syscore_resume() via timekeeping_resume with only one
- * CPU online and interrupts disabled or from tick_unfreeze() under
- * tick_freeze_lock.
+ * Called from the local CPU for unfreeze or XEN resume magic.
  *
  * No locks required. Nothing can change the per cpu device.
  */
-void tick_resume(void)
+void tick_resume_local(void)
 {
-	struct tick_device *td;
-	int broadcast;
+	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
+	bool broadcast = tick_resume_check_broadcast();
 
-	broadcast = tick_resume_broadcast();
-	td = this_cpu_ptr(&tick_cpu_device);
 	clockevents_set_mode(td->evtdev, CLOCK_EVT_MODE_RESUME);
-
 	if (!broadcast) {
 		if (td->mode == TICKDEV_MODE_PERIODIC)
 			tick_setup_periodic(td->evtdev, 0);
@@ -415,6 +407,35 @@ void tick_resume(void)
 	}
 }
 
+/**
+ * tick_suspend - Suspend the tick and the broadcast device
+ *
+ * Called from syscore_suspend() via timekeeping_suspend with only one
+ * CPU online and interrupts disabled or from tick_unfreeze() under
+ * tick_freeze_lock.
+ *
+ * No locks required. Nothing can change the per cpu device.
+ */
+void tick_suspend(void)
+{
+	tick_suspend_local();
+	tick_suspend_broadcast();
+}
+
+/**
+ * tick_resume - Resume the tick and the broadcast device
+ *
+ * Called from syscore_resume() via timekeeping_resume with only one
+ * CPU online and interrupts disabled.
+ *
+ * No locks required. Nothing can change the per cpu device.
+ */
+void tick_resume(void)
+{
+	tick_resume_broadcast();
+	tick_resume_local();
+}
+
 static DEFINE_RAW_SPINLOCK(tick_freeze_lock);
 static unsigned int tick_freeze_depth;
 
@@ -432,11 +453,10 @@ void tick_freeze(void)
 	raw_spin_lock(&tick_freeze_lock);
 
 	tick_freeze_depth++;
-	if (tick_freeze_depth == num_online_cpus()) {
+	if (tick_freeze_depth == num_online_cpus())
 		timekeeping_suspend();
-	} else {
-		tick_suspend();
-	}
+	else
+		tick_suspend_local();
 
 	raw_spin_unlock(&tick_freeze_lock);
 }
@@ -457,7 +477,7 @@ void tick_unfreeze(void)
 	if (tick_freeze_depth == num_online_cpus())
 		timekeeping_resume();
 	else
-		tick_resume();
+		tick_resume_local();
 
 	tick_freeze_depth--;
 
Index: linux-pm/kernel/time/tick-internal.h
===================================================================
--- linux-pm.orig/kernel/time/tick-internal.h
+++ linux-pm/kernel/time/tick-internal.h
@@ -23,6 +23,7 @@ extern void tick_check_new_device(struct
 extern void tick_handover_do_timer(int *cpup);
 extern void tick_shutdown(unsigned int *cpup);
 extern void tick_suspend(void);
+extern void tick_resume(void);
 extern bool tick_check_replacement(struct clock_event_device *curdev,
 				   struct clock_event_device *newdev);
 extern void tick_install_replacement(struct clock_event_device *dev);
@@ -42,6 +43,7 @@ extern int __clockevents_update_freq(str
 extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
 #else
 static inline void tick_suspend(void) { }
+static inline void tick_resume(void) { }
 #endif /* GENERIC_CLOCKEVENTS */
 
 /* Oneshot related functions */
@@ -80,7 +82,8 @@ extern int tick_is_broadcast_device(stru
 extern void tick_broadcast_on_off(unsigned long reason, int *oncpu);
 extern void tick_shutdown_broadcast(unsigned int *cpup);
 extern void tick_suspend_broadcast(void);
-extern int tick_resume_broadcast(void);
+extern void tick_resume_broadcast(void);
+extern bool tick_resume_check_broadcast(void);
 extern void tick_broadcast_init(void);
 extern void tick_set_periodic_handler(struct clock_event_device *dev, int broadcast);
 extern int tick_broadcast_update_freq(struct clock_event_device *dev, u32 freq);
@@ -94,7 +97,8 @@ static inline void tick_do_periodic_broa
 static inline void tick_broadcast_on_off(unsigned long reason, int *oncpu) { }
 static inline void tick_shutdown_broadcast(unsigned int *cpup) { }
 static inline void tick_suspend_broadcast(void) { }
-static inline int tick_resume_broadcast(void) { return 0; }
+static inline void tick_resume_broadcast(void) { }
+static inline bool tick_resume_check_broadcast(void) { return false; }
 static inline void tick_broadcast_init(void) { }
 static inline int tick_broadcast_update_freq(struct clock_event_device *dev, u32 freq) { return -ENODEV; }
 

