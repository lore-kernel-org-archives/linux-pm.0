From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 09/16] thermal: mvebu: Rename kirkwood definitions to mvebu
Date: Wed, 20 Mar 2013 19:36:30 -0300
Message-ID: <1363818997-23137-10-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:50616 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab3CTWhW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Mar 2013 18:37:22 -0400
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This definitions will be also valid for other SoC,
such as Armada 370 and Armada XP. Therefore we rename them as 'mvebu'.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/mvebu_thermal.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
index ed4c9b0..3304057 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -22,10 +22,10 @@
 #include <linux/platform_device.h>
 #include <linux/thermal.h>
 
-#define KIRKWOOD_THERMAL_VALID_OFFSET	9
-#define KIRKWOOD_THERMAL_VALID_MASK	0x1
-#define KIRKWOOD_THERMAL_TEMP_OFFSET	10
-#define KIRKWOOD_THERMAL_TEMP_MASK	0x1FF
+#define MVEBU_THERMAL_VALID_OFFSET	9
+#define MVEBU_THERMAL_VALID_MASK	0x1
+#define MVEBU_THERMAL_TEMP_OFFSET	10
+#define MVEBU_THERMAL_TEMP_MASK		0x1FF
 
 /* Marvell EBU Thermal Sensor Dev Structure */
 struct mvebu_thermal_priv {
@@ -41,15 +41,15 @@ static int mvebu_get_temp(struct thermal_zone_device *thermal,
 	reg = readl_relaxed(priv->sensor);
 
 	/* Valid check */
-	if (!((reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
-	    KIRKWOOD_THERMAL_VALID_MASK)) {
+	if (!((reg >> MVEBU_THERMAL_VALID_OFFSET) &
+	    MVEBU_THERMAL_VALID_MASK)) {
 		dev_err(&thermal->device,
 			"Temperature sensor reading not valid\n");
 		return -EIO;
 	}
 
-	reg = (reg >> KIRKWOOD_THERMAL_TEMP_OFFSET) &
-		KIRKWOOD_THERMAL_TEMP_MASK;
+	reg = (reg >> MVEBU_THERMAL_TEMP_OFFSET) &
+		MVEBU_THERMAL_TEMP_MASK;
 	*temp = ((2363302UL - (7339*reg)) / 10);
 
 	return 0;
-- 
1.7.8.6

