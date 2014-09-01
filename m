From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 09/13] genirq: Mark wakeup sources as armed on suspend
Date: Mon, 01 Sep 2014 16:26:30 +0200
Message-ID: <2050968.VQ4Dx34hgg@vostro.rjw.lan>
References: <26580319.OZP7jvJnA9@vostro.rjw.lan> <5320472.coYotHR1d0@vostro.rjw.lan> <2516134.pmOxkEuOOy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <2516134.pmOxkEuOOy@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>, Aubrey Li <aubrey.li@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

This allows us to utilize this information in the irq_may_run() check
without adding another conditional to the fast path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/irq.h |    8 ++++++++
 kernel/irq/pm.c     |    5 +++++
 2 files changed, 13 insertions(+)

Index: linux/include/linux/irq.h
===================================================================
--- linux.orig/include/linux/irq.h
+++ linux/include/linux/irq.h
@@ -173,6 +173,7 @@ struct irq_data {
  * IRQD_IRQ_DISABLED		- Disabled state of the interrupt
  * IRQD_IRQ_MASKED		- Masked state of the interrupt
  * IRQD_IRQ_INPROGRESS		- In progress state of the interrupt
+ * IRQD_WAKEUP_ARMED		- Wakeup mode armed
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -186,6 +187,7 @@ enum {
 	IRQD_IRQ_DISABLED		= (1 << 16),
 	IRQD_IRQ_MASKED			= (1 << 17),
 	IRQD_IRQ_INPROGRESS		= (1 << 18),
+	IRQD_WAKEUP_ARMED		= (1 << 19),
 };
 
 static inline bool irqd_is_setaffinity_pending(struct irq_data *d)
@@ -257,6 +259,12 @@ static inline bool irqd_irq_inprogress(s
 	return d->state_use_accessors & IRQD_IRQ_INPROGRESS;
 }
 
+static inline bool irqd_is_wakeup_armed(struct irq_data *d)
+{
+	return d->state_use_accessors & IRQD_WAKEUP_ARMED;
+}
+
+
 /*
  * Functions for chained handlers which can be enabled/disabled by the
  * standard disable_irq/enable_irq calls. Must be called with
Index: linux/kernel/irq/pm.c
===================================================================
--- linux.orig/kernel/irq/pm.c
+++ linux/kernel/irq/pm.c
@@ -54,6 +54,9 @@ static bool suspend_device_irq(struct ir
 	if (!desc->action || desc->no_suspend_depth)
 		return false;
 
+	if (irqd_is_wakeup_set(&desc->irq_data))
+		irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
+
 	desc->istate |= IRQS_SUSPENDED;
 	__disable_irq(desc, irq);
 
@@ -101,6 +104,8 @@ EXPORT_SYMBOL_GPL(suspend_device_irqs);
 
 static void resume_irq(struct irq_desc *desc, int irq)
 {
+	irqd_clear(&desc->irq_data, IRQD_WAKEUP_ARMED);
+
 	if (desc->istate & IRQS_SUSPENDED)
 		goto resume;
 
