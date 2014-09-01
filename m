From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 05/13] genirq: Move MASK_ON_SUSPEND handling into suspend_device_irqs()
Date: Mon, 01 Sep 2014 16:22:48 +0200
Message-ID: <2238551.UOAGsm8nN1@vostro.rjw.lan>
References: <26580319.OZP7jvJnA9@vostro.rjw.lan> <5320472.coYotHR1d0@vostro.rjw.lan> <2516134.pmOxkEuOOy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2516134.pmOxkEuOOy@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>, Aubrey Li <aubrey.li@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There is no reason why we should delay the masking of interrupts whose
interrupt chip requests MASK_ON_SUSPEND to the point where we check
the wakeup interrupts. We can do it right at the point where we mark
the interrupt as suspended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/irq/pm.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

Index: linux/kernel/irq/pm.c
===================================================================
--- linux.orig/kernel/irq/pm.c
+++ linux/kernel/irq/pm.c
@@ -56,6 +56,15 @@ static void suspend_device_irq(struct ir
 
 	desc->istate |= IRQS_SUSPENDED;
 	__disable_irq(desc, irq);
+
+	/*
+	 * Hardware which has no wakeup source configuration facility
+	 * requires that the non wakeup interrupts are masked at the
+	 * chip level. The chip implementation indicates that with
+	 * IRQCHIP_MASK_ON_SUSPEND.
+	 */
+	if (irq_desc_get_chip(desc)->flags & IRQCHIP_MASK_ON_SUSPEND)
+		mask_irq(desc);
 }
 
 /**
@@ -176,19 +185,7 @@ int check_wakeup_irqs(void)
 		if (irqd_is_wakeup_set(&desc->irq_data)) {
 			if (desc->depth == 1 && desc->istate & IRQS_PENDING)
 				return -EBUSY;
-			continue;
 		}
-		/*
-		 * Check the non wakeup interrupts whether they need
-		 * to be masked before finally going into suspend
-		 * state. That's for hardware which has no wakeup
-		 * source configuration facility. The chip
-		 * implementation indicates that with
-		 * IRQCHIP_MASK_ON_SUSPEND.
-		 */
-		if (desc->istate & IRQS_SUSPENDED &&
-		    irq_desc_get_chip(desc)->flags & IRQCHIP_MASK_ON_SUSPEND)
-			mask_irq(desc);
 	}
 
 	return 0;
