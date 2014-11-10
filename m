From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 32/48] x86: olpc: Register xo1 power-off handler with kernel power-off handler
Date: Sun,  9 Nov 2014 17:42:49 -0800
Message-ID: <1415583785-6980-33-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-pm@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with high priority to reflect that the driver
explicitly wants to override default power-off handlers.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v6:
- This patch: No change.
  Global: Replaced priority defines with enum.
v5:
- Rebase to v3.18-rc3
v4:
- Do not use notifiers but internal functions and data structures to manage
  the list of power-off handlers. Drop unused parameters from callbacks, and
  make the power-off function type void
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority

 arch/x86/platform/olpc/olpc-xo1-pm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-pm.c b/arch/x86/platform/olpc/olpc-xo1-pm.c
index a9acde7..7a4878eb 100644
--- a/arch/x86/platform/olpc/olpc-xo1-pm.c
+++ b/arch/x86/platform/olpc/olpc-xo1-pm.c
@@ -92,7 +92,7 @@ asmlinkage __visible int xo1_do_sleep(u8 sleep_state)
 	return 0;
 }
 
-static void xo1_power_off(void)
+static void xo1_power_off(struct power_off_handler_block *this)
 {
 	printk(KERN_INFO "OLPC XO-1 power off sequence...\n");
 
@@ -110,6 +110,11 @@ static void xo1_power_off(void)
 	outl(0x00002000, acpi_base + CS5536_PM1_CNT);
 }
 
+static struct power_off_handler_block xo1_power_off_hb = {
+	.handler = xo1_power_off,
+	.priority = POWER_OFF_PRIORITY_HIGH,
+};
+
 static int xo1_power_state_valid(suspend_state_t pm_state)
 {
 	/* suspend-to-RAM only */
@@ -146,8 +151,12 @@ static int xo1_pm_probe(struct platform_device *pdev)
 
 	/* If we have both addresses, we can override the poweroff hook */
 	if (pms_base && acpi_base) {
+		err = register_power_off_handler(&xo1_power_off_hb);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to register power-off handler\n");
+			return err;
+		}
 		suspend_set_ops(&xo1_suspend_ops);
-		pm_power_off = xo1_power_off;
 		printk(KERN_INFO "OLPC XO-1 support registered\n");
 	}
 
@@ -158,12 +167,13 @@ static int xo1_pm_remove(struct platform_device *pdev)
 {
 	mfd_cell_disable(pdev);
 
+	unregister_power_off_handler(&xo1_power_off_hb);
+
 	if (strcmp(pdev->name, "cs5535-pms") == 0)
 		pms_base = 0;
 	else if (strcmp(pdev->name, "olpc-xo1-pm-acpi") == 0)
 		acpi_base = 0;
 
-	pm_power_off = NULL;
 	return 0;
 }
 
-- 
1.9.1
