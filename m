From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 2/2] ARM: mvebu: Remove thermal quirk for A375 Z1 revision
Date: Tue,  4 Nov 2014 13:00:39 -0300
Message-ID: <1415116839-4323-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35984 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754658AbaKDQCb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Nov 2014 11:02:31 -0500
In-Reply-To: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The Armada 375 Z1 SoC revision is no longer supported. This commit
removes the quirk required to "fix" the reg property and the compatible
string of the thermal devicetree node.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 66 +-----------------------------------------
 1 file changed, 1 insertion(+), 65 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 6478626..461e726 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -124,76 +124,12 @@ static void __init i2c_quirk(void)
 	return;
 }
 
-#define A375_Z1_THERMAL_FIXUP_OFFSET 0xc
-
-static void __init thermal_quirk(void)
-{
-	struct device_node *np;
-	u32 dev, rev;
-	int res;
-
-	/*
-	 * The early SoC Z1 revision needs a quirk to be applied in order
-	 * for the thermal controller to work properly. This quirk breaks
-	 * the thermal support if applied on a SoC that doesn't need it,
-	 * so we enforce the SoC revision to be known.
-	 */
-	res = mvebu_get_soc_id(&dev, &rev);
-	if (res < 0 || (res == 0 && rev > ARMADA_375_Z1_REV))
-		return;
-
-	for_each_compatible_node(np, NULL, "marvell,armada375-thermal") {
-		struct property *prop;
-		__be32 newval, *newprop, *oldprop;
-		int len;
-
-		/*
-		 * The register offset is at a wrong location. This quirk
-		 * creates a new reg property as a clone of the previous
-		 * one and corrects the offset.
-		 */
-		oldprop = (__be32 *)of_get_property(np, "reg", &len);
-		if (!oldprop)
-			continue;
-
-		/* Create a duplicate of the 'reg' property */
-		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
-		prop->length = len;
-		prop->name = kstrdup("reg", GFP_KERNEL);
-		prop->value = kzalloc(len, GFP_KERNEL);
-		memcpy(prop->value, oldprop, len);
-
-		/* Fixup the register offset of the second entry */
-		oldprop += 2;
-		newprop = (__be32 *)prop->value + 2;
-		newval = cpu_to_be32(be32_to_cpu(*oldprop) -
-				     A375_Z1_THERMAL_FIXUP_OFFSET);
-		*newprop = newval;
-		of_update_property(np, prop);
-
-		/*
-		 * The thermal controller needs some quirk too, so let's change
-		 * the compatible string to reflect this and allow the driver
-		 * the take the necessary action.
-		 */
-		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
-		prop->name = kstrdup("compatible", GFP_KERNEL);
-		prop->length = sizeof("marvell,armada375-z1-thermal");
-		prop->value = kstrdup("marvell,armada375-z1-thermal",
-						GFP_KERNEL);
-		of_update_property(np, prop);
-	}
-	return;
-}
-
 static void __init mvebu_dt_init(void)
 {
 	if (of_machine_is_compatible("plathome,openblocks-ax3-4"))
 		i2c_quirk();
-	if (of_machine_is_compatible("marvell,a375-db")) {
+	if (of_machine_is_compatible("marvell,a375-db"))
 		external_abort_quirk();
-		thermal_quirk();
-	}
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
-- 
2.1.0

