From: <louis.yu@mediatek.com>
Subject: [PATCH v1 4/4] thermal: mediatek: minor mtk_thermal.c cleanups
Date: Thu, 27 Jul 2017 13:46:57 +0800
Message-ID: <1501134417-3505-5-git-send-email-louis.yu@mediatek.com>
References: <1501134417-3505-1-git-send-email-louis.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:58583 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750981AbdG0FsT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 01:48:19 -0400
In-Reply-To: <1501134417-3505-1-git-send-email-louis.yu@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, dawei.chien@mediatek.com, fan.chen@mediatek.com, eddie.huang@mediatek.com, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Louis Yu <louis.yu@mediatek.com>

From: Louis Yu <louis.yu@mediatek.com>

Move thermal module reset in the beginning and revise clock error
handle flow to pair the clock control.

Signed-off-by: Louis Yu <louis.yu@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index f2a7155..5dffdb4 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -712,20 +712,20 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ret = device_reset(&pdev->dev);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(mt->clk_auxadc);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", ret);
-		return ret;
-	}
-
-	ret = device_reset(&pdev->dev);
-	if (ret)
 		goto err_disable_clk_auxadc;
+	}
 
 	ret = clk_prepare_enable(mt->clk_peri_therm);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
-		goto err_disable_clk_auxadc;
+		goto err_disable_clk_peri_therm;
 	}
 
 	for (i = 0; i < mt->conf->num_banks; i++)
-- 
1.9.1
