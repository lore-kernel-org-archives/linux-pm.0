From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2 v2] thermal: rcar: tidyup registration failure case
Date: Tue, 02 Apr 2013 21:17:27 +0800
Message-ID: <1364908647.2190.39.camel@rzhang1-mobl4>
References: <87620gqbbe.wl%kuninori.morimoto.gx@renesas.com>
	 <874ng0qb9f.wl%kuninori.morimoto.gx@renesas.com>
	 <1364200856.2465.48.camel@rzhang1-mobl4>
	 <871ub3j9r3.wl%kuninori.morimoto.gx@renesas.com>
	 <87sj3iiu5m.wl%kuninori.morimoto.gx@renesas.com>
	 <87r4j2itio.wl%kuninori.morimoto.gx@renesas.com>
	 <87ppymith5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87ppymith5.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-pm@vger.kernel.org, Linux-SH <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2013-03-25 at 23:08 -0700, Kuninori Morimoto wrote:
> Current rcar_thermal driver didn't care about rcar_theraml_irq_disable()
> when registration failure case on _probe(), and _remove().
> And, it returns without unregistering thermal zone when
> registration failure case on _probe().
> This patch fixes these issue.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

rebased on thermal -next and applied.
please make a double check.

>From 1dc20828e674a781635286072bae909dc4e5c377 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 26 Mar 2013 06:08:10 +0000
Subject: [PATCH] thermal: rcar: tidyup registration failure case

Current rcar_thermal driver didn't care about rcar_theraml_irq_disable()
when registration failure case on _probe(), and _remove().
And, it returns without unregistering thermal zone when
registration failure case on _probe().
This patch fixes these issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/rcar_thermal.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 2cc5b61..4d6095b 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -419,12 +419,15 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 		if (!priv) {
 			dev_err(dev, "Could not allocate priv\n");
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto error_unregister;
 		}
 
 		priv->base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(priv->base))
-			return PTR_ERR(priv->base);
+		if (IS_ERR(priv->base)) {
+			ret = PTR_ERR(priv->base);
+			goto error_unregister;
+		}
 
 		priv->common = common;
 		priv->id = i;
@@ -443,10 +446,10 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
-		list_move_tail(&priv->list, &common->head);
-
 		if (rcar_has_irq_support(priv))
 			rcar_thermal_irq_enable(priv);
+
+		list_move_tail(&priv->list, &common->head);
 	}
 
 	platform_set_drvdata(pdev, common);
@@ -456,8 +459,11 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	return 0;
 
 error_unregister:
-	rcar_thermal_for_each_priv(priv, common)
+	rcar_thermal_for_each_priv(priv, common) {
 		thermal_zone_device_unregister(priv->zone);
+		if (rcar_has_irq_support(priv))
+			rcar_thermal_irq_disable(priv);
+	}
 
 	return ret;
 }
@@ -467,8 +473,11 @@ static int rcar_thermal_remove(struct platform_device *pdev)
 	struct rcar_thermal_common *common = platform_get_drvdata(pdev);
 	struct rcar_thermal_priv *priv;
 
-	rcar_thermal_for_each_priv(priv, common)
+	rcar_thermal_for_each_priv(priv, common) {
 		thermal_zone_device_unregister(priv->zone);
+		if (rcar_has_irq_support(priv))
+			rcar_thermal_irq_disable(priv);
+	}
 
 	platform_set_drvdata(pdev, NULL);
 
-- 
1.7.9.5



