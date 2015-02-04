From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] thermal: rcar: Restore symmetry in error and remove paths
Date: Wed,  4 Feb 2015 13:22:35 +0100
Message-ID: <1423052555-14792-3-git-send-email-geert+renesas@glider.be>
References: <1423052555-14792-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:48031 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965611AbbBDMWm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 07:22:42 -0500
In-Reply-To: <1423052555-14792-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-pm@vger.kernel.org, linux-shvger.kernel.org@ramsan.of.borg, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Swap interrupt disable and thermal zone unregistration in the error and
remove paths, to make them more symmetrical with the initialization
path.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/rcar_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 3c2c1720ba4a4a72..fe4e767018c4cf73 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -463,9 +463,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 
 error_unregister:
 	rcar_thermal_for_each_priv(priv, common) {
-		thermal_zone_device_unregister(priv->zone);
 		if (rcar_has_irq_support(priv))
 			rcar_thermal_irq_disable(priv);
+		thermal_zone_device_unregister(priv->zone);
 	}
 
 	pm_runtime_put(dev);
@@ -481,9 +481,9 @@ static int rcar_thermal_remove(struct platform_device *pdev)
 	struct rcar_thermal_priv *priv;
 
 	rcar_thermal_for_each_priv(priv, common) {
-		thermal_zone_device_unregister(priv->zone);
 		if (rcar_has_irq_support(priv))
 			rcar_thermal_irq_disable(priv);
+		thermal_zone_device_unregister(priv->zone);
 	}
 
 	pm_runtime_put(dev);
-- 
1.9.1

