From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [PATCH] x86/ACPI: Fix regression caused by 16ee7b3dcc56
Date: Tue,  7 Apr 2015 22:34:03 +0800
Message-ID: <1428417244-32416-1-git-send-email-jiang.liu@linux.intel.com>
References: <55214A0D.9000404@xs4all.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55214A0D.9000404@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: jim876@xs4all.nl, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Jim,
	Could you please help to test this patch against v4.0-rc6?
Thanks!
Gerry

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/acpi/boot.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 803b684676ff..f7f1fe7cd1b0 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -403,10 +403,14 @@ static int mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
 static int mp_register_gsi(struct device *dev, u32 gsi, int trigger,
 			   int polarity)
 {
-	int irq, node;
+	int i, irq, node;
 
-	if (acpi_irq_model != ACPI_IRQ_MODEL_IOAPIC)
-		return gsi;
+	if (acpi_irq_model != ACPI_IRQ_MODEL_IOAPIC) {
+		for (i = 0; i < nr_legacy_irqs(); i++)
+			if (isa_irq_to_gsi[i] == gsi)
+				return i;
+		return -1;
+	}
 
 	trigger = trigger == ACPI_EDGE_SENSITIVE ? 0 : 1;
 	polarity = polarity == ACPI_ACTIVE_HIGH ? 0 : 1;
-- 
1.7.10.4
