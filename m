From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] thermal: rcar: set up I/O base before requesting IRQ
Date: Tue,  4 Jun 2013 11:09:13 +0900
Message-ID: <1370311753-6463-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Ulrich Hecht <ulrich.hecht@gmail.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-pm@vger.kernel.org

From: Ulrich Hecht <ulrich.hecht@gmail.com>

It is used by the interrupt handler. Fixes crash when booting via kexec
on APE6 board.

This problem was introduced by e0a5172e9eec7f0d3c476e013c51dab62f3fc666
("thermal: rcar: add interrupt support") which was introduced in v3.8-rc3.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[horms+renesas@verge.net.au: enhanced changelog to include commit
  that cuases the problem ]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/thermal/rcar_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Hi Zhang,

could you consider this fix for v3.10?

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 8d7edd4..7641dcc 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -395,13 +395,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			return -ENODEV;
 		}
 
-		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
-				       dev_name(dev), common);
-		if (ret) {
-			dev_err(dev, "irq request failed\n ");
-			return ret;
-		}
-
 		/*
 		 * rcar_has_irq_support() will be enabled
 		 */
@@ -409,6 +402,13 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		if (IS_ERR(common->base))
 			return PTR_ERR(common->base);
 
+		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
+				       dev_name(dev), common);
+		if (ret) {
+			dev_err(dev, "irq request failed\n ");
+			return ret;
+		}
+
 		/* enable temperature comparation */
 		rcar_thermal_common_write(common, ENR, 0x00030303);
 
-- 
1.8.2.1

