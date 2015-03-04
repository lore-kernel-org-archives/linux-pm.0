From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] genirq: describe IRQF_COND_SUSPEND
Date: Wed, 4 Mar 2015 20:00:40 +0000
Message-ID: <20150304200040.GA12126@leverpostej>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <8151717.nkhnGBri9h@vostro.rjw.lan>
 <20150226191724.0ae4ca4e@bbrezillon>
 <6864616.1aRDSmSsvx@vostro.rjw.lan>
 <20150304194246.GF22156@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150304194246.GF22156@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

With certain restrictions it is possible for a wakeup device to share
and IRQ with an IRQF_NO_SUSPEND user, and the warnings introduced by
commit cab303be91dc47942bc25de33dc1140123540800 are spurious. The new
IRQF_COND_SUSPEND flag allows drivers to tell the core when these
restrictions are met, allowing spurious warnings to be silenced.

This patch documents how IRQF_COND_SUSPEND is expected to be used,
updating some of the text now made invalid by its addition.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/power/suspend-and-interrupts.txt | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

As promised previously, take IRQF_COND_SUSPEND into account in the
documentation.

Rafael, does this look OK to you?

Thanks,
Mark.

diff --git a/Documentation/power/suspend-and-interrupts.txt b/Documentation/power/suspend-and-interrupts.txt
index 50493c9..8afb29a 100644
--- a/Documentation/power/suspend-and-interrupts.txt
+++ b/Documentation/power/suspend-and-interrupts.txt
@@ -112,8 +112,9 @@ any special interrupt handling logic for it to work.
 IRQF_NO_SUSPEND and enable_irq_wake()
 -------------------------------------
 
-There are no valid reasons to use both enable_irq_wake() and the IRQF_NO_SUSPEND
-flag on the same IRQ.
+There are very few valid reasons to use both enable_irq_wake() and the
+IRQF_NO_SUSPEND flag on the same IRQ, and it is never valid to use both for the
+same device.
 
 First of all, if the IRQ is not shared, the rules for handling IRQF_NO_SUSPEND
 interrupts (interrupt handlers are invoked after suspend_device_irqs()) are
@@ -122,4 +123,13 @@ handlers are not invoked after suspend_device_irqs()).
 
 Second, both enable_irq_wake() and IRQF_NO_SUSPEND apply to entire IRQs and not
 to individual interrupt handlers, so sharing an IRQ between a system wakeup
-interrupt source and an IRQF_NO_SUSPEND interrupt source does not make sense.
+interrupt source and an IRQF_NO_SUSPEND interrupt source does not generally
+make sense.
+
+In rare cases an IRQ can be shared between a wakeup device driver and an
+IRQF_NO_SUSPEND user. In order for this to be safe, the wakeup device driver
+must be able to discern spurious IRQs from genuine wakeup events (signalling
+the latter to the core with pm_system_wakeup()), must use enable_irq_wake() to
+ensure that the IRQ will function as a wakeup source, and must request the IRQ
+with IRQF_COND_SUSPEND to tell the core that it meets these requirements. If
+these requirements are not met, it is not valid to use IRQF_COND_SUSPEND.
-- 
1.9.1
