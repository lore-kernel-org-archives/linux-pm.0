From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] genirq / PM: Add flag for shared NO_SUSPEND interrupt lines
Date: Fri, 27 Feb 2015 00:07:55 +0100
Message-ID: <6864616.1aRDSmSsvx@vostro.rjw.lan>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com> <8151717.nkhnGBri9h@vostro.rjw.lan> <20150226191724.0ae4ca4e@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63218 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754743AbbBZWoa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 17:44:30 -0500
In-Reply-To: <20150226191724.0ae4ca4e@bbrezillon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It currently is required that all users of NO_SUSPEND interrupt
lines pass the IRQF_NO_SUSPEND flag when requesting the IRQ or the
WARN_ON_ONCE() in irq_pm_install_action() will trigger.  That is
done to warn about situations in which unprepared interrupt handlers
may be run unnecessarily for suspended devices and may attempt to
access those devices by mistake.  However, it may cause drivers
that have no technical reasons for using IRQF_NO_SUSPEND to set
that flag just because they happen to share the interrupt line
with something like a timer.

Moreover, the generic handling of wakeup interrupts introduced by
commit 9ce7a25849e8 (genirq: Simplify wakeup mechanism) only works
for IRQs without any NO_SUSPEND users, so the drivers of wakeup
devices needing to use shared NO_SUSPEND interrupt lines for
signaling system wakeup generally have to detect wakeup in their
interrupt handlers.  Thus if they happen to share an interrupt line
with a NO_SUSPEND user, they also need to request that their
interrupt handlers be run after suspend_device_irqs().

In both cases the reason for using IRQF_NO_SUSPEND is not because
the driver in question has a genuine need to run its interrupt
handler after suspend_device_irqs(), but because it happens to
share the line with some other NO_SUSPEND user.  Otherwise, the
driver would do without IRQF_NO_SUSPEND just fine.

To make it possible to specify that condition explicitly, introduce
a new IRQ action handler flag for shared IRQs, IRQF_COND_SUSPEND,
that, when set, will indicate to the IRQ core that the interrupt
user is generally fine with suspending the IRQ, but it also can
tolerate handler invocations after suspend_device_irqs() and, in
particular, it is capable of detecting system wakeup and triggering
it as appropriate from its interrupt handler.

That will allow us to work around a problem with a shared timer
interrupt line on at91 platforms.

Link: http://marc.info/?l=linux-kernel&m=142252777602084&w=2
Link: http://marc.info/?t=142252775300011&r=1&w=2
Linx: https://lkml.org/lkml/2014/12/15/552
Reported-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/interrupt.h |    5 +++++
 include/linux/irqdesc.h   |    1 +
 kernel/irq/manage.c       |    7 ++++++-
 kernel/irq/pm.c           |    7 ++++++-
 4 files changed, 18 insertions(+), 2 deletions(-)

Index: linux-pm/include/linux/interrupt.h
===================================================================
--- linux-pm.orig/include/linux/interrupt.h
+++ linux-pm/include/linux/interrupt.h
@@ -57,6 +57,10 @@
  * IRQF_NO_THREAD - Interrupt cannot be threaded
  * IRQF_EARLY_RESUME - Resume IRQ early during syscore instead of at device
  *                resume time.
+ * IRQF_COND_SUSPEND - If the IRQ is shared with a NO_SUSPEND user, execute this
+ *                interrupt handler after suspending interrupts. For system
+ *                wakeup devices users need to implement wakeup detection in
+ *                their interrupt handlers.
  */
 #define IRQF_DISABLED		0x00000020
 #define IRQF_SHARED		0x00000080
@@ -70,6 +74,7 @@
 #define IRQF_FORCE_RESUME	0x00008000
 #define IRQF_NO_THREAD		0x00010000
 #define IRQF_EARLY_RESUME	0x00020000
+#define IRQF_COND_SUSPEND	0x00040000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
Index: linux-pm/include/linux/irqdesc.h
===================================================================
--- linux-pm.orig/include/linux/irqdesc.h
+++ linux-pm/include/linux/irqdesc.h
@@ -78,6 +78,7 @@ struct irq_desc {
 #ifdef CONFIG_PM_SLEEP
 	unsigned int		nr_actions;
 	unsigned int		no_suspend_depth;
+	unsigned int		cond_suspend_depth;
 	unsigned int		force_resume_depth;
 #endif
 #ifdef CONFIG_PROC_FS
Index: linux-pm/kernel/irq/pm.c
===================================================================
--- linux-pm.orig/kernel/irq/pm.c
+++ linux-pm/kernel/irq/pm.c
@@ -43,9 +43,12 @@ void irq_pm_install_action(struct irq_de
 
 	if (action->flags & IRQF_NO_SUSPEND)
 		desc->no_suspend_depth++;
+	else if (action->flags & IRQF_COND_SUSPEND)
+		desc->cond_suspend_depth++;
 
 	WARN_ON_ONCE(desc->no_suspend_depth &&
-		     desc->no_suspend_depth != desc->nr_actions);
+		     (desc->no_suspend_depth +
+			desc->cond_suspend_depth) != desc->nr_actions);
 }
 
 /*
@@ -61,6 +64,8 @@ void irq_pm_remove_action(struct irq_des
 
 	if (action->flags & IRQF_NO_SUSPEND)
 		desc->no_suspend_depth--;
+	else if (action->flags & IRQF_COND_SUSPEND)
+		desc->cond_suspend_depth--;
 }
 
 static bool suspend_device_irq(struct irq_desc *desc, int irq)
Index: linux-pm/kernel/irq/manage.c
===================================================================
--- linux-pm.orig/kernel/irq/manage.c
+++ linux-pm/kernel/irq/manage.c
@@ -1474,8 +1474,13 @@ int request_threaded_irq(unsigned int ir
 	 * otherwise we'll have trouble later trying to figure out
 	 * which interrupt is which (messes up the interrupt freeing
 	 * logic etc).
+	 *
+	 * Also IRQF_COND_SUSPEND only makes sense for shared interrupts and
+	 * it cannot be set along with IRQF_NO_SUSPEND.
 	 */
-	if ((irqflags & IRQF_SHARED) && !dev_id)
+	if (((irqflags & IRQF_SHARED) && !dev_id) ||
+	    (!(irqflags & IRQF_SHARED) && (irqflags & IRQF_COND_SUSPEND)) ||
+	    ((irqflags & IRQF_NO_SUSPEND) && (irqflags & IRQF_COND_SUSPEND)))
 		return -EINVAL;
 
 	desc = irq_to_desc(irq);
