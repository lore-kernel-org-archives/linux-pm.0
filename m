From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v3] ACPI, PCI: Penalize legacy IRQ used by ACPI SCI
Date: Fri, 21 Aug 2015 15:36:23 +0800
Message-ID: <1440142584-22404-1-git-send-email-jiang.liu@linux.intel.com>
References: <alpine.DEB.2.11.1508201247370.3873@nanos>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18900 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840AbbHUHdK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 21 Aug 2015 03:33:10 -0400
In-Reply-To: <alpine.DEB.2.11.1508201247370.3873@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Nick Meier <nmeier@microsoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Nick Meier reported a regression with HyperV that "
  After rebooting the VM, the following messages are logged in syslog
  when trying to load the tulip driver:
    tulip: Linux Tulip drivers version 1.1.15 (Feb 27, 2007)
    tulip: 0000:00:0a.0: PCI INT A: failed to register GSI
    tulip: Cannot enable tulip board #0, aborting
    tulip: probe of 0000:00:0a.0 failed with error -16
  Errors occur in 3.19.0 kernel
  Works in 3.17 kernel.
"

According to the ACPI dump file posted by Nick at
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1440072

The ACPI MADT table includes an interrupt source overridden entry for
ACPI SCI:
[236h 0566  1]                Subtable Type : 02 <Interrupt Source Override>
[237h 0567  1]                       Length : 0A
[238h 0568  1]                          Bus : 00
[239h 0569  1]                       Source : 09
[23Ah 0570  4]                    Interrupt : 00000009
[23Eh 0574  2]        Flags (decoded below) : 000D
                                   Polarity : 1
                               Trigger Mode : 3

And in DSDT table, we have _PRT method to define PCI interrupts, which
eventually goes to:
        Name (PRSA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {3,4,5,7,9,10,11,12,14,15}
        })
        Name (PRSB, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {3,4,5,7,9,10,11,12,14,15}
        })
        Name (PRSC, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {3,4,5,7,9,10,11,12,14,15}
        })
        Name (PRSD, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {3,4,5,7,9,10,11,12,14,15}
        })

According to the MADT and DSDT tables, IRQ 9 may be used for:
1) ACPI SCI in level, high mode
2) PCI legacy IRQ in level, low mode
So there's a conflict in polarity setting for IRQ 9.

Prior to commit cd68f6bd53cf ("x86, irq, acpi: Get rid of special
handling of GSI for ACPI SCI"), ACPI SCI is handled specially and
there's no check for conflicts between ACPI SCI and PCI legagy IRQ.
And it seems that the HyperV hypervisor doesn't make use of the
polarity configuration in IOAPIC entry, so it just works.

Commit cd68f6bd53cf gets rid of the specially handling of ACPI SCI,
and then the pin attribute checking code discloses the conflicts
between ACPI SCI and PCI legacy IRQ on HyperV virtual machine,
and rejects the request to assign IRQ9 to PCI devices.

So penalize legacy IRQ used by ACPI SCI and mark it unusable if ACPI
SCI attributes conflict with PCI IRQ attributes.

Please refer to following links for more information:
https://bugzilla.kernel.org/show_bug.cgi?id=101301
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1440072

Fixes: cd68f6bd53cf ("x86, irq, acpi: Get rid of special handling of GSI for ACPI SCI")
Reported-and-tested-by: Nick Meier <nmeier@microsoft.com>
Cc: <stable@vger.kernel.org> # 3.19
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
Hi Nick,
	Rafael and Thomas have concerns about the way to solve the
regression by quirk, so could you please help to test this patch?
Thanks!
Gerry

---
 arch/x86/kernel/acpi/boot.c |    1 +
 drivers/acpi/pci_link.c     |   16 ++++++++++++++++
 include/linux/acpi.h        |    2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e49ee24da85e..9393896717d0 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -445,6 +445,7 @@ static void __init acpi_sci_ioapic_setup(u8 bus_irq, u16 polarity, u16 trigger,
 		polarity = acpi_sci_flags & ACPI_MADT_POLARITY_MASK;
 
 	mp_override_legacy_irq(bus_irq, polarity, trigger, gsi);
+	acpi_penalize_sci_irq(bus_irq, trigger, polarity);
 
 	/*
 	 * stash over-ride to indicate we've been here
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index cfd7581cc19f..b09ad554430a 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -826,6 +826,22 @@ void acpi_penalize_isa_irq(int irq, int active)
 }
 
 /*
+ * Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict with
+ * PCI IRQ attributes, mark ACPI SCI as ISA_ALWAYS so it won't be use for
+ * PCI IRQs.
+ */
+void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
+{
+	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
+		if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
+		    polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
+			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
+		else
+			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
+	}
+}
+
+/*
  * Over-ride default table to reserve additional IRQs for use by ISA
  * e.g. acpi_irq_isa=5
  * Useful for telling ACPI how not to interfere with your ISA sound card.
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d2445fa9999f..0b2394f61af4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -221,7 +221,7 @@ struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
-
+void acpi_penalize_sci_irq(int irq, int trigger, int polarity);
 void acpi_pci_irq_disable (struct pci_dev *dev);
 
 extern int ec_read(u8 addr, u8 *val);
-- 
1.7.10.4

