From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 10/12] thermal: armada: Wait sensors validity before exiting the init callback
Date: Mon, 18 Dec 2017 15:36:41 +0100
Message-ID: <20171218143643.7714-11-miquel.raynal@free-electrons.com>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171218143643.7714-1-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The thermal core will check for sensors validity right after the
initialization callback has returned. As the initialization routine make
a reset, the sensors are not ready immediately and the core spawns an
error in the dmesg. Avoid this annoying situation by polling on the
validity bit before exiting from these routines. This also avoid the use
of blind sleeps.

Suggested-by: David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/thermal/armada_thermal.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 2eadd662591d..4a5164ddffe7 100644
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
