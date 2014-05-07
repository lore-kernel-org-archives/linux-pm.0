From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/3] thermal: rcar: remove unnecessary OOM messages
Date: Wed, 07 May 2014 15:03:25 +0900
Message-ID: <01a401cf69ba$0f1b88d0$2d529a70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:24109 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbaEGGD1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 May 2014 02:03:27 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5600KXFWTPBUB0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 07 May 2014 15:03:25 +0900 (KST)
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Zhang Rui' <rui.zhang@intel.com>
Cc: 'Eduardo Valentin' <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Kuninori Morimoto' <kuninori.morimoto.gx@renesas.com>, 'Simon Horman' <horms+renesas@verge.net.au>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/thermal/rcar_thermal.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 5a37940..105ab5e 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -374,10 +374,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	int idle = IDLE_INTERVAL;
 
 	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
-	if (!common) {
-		dev_err(dev, "Could not allocate common\n");
+	if (!common)
 		return -ENOMEM;
-	}
 
 	INIT_LIST_HEAD(&common->head);
 	spin_lock_init(&common->lock);
@@ -423,7 +421,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 
 		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 		if (!priv) {
-			dev_err(dev, "Could not allocate priv\n");
 			ret = -ENOMEM;
 			goto error_unregister;
 		}
-- 
1.7.10.4


