From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 06/13] genirq: Avoid double loop on suspend
Date: Mon, 01 Sep 2014 16:23:26 +0200
Message-ID: <4587460.iSV9EpUBUu@vostro.rjw.lan>
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

We can synchronize the suspended interrupts right away. No need for an
extra loop.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/irq/pm.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: linux/kernel/irq/pm.c
===================================================================
--- linux.orig/kernel/irq/pm.c
+++ linux/kernel/irq/pm.c
@@ -49,10 +49,10 @@ void irq_pm_remove_action(struct irq_des
 		desc->no_suspend_depth--;
 }
 
-static void suspend_device_irq(struct irq_desc *desc, int irq)
+static bool suspend_device_irq(struct irq_desc *desc, int irq)
 {
 	if (!desc->action || desc->no_suspend_depth)
-		return;
+		return false;
 
 	desc->istate |= IRQS_SUSPENDED;
 	__disable_irq(desc, irq);
@@ -65,6 +65,7 @@ static void suspend_device_irq(struct ir
 	 */
 	if (irq_desc_get_chip(desc)->flags & IRQCHIP_MASK_ON_SUSPEND)
 		mask_irq(desc);
+	return true;
 }
 
 /**
@@ -86,15 +87,15 @@ void suspend_device_irqs(void)
 
 	for_each_irq_desc(irq, desc) {
 		unsigned long flags;
+		bool sync;
 
 		raw_spin_lock_irqsave(&desc->lock, flags);
-		suspend_device_irq(desc, irq);
+		sync = suspend_device_irq(desc, irq);
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
 
-	for_each_irq_desc(irq, desc)
-		if (desc->istate & IRQS_SUSPENDED)
+		if (sync)
 			synchronize_irq(irq);
+	}
 }
 EXPORT_SYMBOL_GPL(suspend_device_irqs);
 
