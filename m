From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/5] x86 / PM: Set IRQCHIP_SKIP_SET_WAKE for IOAPIC IRQ chip objects
Date: Tue, 05 Aug 2014 17:27:07 +0200
Message-ID: <6349012.D6gFckYEQ1@vostro.rjw.lan>
References: <20140724212620.GO3935@laptop> <3855585.ek3PTQLkmN@vostro.rjw.lan> <3321219.itH23ZEDt4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3321219.itH23ZEDt4@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Set the IRQCHIP_SKIP_SET_WAKE for IOAPIC IRQ chip objects so that
interrupts from them can work as wakeup interrupts for suspend-to-idle.

After this change, running enable_irq_wake() on one of the IRQs in
question will succeed and IRQD_WAKEUP_STATE will be set for it, so
all of the suspend-to-idle wakeup mechanics introduced previously
will work for it automatically.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/apic/io_apic.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-pm/arch/x86/kernel/apic/io_apic.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/apic/io_apic.c
+++ linux-pm/arch/x86/kernel/apic/io_apic.c
@@ -2507,6 +2507,7 @@ static struct irq_chip ioapic_chip __rea
 	.irq_eoi		= ack_apic_level,
 	.irq_set_affinity	= native_ioapic_set_affinity,
 	.irq_retrigger		= ioapic_retrigger_irq,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 static inline void init_IO_APIC_traps(void)
@@ -3030,6 +3031,7 @@ static struct irq_chip msi_chip = {
 	.irq_ack		= ack_apic_edge,
 	.irq_set_affinity	= msi_set_affinity,
 	.irq_retrigger		= ioapic_retrigger_irq,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
@@ -3128,6 +3130,7 @@ static struct irq_chip dmar_msi_type = {
 	.irq_ack		= ack_apic_edge,
 	.irq_set_affinity	= dmar_msi_set_affinity,
 	.irq_retrigger		= ioapic_retrigger_irq,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 int arch_setup_dmar_msi(unsigned int irq)
@@ -3178,6 +3181,7 @@ static struct irq_chip hpet_msi_type = {
 	.irq_ack = ack_apic_edge,
 	.irq_set_affinity = hpet_msi_set_affinity,
 	.irq_retrigger = ioapic_retrigger_irq,
+	.flags = IRQCHIP_SKIP_SET_WAKE,
 };
 
 int default_setup_hpet_msi(unsigned int irq, unsigned int id)
@@ -3241,6 +3245,7 @@ static struct irq_chip ht_irq_chip = {
 	.irq_ack		= ack_apic_edge,
 	.irq_set_affinity	= ht_set_affinity,
 	.irq_retrigger		= ioapic_retrigger_irq,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 int arch_setup_ht_irq(unsigned int irq, struct pci_dev *dev)
