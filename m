From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next v2] thermal: rcar: fix missing unlock on error in rcar_thermal_update_temp()
Date: Fri, 22 Feb 2013 21:22:39 +0800
Message-ID: <CAPgLHd8z1nXC1KiyFDReqayrceZCz_tzPUzWjgxjv5hjyFqdJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:43227 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756700Ab3BVNWl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Feb 2013 08:22:41 -0500
Received: by mail-bk0-f44.google.com with SMTP id j4so284756bkw.17
        for <linux-pm@vger.kernel.org>; Fri, 22 Feb 2013 05:22:39 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, kuninori.morimoto.gx@renesas.com
Cc: yongjun_wei@trendmicro.com.cn, linux-pm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing unlock before return from function rcar_thermal_update_temp()
in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/thermal/rcar_thermal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 909bb4b..321a98d 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -145,6 +145,7 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
 	struct device *dev = rcar_priv_to_dev(priv);
 	int i;
 	int ctemp, old, new;
+	int ret = -EINVAL;
 
 	mutex_lock(&priv->lock);
 
@@ -174,7 +175,7 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
 
 	if (!ctemp) {
 		dev_err(dev, "thermal sensor was broken\n");
-		return -EINVAL;
+		goto err_out_unlock;
 	}
 
 	/*
@@ -192,10 +193,10 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
 	dev_dbg(dev, "thermal%d  %d -> %d\n", priv->id, priv->ctemp, ctemp);
 
 	priv->ctemp = ctemp;
-
+	ret = 0;
+err_out_unlock:
 	mutex_unlock(&priv->lock);
-
-	return 0;
+	return ret;
 }
 
 static int rcar_thermal_get_temp(struct thermal_zone_device *zone,


