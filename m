From: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
Subject: [PATCH v3 1/2] acpi/x86: Fix improper handling of SCI INT for platforms supporting only IOAPIC mode
Date: Thu, 16 Nov 2017 21:43:44 +0530
Message-ID: <1510848825-21965-2-git-send-email-vikas.cha.sajjan@hpe.com>
References: <1510848825-21965-1-git-send-email-vikas.cha.sajjan@hpe.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:38756 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935904AbdKPQkC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2017 11:40:02 -0500
In-Reply-To: <1510848825-21965-1-git-send-email-vikas.cha.sajjan@hpe.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kkamagui@gmail.com, mingo@kernel.org, Vikas C Sajjan <vikas.cha.sajjan@hpe.com>

The platforms which support only IOAPIC mode, pass the SCI information
above the legacy space (0-15) via the FADT mechanism and not via MADT.
In such cases the mp_override_legacy_irq() used by acpi_sci_ioapic_setup()
to register SCI interrupts fails for interrupts >= 16, since it is meant to
handle only legacy space and throws error "Invalid bus_irq %u for legacy
override". Hence add a new function to handle SCI interrupts >= 16 and
invoke it conditionally in acpi_sci_ioapic_setup().The code duplication
due to this new function will be cleaned up in a separate patch.

Co-developed-by: Sunil V L <sunil.vl@hpe.com>
Signed-off-by: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
Tested-by: Abdul Lateef Attar <abdul-lateef.attar@hpe.com>
---
 arch/x86/kernel/acpi/boot.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index ef9e02e..7615379 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -429,6 +429,34 @@ static int mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
 	return 0;
 }
 
+static int __init mp_register_ioapic_irq(u8 bus_irq, u8 polarity,
+						u8 trigger, u32 gsi)
+{
+	struct mpc_intsrc mp_irq;
+	int ioapic, pin;
+
+	/* Convert 'gsi' to 'ioapic.pin'(INTIN#) */
+	ioapic = mp_find_ioapic(gsi);
+	if (ioapic < 0) {
+		pr_warn("Failed to find ioapic for gsi : %u\n", gsi);
+		return ioapic;
+	}
+
+	pin = mp_find_ioapic_pin(ioapic, gsi);
+
+	mp_irq.type = MP_INTSRC;
+	mp_irq.irqtype = mp_INT;
+	mp_irq.irqflag = (trigger << 2) | polarity;
+	mp_irq.srcbus = MP_ISA_BUS;
+	mp_irq.srcbusirq = bus_irq;
+	mp_irq.dstapic = mpc_ioapic_id(ioapic);
+	mp_irq.dstirq = pin;
+
+	mp_save_irq(&mp_irq);
+
+	return 0;
+}
+
 static int __init
 acpi_parse_ioapic(struct acpi_subtable_header * header, const unsigned long end)
 {
@@ -473,7 +501,11 @@ static void __init acpi_sci_ioapic_setup(u8 bus_irq, u16 polarity, u16 trigger,
 	if (acpi_sci_flags & ACPI_MADT_POLARITY_MASK)
 		polarity = acpi_sci_flags & ACPI_MADT_POLARITY_MASK;
 
-	mp_override_legacy_irq(bus_irq, polarity, trigger, gsi);
+	if (bus_irq < NR_IRQS_LEGACY)
+		mp_override_legacy_irq(bus_irq, polarity, trigger, gsi);
+	else
+		mp_register_ioapic_irq(bus_irq, polarity, trigger, gsi);
+
 	acpi_penalize_sci_irq(bus_irq, trigger, polarity);
 
 	/*
-- 
1.9.1
