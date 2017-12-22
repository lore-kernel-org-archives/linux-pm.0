From: Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH v6 10/11] thermal: armada: Wait sensors validity before exiting the init callback
Date: Fri, 22 Dec 2017 10:32:25 +0100
Message-ID: <20171222093226.23456-11-miquel.raynal@free-electrons.com>
References: <20171222093226.23456-1-miquel.raynal@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:43098 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758139AbdLVJcw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Dec 2017 04:32:52 -0500
In-Reply-To: <20171222093226.23456-1-miquel.raynal@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Miquel Raynal <miquel.raynal@free-electrons.com>, Baruch Siach <baruch@tkos.co.il>, David Sniatkiwicz <davidsn@marvell.com>

The thermal core will check for sensors validity right after the
initialization callback has returned. As the initialization routine make
a reset, the sensors are not ready immediately and the core spawns an
error in the dmesg. Avoid this annoying situation by polling on the
validity bit before exiting from these routines. This also avoid the use
of blind sleeps.

Suggested-by: David Sniatkiwicz <davidsn@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index a3feaef7db20..ea958e651312 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
 #include <linux/thermal.h>
+#include <linux/iopoll.h>
 
 /* Thermal Manager Control and Status Register */
 #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
@@ -59,6 +60,9 @@
 #define CONTROL1_EXT_TSEN_SW_RESET	BIT(7)
 #define CONTROL1_EXT_TSEN_HW_RESETn	BIT(8)
 
+#define STATUS_POLL_PERIOD_US		1000
+#define STATUS_POLL_TIMEOUT_US		100000
+
 struct armada_thermal_data;
 
 /* Marvell EBU Thermal Sensor Dev Structure */
@@ -155,6 +159,16 @@ static void armada375_init_sensor(struct platform_device *pdev,
 	msleep(50);
 }
 
+static void armada_wait_sensor_validity(struct armada_thermal_priv *priv)
+{
+	u32 reg;
+
+	readl_relaxed_poll_timeout(priv->status, reg,
+				   reg & priv->data->is_valid_bit,
+				   STATUS_POLL_PERIOD_US,
+				   STATUS_POLL_TIMEOUT_US);
+}
+
 static void armada380_init_sensor(struct platform_device *pdev,
 				  struct armada_thermal_priv *priv)
 {
@@ -164,7 +178,6 @@ static void armada380_init_sensor(struct platform_device *pdev,
 	reg |= CONTROL1_EXT_TSEN_HW_RESETn;
 	reg &= ~CONTROL1_EXT_TSEN_SW_RESET;
 	writel(reg, priv->control1);
-	msleep(10);
 
 	/* Set Tsen Tc Trim to correct default value (errata #132698) */
 	if (priv->control0) {
@@ -172,8 +185,10 @@ static void armada380_init_sensor(struct platform_device *pdev,
 		reg &= ~CONTROL0_TSEN_TC_TRIM_MASK;
 		reg |= CONTROL0_TSEN_TC_TRIM_VAL;
 		writel(reg, priv->control0);
-		msleep(10);
 	}
+
+	/* Wait the sensors to be valid or the core will warn the user */
+	armada_wait_sensor_validity(priv);
 }
 
 static void armada_ap806_init_sensor(struct platform_device *pdev,
@@ -185,7 +200,9 @@ static void armada_ap806_init_sensor(struct platform_device *pdev,
 	reg &= ~CONTROL0_TSEN_RESET;
 	reg |= CONTROL0_TSEN_START | CONTROL0_TSEN_ENABLE;
 	writel(reg, priv->control0);
-	msleep(10);
+
+	/* Wait the sensors to be valid or the core will warn the user */
+	armada_wait_sensor_validity(priv);
 }
 
 static bool armada_is_valid(struct armada_thermal_priv *priv)
-- 
2.11.0
