From: "Sajjan, Vikas C" <vikas.cha.sajjan@hpe.com>
Subject: RE: [PATCH] x86/acpi: Fix improper handling of SCI INT for platforms
 supporting only IOAPIC mode
Date: Wed, 15 Nov 2017 10:05:07 +0000
Message-ID: <CS1PR8401MB0518BBCAEA7AB61840C83324D9290@CS1PR8401MB0518.NAMPRD84.PROD.OUTLOOK.COM>
References: <1510306686-18230-1-git-send-email-vikas.cha.sajjan@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:35389 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757425AbdKOKFm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 05:05:42 -0500
In-Reply-To: <1510306686-18230-1-git-send-email-vikas.cha.sajjan@hpe.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kkamagui@gmail.com" <kkamagui@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@kernel.org" <mingo@kernel.org>, "Lakshminarasimha, Sunil Vishwanathpur" <sunil.vl@hpe.com>, "Attar, Abdul Lateef" <abdul-lateef.attar@hpe.com>

Hi Rafael,

Any thoughts on this.

Regards
Vikas Sajjan

-----Original Message-----
From: Sajjan, Vikas C 
Sent: Friday, November 10, 2017 3:08 PM
To: linux-pm@vger.kernel.org; linux-acpi@vger.kernel.org; rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org; kkamagui@gmail.com; tglx@linutronix.de; mingo@kernel.org; Sajjan, Vikas C <vikas.cha.sajjan@hpe.com>; Lakshminarasimha, Sunil Vishwanathpur <sunil.vl@hpe.com>; Attar, Abdul Lateef <abdul-lateef.attar@hpe.com>
Subject: [PATCH] x86/acpi: Fix improper handling of SCI INT for platforms supporting only IOAPIC mode

The platforms which support only IOAPIC mode and whose SCI INT is greater than 16, passes SCI INT via FADT and not via MADT int src override structure. In such cases current logic fails to handle it and throws error "Invalid bus_irq %u for legacy override". This patch handles the above  mentioned case. While at it, also modify function mp_override_legacy_irq() to use the newly introduced function mp_register_ioapic_irq().

Signed-off-by: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
Signed-off-by: Sunil V L <sunil.vl@hpe.com>
Signed-off-by: Abdul Lateef Attar <abdul-lateef.attar@hpe.com>
---
 arch/x86/kernel/acpi/boot.c | 77 +++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c index 079535e..8ab97a5 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -342,13 +342,12 @@ static int acpi_register_lapic(int id, u32 acpiid, u8 enabled)  #ifdef CONFIG_X86_IO_APIC
 #define MP_ISA_BUS		0
 
+static int __init mp_register_ioapic_irq(u8 bus_irq, u8 polarity,
+						u8 trigger, u32 gsi);
+
 static void __init mp_override_legacy_irq(u8 bus_irq, u8 polarity, u8 trigger,
 					  u32 gsi)
 {
-	int ioapic;
-	int pin;
-	struct mpc_intsrc mp_irq;
-
 	/*
 	 * Check bus_irq boundary.
 	 */
@@ -357,32 +356,8 @@ static void __init mp_override_legacy_irq(u8 bus_irq, u8 polarity, u8 trigger,
 		return;
 	}
 
-	/*
-	 * Convert 'gsi' to 'ioapic.pin'.
-	 */
-	ioapic = mp_find_ioapic(gsi);
-	if (ioapic < 0)
+	if (mp_register_ioapic_irq(bus_irq, polarity, trigger, gsi) < 0)
 		return;
-	pin = mp_find_ioapic_pin(ioapic, gsi);
-
-	/*
-	 * TBD: This check is for faulty timer entries, where the override
-	 *      erroneously sets the trigger to level, resulting in a HUGE
-	 *      increase of timer interrupts!
-	 */
-	if ((bus_irq == 0) && (trigger == 3))
-		trigger = 1;
-
-	mp_irq.type = MP_INTSRC;
-	mp_irq.irqtype = mp_INT;
-	mp_irq.irqflag = (trigger << 2) | polarity;
-	mp_irq.srcbus = MP_ISA_BUS;
-	mp_irq.srcbusirq = bus_irq;	/* IRQ */
-	mp_irq.dstapic = mpc_ioapic_id(ioapic); /* APIC ID */
-	mp_irq.dstirq = pin;	/* INTIN# */
-
-	mp_save_irq(&mp_irq);
-
 	/*
 	 * Reset default identity mapping if gsi is also an legacy IRQ,
 	 * otherwise there will be more than one entry with the same GSI @@ -429,6 +404,44 @@ static int mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
 	return 0;
 }
 
+static int __init mp_register_ioapic_irq(u8 bus_irq, u8 polarity,
+						u8 trigger, u32 gsi)
+{
+	int ioapic;
+	int pin;
+	struct mpc_intsrc mp_irq;
+
+	/*
+	 * Convert 'gsi' to 'ioapic.pin'.
+	 */
+	ioapic = mp_find_ioapic(gsi);
+	if (ioapic < 0) {
+		pr_warn("Failed to find ioapic for gsi : %u\n", gsi);
+		return ioapic;
+	}
+	pin = mp_find_ioapic_pin(ioapic, gsi);
+
+	/*
+	 * TBD: This check is for faulty timer entries, where the override
+	 *      erroneously sets the trigger to level, resulting in a HUGE
+	 *      increase of timer interrupts!
+	 */
+	if ((bus_irq == 0) && (trigger == 3))
+		trigger = 1;
+
+	mp_irq.type = MP_INTSRC;
+	mp_irq.irqtype = mp_INT;
+	mp_irq.irqflag = (trigger << 2) | polarity;
+	mp_irq.srcbus = MP_ISA_BUS;
+	mp_irq.srcbusirq = bus_irq;	/* IRQ */
+	mp_irq.dstapic = mpc_ioapic_id(ioapic); /* APIC ID */
+	mp_irq.dstirq = pin;	/* INTIN# */
+
+	mp_save_irq(&mp_irq);
+
+	return 0;
+}
+
 static int __init
 acpi_parse_ioapic(struct acpi_subtable_header * header, const unsigned long end)  { @@ -473,7 +486,11 @@ static void __init acpi_sci_ioapic_setup(u8 bus_irq, u16 polarity, u16 trigger,
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
