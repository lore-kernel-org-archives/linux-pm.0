From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3.18 18/46] x86/acpi: Handle SCI interrupts above legacy space gracefully
Date: Mon, 15 Jan 2018 13:33:26 +0100
Message-ID: <20180115123329.460468634@linuxfoundation.org>
References: <20180115123327.303455538@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180115123327.303455538@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Vikas C Sajjan <vikas.cha.sajjan@hpe.com>, Sunil V L <sunil.vl@hpe.com>, Thomas Gleixner <tglx@linutronix.de>, Abdul Lateef Attar <abdul-lateef.attar@hpe.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, kkamagui@gmail.com, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>

commit 252714155f04c5d16989cb3aadb85fd1b5772f99 upstream.

Platforms which support only IOAPIC mode, pass the SCI information above
the legacy space (0-15) via the FADT mechanism and not via MADT.

In such cases mp_override_legacy_irq() which is invoked from
acpi_sci_ioapic_setup() to register SCI interrupts fails for interrupts
greater equal 16, since it is meant to handle only the legacy space and
emits error "Invalid bus_irq %u for legacy override".

Add a new function to handle SCI interrupts >= 16 and invoke it
conditionally in acpi_sci_ioapic_setup().

The code duplication due to this new function will be cleaned up in a
separate patch.

Co-developed-by: Sunil V L <sunil.vl@hpe.com>
Signed-off-by: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
Signed-off-by: Sunil V L <sunil.vl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Abdul Lateef Attar <abdul-lateef.attar@hpe.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: kkamagui@gmail.com
Cc: linux-acpi@vger.kernel.org
Link: https://lkml.kernel.org/r/1510848825-21965-2-git-send-email-vikas.cha.sajjan@hpe.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/acpi/boot.c |   33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -445,6 +445,34 @@ static struct irq_domain_ops acpi_irqdom
 	.unmap = mp_irqdomain_unmap,
 };
 
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
@@ -489,7 +517,10 @@ static void __init acpi_sci_ioapic_setup
 	if (acpi_sci_flags & ACPI_MADT_POLARITY_MASK)
 		polarity = acpi_sci_flags & ACPI_MADT_POLARITY_MASK;
 
-	mp_override_legacy_irq(bus_irq, polarity, trigger, gsi);
+	if (bus_irq < NR_IRQS_LEGACY)
+		mp_override_legacy_irq(bus_irq, polarity, trigger, gsi);
+	else
+		mp_register_ioapic_irq(bus_irq, polarity, trigger, gsi);
 
 	/*
 	 * stash over-ride to indicate we've been here
