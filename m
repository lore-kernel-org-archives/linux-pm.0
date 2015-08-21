From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v2]
Date: Fri, 21 Aug 2015 15:26:32 +0800
Message-ID: <1440141992-21945-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Nick Meier <nmeier@microsoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Nick,
	Rafael and Thomas have concerns about the way to solve the
regression by quirk, so could you please help to test this patch?
Thanks!
Gerry

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
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

