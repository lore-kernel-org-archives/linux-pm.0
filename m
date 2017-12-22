From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v7 09/11] thermal: armada: Change sensors trim default value
Date: Fri, 22 Dec 2017 17:14:11 +0100
Message-ID: <20171222161413.20816-10-miquel.raynal@free-electrons.com>
References: <20171222161413.20816-1-miquel.raynal@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171222161413.20816-1-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Errata #132698 highlights an error in the default value of Tc trim.
Set this parameter to b'011.

Suggested-by: David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/thermal/armada_thermal.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index d426b230e1c5..e6025d215cb5 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -46,6 +46,10 @@
 #define CONTROL0_OFFSET			0x0
 #define CONTROL1_OFFSET			0x4
 
+/* Errata fields */
+#define CONTROL0_TSEN_TC_TRIM_MASK	0x7
+#define CONTROL0_TSEN_TC_TRIM_VAL	0x3
+
 /* TSEN refers to the temperature sensors within the AP */
 #define CONTROL0_TSEN_START		BIT(0)
 #define CONTROL0_TSEN_RESET		BIT(1)
@@ -161,6 +165,15 @@ static void armada380_init_sensor(struct platform_device *pdev,
 	reg &= ~CONTROL1_EXT_TSEN_SW_RESET;
 	writel(reg, priv->control1);
 	msleep(10);
+
+	/* Set Tsen Tc Trim to correct default value (errata #132698) */
+	if (priv->control0) {
+		reg = readl_relaxed(priv->control0);
+		reg &= ~CONTROL0_TSEN_TC_TRIM_MASK;
+		reg |= CONTROL0_TSEN_TC_TRIM_VAL;
+		writel(reg, priv->control0);
+		msleep(10);
+	}
 }
 
 static void armada_ap806_init_sensor(struct platform_device *pdev,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
