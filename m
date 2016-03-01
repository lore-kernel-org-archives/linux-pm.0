From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] thermal: rcar_thermal: don't open code of_device_get_match_data()
Date: Tue,  1 Mar 2016 17:38:31 +0100
Message-ID: <1456850319-8386-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60016 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbcCAQio (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Mar 2016 11:38:44 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This change will also make Coverity happy by avoiding a theoretical NULL
pointer dereference; yet another reason is to use the above helper function
to tighten the code and make it more readable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Tested on a Lager board.

 drivers/thermal/rcar_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 0e735acea33afc..82daba09e1503a 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -430,8 +430,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	struct rcar_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct resource *res, *irq;
-	const struct of_device_id *of_id = of_match_device(rcar_thermal_dt_ids, dev);
-	unsigned long of_data = (unsigned long)of_id->data;
+	unsigned long of_data = (unsigned long)of_device_get_match_data(dev);
 	int mres = 0;
 	int i;
 	int ret = -ENODEV;
-- 
2.7.0

