From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v2 4/4] thermal: armada: use msleep for long delays
Date: Sun,  3 Dec 2017 13:11:24 +0200
Message-ID: <0f09adfb9790009eb4ee4cdc62ce83307c0feede.1512299484.git.baruch@tkos.co.il>
References: <f8c589337a4fb78852eadf15058e8f8d132d4dc0.1512299484.git.baruch@tkos.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f8c589337a4fb78852eadf15058e8f8d132d4dc0.1512299484.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Use msleep for long (> 10ms) delays, instead of the busy waiting mdelay.
All delays are called from the probe routine, where scheduling is
allowed.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
v2: New patch
---
 drivers/thermal/armada_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 59b75f63945d..d86538d4f519 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -119,7 +119,7 @@ static void armada370_init_sensor(struct platform_device *pdev,
 	reg &= ~PMU_TDC0_START_CAL_MASK;
 	writel(reg, priv->control);
 
-	mdelay(10);
+	msleep(10);
 }
 
 static void armada375_init_sensor(struct platform_device *pdev,
@@ -133,11 +133,11 @@ static void armada375_init_sensor(struct platform_device *pdev,
 	reg &= ~A375_HW_RESETn;
 
 	writel(reg, priv->control + 4);
-	mdelay(20);
+	msleep(20);
 
 	reg |= A375_HW_RESETn;
 	writel(reg, priv->control + 4);
-	mdelay(50);
+	msleep(50);
 }
 
 static void armada380_init_sensor(struct platform_device *pdev,
@@ -151,7 +151,7 @@ static void armada380_init_sensor(struct platform_device *pdev,
 	if (!(reg & A380_HW_RESET)) {
 		reg |= A380_HW_RESET;
 		writel(reg, control_msb);
-		mdelay(10);
+		msleep(10);
 	}
 }
 
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
