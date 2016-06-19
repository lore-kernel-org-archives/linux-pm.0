From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Subject: [PATCH/RFC 1/3] thermal: rcar_gen3_thermal: Modify the shared irq
 with initialization
Date: Sun, 19 Jun 2016 11:13:59 +0700
Message-ID: <57661C07.9050905@rvc.renesas.com>
References: <57661211.7010900@rvc.renesas.com>
 <57661BB1.3060401@rvc.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:59121 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751310AbcFSEOD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 19 Jun 2016 00:14:03 -0400
In-Reply-To: <57661BB1.3060401@rvc.renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb@rvc.renesas.com>, "Hien Duy. Dang" <hien.dang.eb@rvc.renesas.com>, Toru Oishi <toru.oishi.zj@rvc.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Catalin Marinas <catalin.marinas@arm.com>, Simon Horman <horms@verge.net.au>, "Khiem Trong. Nguyen" <khiem.nguyen.xt@rvc.r>

In R-CAR Gen3 series, it has some thermal sensors. The interrupt I/F
that can be used in thermal sensors is three. So it should be used
the interrupt I/F as shared.

This patch changes the shared settings for the thermal interrupts.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index a9a372b..e640a14 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -416,6 +416,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	int ret = -ENODEV;
 	int idle;
 	struct device_node *tz_nd, *tmp_nd;
+	int i, irq_cnt;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -489,13 +490,18 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	rcar_gen3_thermal_irq_enable(priv);
 
 	/* Interrupt */
-	if (irq) {
-		ret = devm_request_irq(dev, irq->start,
-					rcar_gen3_thermal_irq, 0,
-				       dev_name(dev), priv);
-		if (ret) {
-			dev_err(dev, "IRQ request failed\n ");
-			goto error_unregister;
+	if (rcar_has_irq_support(priv)) {
+		irq_cnt = platform_irq_count(pdev);
+		for (i = 0; i < irq_cnt; i++) {
+			irq = platform_get_resource(pdev, IORESOURCE_IRQ, i);
+			ret = devm_request_irq(dev, irq->start,
+					       rcar_gen3_thermal_irq,
+					       IRQF_SHARED,
+					       dev_name(dev), priv);
+			if (ret) {
+				dev_err(dev, "IRQ request failed\n ");
+				goto error_unregister;
+			}
 		}
 	}
 
-- 
1.9.1

