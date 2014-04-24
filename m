From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 08/10] ARM: mvebu: Add thermal quirk for the Armada 375 DB board
Date: Thu, 24 Apr 2014 17:23:22 -0300
Message-ID: <1398371004-15807-9-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40828 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753092AbaDXUYi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Apr 2014 16:24:38 -0400
In-Reply-To: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, devicetree@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The initial release of the Armada 375 DB board has an Armada 375
Z1 stepping silicon. This commit introduces a quirk that allows
to workaround a series of issues with the thermal sensor in this
stepping, but updating the devicetree:

  * Updates the compatible string for the thermal, so the driver
    can perform a specific initialization of the sensor.

  * Moves the offset of the thermal control register. This quirk
    allows to specifiy the correct (A0 stepping) offset in the
    devicetree.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c     | 57 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/mvebu-soc-id.h |  3 ++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 333fca8..93f50f2 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -96,10 +96,66 @@ static void __init i2c_quirk(void)
 	return;
 }
 
+#define A375_Z1_THERMAL_FIXUP_OFFSET 0xc
+
+static void __init thermal_quirk(void)
+{
+	struct device_node *np;
+	u32 dev, rev;
+
+	if (mvebu_get_soc_id(&dev, &rev) && rev > ARMADA_375_Z1_REV)
+		return;
+
+	for_each_compatible_node(np, NULL, "marvell,armada375-thermal") {
+		struct property *prop;
+		__be32 newval, *newprop, *oldprop;
+		int len;
+
+		/*
+		 * The register offset is at a wrong location. This quirk
+		 * creates a new reg property as a clone of the previous
+		 * one and corrects the offset.
+		 */
+		oldprop = (__be32 *)of_get_property(np, "reg", &len);
+		if (!oldprop)
+			continue;
+
+		/* Create a duplicate of the 'reg' property */
+		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+		prop->length = len;
+		prop->name = kstrdup("reg", GFP_KERNEL);
+		prop->value = kzalloc(len, GFP_KERNEL);
+		memcpy(prop->value, oldprop, len);
+
+		/* Fixup the register offset of the second entry */
+		oldprop += 2;
+		newprop = (__be32 *)prop->value + 2;
+		newval = cpu_to_be32(be32_to_cpu(*oldprop) -
+				     A375_Z1_THERMAL_FIXUP_OFFSET);
+		*newprop = newval;
+		of_update_property(np, prop);
+
+		/*
+		 * The thermal controller needs some quirk too, so let's change
+		 * the compatible string to reflect this.
+		 */
+		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+		prop->name = kstrdup("compatible", GFP_KERNEL);
+		prop->length = sizeof("marvell,armada375-z1-thermal");
+		prop->value = kstrdup("marvell,armada375-z1-thermal",
+						GFP_KERNEL);
+		of_update_property(np, prop);
+	}
+	return;
+}
+
 static void __init mvebu_dt_init(void)
 {
 	if (of_machine_is_compatible("plathome,openblocks-ax3-4"))
 		i2c_quirk();
+	if (of_machine_is_compatible("marvell,a375-db"))
+		thermal_quirk();
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
@@ -123,6 +179,7 @@ static const char * const armada_375_dt_compat[] = {
 
 DT_MACHINE_START(ARMADA_375_DT, "Marvell Armada 375 (Device Tree)")
 	.init_time	= mvebu_timer_and_clk_init,
+	.init_machine	= mvebu_dt_init,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_375_dt_compat,
 MACHINE_END
diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.h b/arch/arm/mach-mvebu/mvebu-soc-id.h
index 3165425..294a443 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.h
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.h
@@ -20,6 +20,9 @@
 #define MV78XX0_A0_REV	    0x1
 #define MV78XX0_B0_REV	    0x2
 
+/* Armada 375 */
+#define ARMADA_375_Z1_REV   0x0
+
 #ifdef CONFIG_ARCH_MVEBU
 int mvebu_get_soc_id(u32 *dev, u32 *rev);
 #else
-- 
1.9.1

