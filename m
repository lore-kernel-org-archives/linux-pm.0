From: Louis Yu <louis.yu@mediatek.com>
Subject: [PATCH v2 4/4] thermal: mediatek: minor mtk_thermal.c cleanups
Date: Tue, 1 Aug 2017 15:28:33 +0800
Message-ID: <1501572513-7958-5-git-send-email-louis.yu@mediatek.com>
References: <1501572513-7958-1-git-send-email-louis.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:62551 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751663AbdHAH37 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2017 03:29:59 -0400
In-Reply-To: <1501572513-7958-1-git-send-email-louis.yu@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dawei Chien <dawei.chien@mediatek.com>, Fan Chen <fan.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Louis Yu <louis.yu@mediatek.com>

Move independent thermal module reset in the beginning.

Signed-off-by: Louis Yu <louis.yu@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index b609589..1e61c09 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -712,16 +712,16 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ret = device_reset(&pdev->dev);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(mt->clk_auxadc);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", ret);
 		return ret;
 	}
 
-	ret = device_reset(&pdev->dev);
-	if (ret)
-		goto err_disable_clk_auxadc;
-
 	ret = clk_prepare_enable(mt->clk_peri_therm);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
-- 
1.8.1.1.dirty
