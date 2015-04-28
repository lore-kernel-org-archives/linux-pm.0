From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 16/20] sched/idle: Use explicit broadcast oneshot control function
Date: Tue, 28 Apr 2015 15:31:54 +0200
Message-ID: <8051605.iKEaLUIlGb@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <CAJZ5v0j+9gzpfZMyj1Pjnfr8VCoiFirD_U77-wRTn0vpM+Tz8g@mail.gmail.com> <CACRpkdZ2kueU5-kZx2-eTBg9B=nUpU1Anx8u+M3XckRUYWWwnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZ2kueU5-kZx2-eTBg9B=nUpU1Anx8u+M3XckRUYWWwnQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 28, 2015 02:37:10 PM Linus Walleij wrote:
> On Tue, Apr 28, 2015 at 2:19 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > Sudeep:
> >> At-least I observed issue only when I am using hardware broadcast timer.
> >> It doesn't hang when I am using hrtimer as broadcast timer in which case
> >> one of the cpu will be not enter deeper idle states that lose timer.
> >> I will rerun on v4.1-rc1 and post the complete log.
> >
> > So the bug here is that cpuidle_enter() enables interrupts, so the
> > assumption about them being not enabled made by
> > tick_broadcast_oneshot_control() is actually not valid.
> >
> > It looks like we need to acquire the clockevents_lock at least in this
> > particular case.  Let me see where to put it and I'll send a patch for
> > testing.
> 
> Aha that looks very much like it. Put me on the patch and I'll
> take it for a spin.

OK, so something like the below for starters (the _irqsave variant is used to
avoid adding one more WARN_ON(irqs_disabled()) in there).

I haven't tested it, but then I can't reproduce the original issue in the
first place.

---
 include/linux/clockchips.h |    2 ++
 kernel/sched/idle.c        |    2 +-
 kernel/time/clockevents.c  |   15 +++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

Index: linux-pm/include/linux/clockchips.h
===================================================================
--- linux-pm.orig/include/linux/clockchips.h
+++ linux-pm/include/linux/clockchips.h
@@ -198,9 +198,11 @@ extern int tick_receive_broadcast(void);
 # if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_TICK_ONESHOT)
 extern void tick_setup_hrtimer_broadcast(void);
 extern int tick_check_broadcast_expired(void);
+extern void tick_broadcast_exit_idle(void);
 # else
 static inline int tick_check_broadcast_expired(void) { return 0; }
 static inline void tick_setup_hrtimer_broadcast(void) { }
+static inline void tick_broadcast_exit_idle(void) { }
 # endif
 
 extern int clockevents_notify(unsigned long reason, void *arg);
Index: linux-pm/kernel/time/clockevents.c
===================================================================
--- linux-pm.orig/kernel/time/clockevents.c
+++ linux-pm/kernel/time/clockevents.c
@@ -735,6 +735,21 @@ static ssize_t sysfs_unbind_tick_dev(str
 static DEVICE_ATTR(unbind_device, 0200, NULL, sysfs_unbind_tick_dev);
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+/**
+ * tick_broadcast_exit_idle - Broadcast oneshot mode exit for the idle loop.
+ *
+ * The idle loop exits the broadcast oneshot mode with interrupts enabled, so
+ * clockevents_lock needs to be acquired around that.
+ */
+void tick_broadcast_exit_idle(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&clockevents_lock, flags);
+	tick_broadcast_exit();
+	raw_spin_unlock_irqrestore(&clockevents_lock, flags);
+}
+
 static struct device tick_bc_dev = {
 	.init_name	= "broadcast",
 	.id		= 0,
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -175,7 +175,7 @@ static void cpuidle_idle_call(void)
 	idle_set_state(this_rq(), NULL);
 
 	if (broadcast)
-		tick_broadcast_exit();
+		tick_broadcast_exit_idle();
 
 	/*
 	 * Give the governor an opportunity to reflect on the outcome

