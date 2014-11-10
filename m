From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 12/48] mfd: ab8500-sysctrl: Register with kernel power-off
 handler
Date: Sun,  9 Nov 2014 17:42:29 -0800
Message-ID: <1415583785-6980-13-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
only sets pm_power_off if it was not already set.

sysctrl_dev is set prior to power-off handler registration, and the
power-off handler is unregistered prior to clearing sysrctrl_dev.
It is therefore not necessary to check if sysctrl_dev is NULL in the
power-off handler, and the check was removed. Setting sysctrl_dev to NULL
in the remove function was also removed as unnecessary. With those changes,
devm_register_power_off_handler can be used to register the poeroff handler.
The now empty remove function was retained since the ab8500_restart function,
which is currently unused, would likely need some cleanup if it was ever used.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v6:
- Moved ab8500_power_off_hb to avoid conflict in -next.
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
- Use devm_register_power_off_handler
- Use dev_warn instead of dev_err
- Since we use devm_register_power_off_handler,
  we need to check if sysctrl_dev in the poweroff handler to avoid
  a race condition on unload, so this check is no longer removed

 drivers/mfd/ab8500-sysctrl.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 8e0dae5..064821e 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -23,7 +23,7 @@
 
 static struct device *sysctrl_dev;
 
-static void ab8500_power_off(void)
+static void ab8500_power_off(struct power_off_handler_block *this)
 {
 	sigset_t old;
 	sigset_t all;
@@ -180,11 +180,17 @@ int ab8500_sysctrl_write(u16 reg, u8 mask, u8 value)
 }
 EXPORT_SYMBOL(ab8500_sysctrl_write);
 
+static struct power_off_handler_block ab8500_power_off_hb = {
+	.handler = ab8500_power_off,
+	.priority = POWER_OFF_PRIORITY_LOW,
+};
+
 static int ab8500_sysctrl_probe(struct platform_device *pdev)
 {
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
 	struct ab8500_platform_data *plat;
 	struct ab8500_sysctrl_platform_data *pdata;
+	int err;
 
 	plat = dev_get_platdata(pdev->dev.parent);
 
@@ -193,8 +199,10 @@ static int ab8500_sysctrl_probe(struct platform_device *pdev)
 
 	sysctrl_dev = &pdev->dev;
 
-	if (!pm_power_off)
-		pm_power_off = ab8500_power_off;
+	err = devm_register_power_off_handler(sysctrl_dev,
+					      &ab8500_power_off_hb);
+	if (err)
+		dev_warn(&pdev->dev, "Failed to register power-off handler\n");
 
 	pdata = plat->sysctrl;
 	if (pdata) {
@@ -228,9 +236,6 @@ static int ab8500_sysctrl_remove(struct platform_device *pdev)
 {
 	sysctrl_dev = NULL;
 
-	if (pm_power_off == ab8500_power_off)
-		pm_power_off = NULL;
-
 	return 0;
 }
 
-- 
1.9.1
