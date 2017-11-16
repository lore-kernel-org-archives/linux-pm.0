From: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
Subject: [PATCH v2 2/2] acpi/x86: Reuse the mp_register_ioapic_irq() in the function mp_override_legacy_irq()
Date: Thu, 16 Nov 2017 14:59:55 +0530
Message-ID: <1510824595-12287-3-git-send-email-vikas.cha.sajjan@hpe.com>
References: <1510824595-12287-1-git-send-email-vikas.cha.sajjan@hpe.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:33616 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759363AbdKPJ4W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2017 04:56:22 -0500
In-Reply-To: <1510824595-12287-1-git-send-email-vikas.cha.sajjan@hpe.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, rjw@rjwysocki.net, rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kkamagui@gmail.com, mingo@kernel.org, Vikas C Sajjan <vikas.cha.sajjan@hpe.com>

Modify the function mp_override_legacy_irq() to reuse the newly introduced
function mp_register_ioapic_irq().

Signed-off-by: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
---
 arch/x86/kernel/acpi/boot.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 40c24d1b..6aae067 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -342,13 +342,12 @@ static int acpi_register_lapic(int id, u32 acpiid, u8 enabled)
 #ifdef CONFIG_X86_IO_APIC
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
@@ -358,14 +357,6 @@ static void __init mp_override_legacy_irq(u8 bus_irq, u8 polarity, u8 trigger,
 	}
 
 	/*
-	 * Convert 'gsi' to 'ioapic.pin'.
-	 */
-	ioapic = mp_find_ioapic(gsi);
-	if (ioapic < 0)
-		return;
-	pin = mp_find_ioapic_pin(ioapic, gsi);
-
-	/*
 	 * TBD: This check is for faulty timer entries, where the override
 	 *      erroneously sets the trigger to level, resulting in a HUGE
 	 *      increase of timer interrupts!
@@ -373,16 +364,8 @@ static void __init mp_override_legacy_irq(u8 bus_irq, u8 polarity, u8 trigger,
 	if ((bus_irq == 0) && (trigger == 3))
 		trigger = 1;
 
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
+	if (mp_register_ioapic_irq(bus_irq, polarity, trigger, gsi) < 0)
+		return;
 	/*
 	 * Reset default identity mapping if gsi is also an legacy IRQ,
 	 * otherwise there will be more than one entry with the same GSI
-- 
1.9.1
