From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 46/48] x86: pmc_atom: Register power-off handler with kernel power-off handler
Date: Thu,  6 Nov 2014 08:43:30 -0800
Message-ID: <1415292213-28652-47-git-send-email-linux@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-pm@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
only sets pm_power_off if it was not already set.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v5:
- Rebase to v3.18-rc3
v4:
- No change
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority
- Use dev_warn instead of dev_err

 arch/x86/kernel/pmc_atom.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/pmc_atom.c b/arch/x86/kernel/pmc_atom.c
index 0ee5025e..acb4e78 100644
--- a/arch/x86/kernel/pmc_atom.c
+++ b/arch/x86/kernel/pmc_atom.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/debugfs.h>
+#include <linux/pm.h>
 #include <linux/seq_file.h>
 #include <linux/io.h>
 
@@ -92,7 +93,7 @@ static inline void pmc_reg_write(struct pmc_dev *pmc, int reg_offset, u32 val)
 	writel(val, pmc->regmap + reg_offset);
 }
 
-static void pmc_power_off(void)
+static void pmc_power_off(struct power_off_handler_block *this)
 {
 	u16	pm1_cnt_port;
 	u32	pm1_cnt_value;
@@ -109,6 +110,11 @@ static void pmc_power_off(void)
 	outl(pm1_cnt_value, pm1_cnt_port);
 }
 
+static struct power_off_handler_block pmc_power_off_hb = {
+	.handler = pmc_power_off,
+	.priority = POWER_OFF_PRIORITY_LOW,
+};
+
 static void pmc_hw_reg_setup(struct pmc_dev *pmc)
 {
 	/*
@@ -252,8 +258,12 @@ static int pmc_setup_dev(struct pci_dev *pdev)
 	acpi_base_addr &= ACPI_BASE_ADDR_MASK;
 
 	/* Install power off function */
-	if (acpi_base_addr != 0 && pm_power_off == NULL)
-		pm_power_off = pmc_power_off;
+	if (acpi_base_addr != 0) {
+		ret = register_power_off_handler(&pmc_power_off_hb);
+		if (ret)
+			dev_warn(&pdev->dev,
+				 "Failed to install power-off handler\n");
+	}
 
 	pci_read_config_dword(pdev, PMC_BASE_ADDR_OFFSET, &pmc->base_addr);
 	pmc->base_addr &= PMC_BASE_ADDR_MASK;
-- 
1.9.1
