From: Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH v4 09/12] thermal: armada: Change sensors trim default value
Date: Mon, 18 Dec 2017 15:36:40 +0100
Message-ID: <20171218143643.7714-10-miquel.raynal@free-electrons.com>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54129 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758852AbdLROgv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Dec 2017 09:36:51 -0500
In-Reply-To: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Miquel Raynal <miquel.raynal@free-electrons.com>, Baruch Siach <baruch@tkos.co.il>, David Sniatkiwicz <davidsn@marvell.com>

Errata #132698 highlights an error in the default value of Tc trim.
Set this parameter to b'011.

Suggested-by: David Sniatkiwicz <davidsn@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index cef5c65c8f32..2eadd662591d 100644
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
