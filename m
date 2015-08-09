From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v1] x86, ACPI, irq: Fix a regression caused by
Date: Sun,  9 Aug 2015 16:58:29 +0800
Message-ID: <1439110710-26498-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Nick Meier <nmeier@microsoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
That means ACPI SCI interrupt(Interrupt : 00000009) works in
level(Trigger Mode : 3), high(Polarity : 1) mode.

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
which means it's also possible to use IRQ9 for PCI interrupt, but works
in Level, ActiveLow mode. So it conflicts with ACPI SCI interrupt source
overriddern.

So implement a quirk to correct interrupt attribute for HyperV SCI
interrupt. Nick reports the proposed patch fixes the regression as "
  Applied the above proposed patch with the DMI values substituted.
  The tulip driver loaded, and an address was assigned via DHCP.
"
Please refer to following links for more information:
https://bugzilla.kernel.org/show_bug.cgi?id=101301
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1440072

Fixes: cd68f6bd53cf ("x86, irq, acpi: Get rid of special handling of GSI for ACPI SCI")
Reported-and-tested-by: Nick Meier <nmeier@microsoft.com>
Cc: <stable@vger.kernel.org> # 3.19
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/acpi/boot.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e49ee24da85e..47d95a86d56d 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1308,6 +1308,13 @@ static int __init dmi_ignore_irq0_timer_override(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init acpi_force_hyperv_sci_attr(const struct dmi_system_id *d)
+{
+	acpi_sci_flags = ACPI_MADT_POLARITY_ACTIVE_LOW |
+		(acpi_sci_flags & ~ACPI_MADT_POLARITY_MASK);
+	return 0;
+}
+
 /*
  * ACPI offers an alternative platform interface model that removes
  * ACPI hardware requirements for platforms that do not implement
@@ -1458,6 +1465,14 @@ static struct dmi_system_id __initdata acpi_dmi_table_late[] = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "AMILO PRO V2030"),
 		     },
 	 },
+	{
+	 .callback = acpi_force_hyperv_sci_attr,
+	 .ident = "HyperV",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
+		     },
+	 },
 	{}
 };
 
-- 
1.7.10.4

