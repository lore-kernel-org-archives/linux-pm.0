From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 4/6] drivers: firmware: psci: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts power
Date: Mon, 20 Feb 2017 21:33:27 +0100
Message-ID: <1487622809-25127-5-git-send-email-geert+renesas@glider.be>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Nothing in the PSCI specification requires the SoC to remain powered and
to support wake-up sources when suspended using SYSTEM_SUSPEND.
If the firmware implements the PSCI SYSTEM_SUSPEND operation by cutting
power to the SoC, the only possibly wake-up sources are thus the ones
connected to the PMIC.

Document and add support for an "arm,psci-system-suspend-is-power-down"
DT property, so Linux uses a different suspend method when other wake-up
sources (e.g. wake on LAN, UART or GPIO) are enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/psci.txt | 11 +++++++++++
 drivers/firmware/psci.c                        | 13 ++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index a2c4f1d524929bb7..16e390ecb7531028 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -68,6 +68,17 @@ state nodes, as per bindings in [1]) must specify the following properties:
 		Definition: power_state parameter to pass to the PSCI
 			    suspend call.
 
+ - arm,psci-system-suspend-is-power-down
+		Nothing in the PSCI specification requires the SoC to remain
+		powered and to support wake-up sources when suspended using
+		SYSTEM_SUSPEND.
+		If your firmware implements the PSCI SYSTEM_SUSPEND operation
+		by cutting power to the SoC, the only possibly wake-up sources
+		are thus the ones connected to the PMIC.  In such case you
+		should specify this property, so the operating system is aware
+		it should use a different suspend method when other wake-up
+		sources (e.g. wake on LAN, UART or GPIO) are enabled.
+
 Example:
 
 Case 1: PSCI v0.1 only.
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 13b4d50bb3577384..0a74c23fd5fe043e 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -20,6 +20,7 @@
 #include <linux/linkage.h>
 #include <linux/of.h>
 #include <linux/pm.h>
+#include <linux/pm_wakeup.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
@@ -86,6 +87,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
 
 static u32 psci_cpu_suspend_feature;
 static bool psci_suspend_mem_supported;
+static bool psci_system_suspend_is_power_down;
 
 static inline bool psci_has_ext_power_state(void)
 {
@@ -440,12 +442,14 @@ static int psci_system_suspend_valid(suspend_state_t state)
 static int psci_system_suspend_enter(suspend_state_t state)
 {
 	switch (state) {
+	case PM_SUSPEND_MEM:
+		if (!psci_system_suspend_is_power_down ||
+		    !wakeup_source_available())
+			return cpu_suspend(0, psci_system_suspend);
+		/* fall through */
 	case PM_SUSPEND_STANDBY:
 		cpu_do_idle();
 		break;
-
-	case PM_SUSPEND_MEM:
-		return cpu_suspend(0, psci_system_suspend);
 	}
 
 	return 0;
@@ -596,6 +600,9 @@ static int __init psci_0_2_init(struct device_node *np)
 	 */
 	err = psci_probe();
 
+	psci_system_suspend_is_power_down = of_property_read_bool(np,
+		"arm,psci-system-suspend-is-power-down");
+
 out_put_node:
 	of_node_put(np);
 	return err;
-- 
2.7.4
