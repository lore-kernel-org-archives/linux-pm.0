From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 45/47] x86: pmc_atom: Register power-off handler with kernel power-off handler
Date: Mon, 27 Oct 2014 08:55:52 -0700
Message-ID: <1414425354-10359-46-git-send-email-linux@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50338 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbaJ0P5w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Oct 2014 11:57:52 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Ximg3-000deT-Px
	for linux-pm@vger.kernel.org; Mon, 27 Oct 2014 15:57:51 +0000
In-Reply-To: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
only sets pm_power_off if it was not already set.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority
- Use dev_warn instead of dev_err

 arch/x86/kernel/pmc_atom.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/pmc_atom.c b/arch/x86/kernel/pmc_atom.c
index 0ee5025e..973cd5b 100644
--- a/arch/x86/kernel/pmc_atom.c
+++ b/arch/x86/kernel/pmc_atom.c
@@ -20,6 +20,8 @@
 #include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/debugfs.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/seq_file.h>
 #include <linux/io.h>
 
@@ -92,7 +94,8 @@ static inline void pmc_reg_write(struct pmc_dev *pmc, int reg_offset, u32 val)
 	writel(val, pmc->regmap + reg_offset);
 }
 
-static void pmc_power_off(void)
+static int pmc_power_off(struct notifier_block *this, unsigned long unused1,
+			 void *unused2)
 {
 	u16	pm1_cnt_port;
 	u32	pm1_cnt_value;
@@ -107,8 +110,15 @@ static void pmc_power_off(void)
 	pm1_cnt_value |= SLEEP_ENABLE;
 
 	outl(pm1_cnt_value, pm1_cnt_port);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block pmc_power_off_nb = {
+	.notifier_call = pmc_power_off,
+	.priority = POWER_OFF_PRIORITY_LOW,
+};
+
 static void pmc_hw_reg_setup(struct pmc_dev *pmc)
 {
 	/*
@@ -252,8 +262,12 @@ static int pmc_setup_dev(struct pci_dev *pdev)
 	acpi_base_addr &= ACPI_BASE_ADDR_MASK;
 
 	/* Install power off function */
-	if (acpi_base_addr != 0 && pm_power_off == NULL)
-		pm_power_off = pmc_power_off;
+	if (acpi_base_addr != 0) {
+		ret = register_power_off_handler(&pmc_power_off_nb);
+		if (ret)
+			dev_warn(&pdev->dev,
+				 "Failed to install power-off handler\n");
+	}
 
 	pci_read_config_dword(pdev, PMC_BASE_ADDR_OFFSET, &pmc->base_addr);
 	pmc->base_addr &= PMC_BASE_ADDR_MASK;
-- 
1.9.1

