From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 3/3] ARM: at91: pm: add support for .off_in_suspend
Date: Tue, 8 Jan 2019 10:56:35 +0000
Message-ID: <1546944944-13911-4-git-send-email-claudiu.beznea@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support to check if platform is off in suspend. The check is based on
pm_data.mode and CPU's regulator which will be turn off in suspend.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 61 +++++++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 51e808adb00c..be9bd482772b 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/parser.h>
+#include <linux/regulator/consumer.h>
 #include <linux/suspend.h>
=20
 #include <linux/clk/at91_pmc.h>
@@ -164,6 +165,47 @@ static int at91_pm_config_ws(unsigned int pm_mode, boo=
l set)
 	return mode ? 0 : -EPERM;
 }
=20
+static const struct of_device_id sama5d2_cpu_reg_ids[] =3D {
+	{ .compatible =3D "active-semi,act8945a",		.data =3D "VDD_1V2" },
+	{ /* sentinel */ }
+};
+
+static struct regulator *at91_pm_cpu_regulator_get(void)
+{
+	struct device *cpu_dev =3D get_cpu_device(0);
+	static struct regulator *cpu_reg;
+	const struct of_device_id *match;
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	if (!cpu_dev)
+		return cpu_reg;
+
+	if (!cpu_reg) {
+		for_each_matching_node_and_match(np, sama5d2_cpu_reg_ids,
+						 &match) {
+			pdev =3D of_find_device_by_node(np);
+			if (!pdev)
+				continue;
+
+			cpu_reg =3D regulator_get(cpu_dev, match->data);
+			put_device(&pdev->dev);
+			break;
+		}
+	}
+
+	return cpu_reg;
+}
+
+static bool at91_pm_state_allowed(suspend_state_t state)
+{
+	struct regulator *reg;
+
+	reg =3D at91_pm_cpu_regulator_get();
+
+	return reg && regulator_is_disabled_in_suspend(reg, state);
+}
+
 /*
  * Called after processes are frozen, but before we shutdown devices.
  */
@@ -182,6 +224,9 @@ static int at91_pm_begin(suspend_state_t state)
 		pm_data.mode =3D -1;
 	}
=20
+	if (pm_data.mode =3D=3D AT91_PM_BACKUP && !at91_pm_state_allowed(state))
+		return -EPERM;
+
 	return at91_pm_config_ws(pm_data.mode, true);
 }
=20
@@ -321,12 +366,20 @@ static void at91_pm_end(void)
 	at91_pm_config_ws(pm_data.mode, false);
 }
=20
+static bool at91_pm_off_in_suspend(suspend_state_t state)
+{
+	if (pm_data.mode !=3D AT91_PM_BACKUP)
+		return false;
+
+	return at91_pm_state_allowed(state);
+}
=20
 static const struct platform_suspend_ops at91_pm_ops =3D {
-	.valid	=3D at91_pm_valid_state,
-	.begin	=3D at91_pm_begin,
-	.enter	=3D at91_pm_enter,
-	.end	=3D at91_pm_end,
+	.valid		=3D at91_pm_valid_state,
+	.begin		=3D at91_pm_begin,
+	.enter		=3D at91_pm_enter,
+	.end		=3D at91_pm_end,
+	.off_in_suspend	=3D at91_pm_off_in_suspend,
 };
=20
 static struct platform_device at91_cpuidle_device =3D {
--=20
2.7.4
