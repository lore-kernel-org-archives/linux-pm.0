From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 082/102] thermal: rockchip: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:26:26 +0200
Message-ID: <20170719152646.25903-83-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56169 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933248AbdGSP3x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 11:29:53 -0400
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/thermal/rockchip_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 4c77965124535..7ca53a4368124 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1088,7 +1088,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(thermal->regs))
 		return PTR_ERR(thermal->regs);
 
-	thermal->reset = devm_reset_control_get(&pdev->dev, "tsadc-apb");
+	thermal->reset = devm_reset_control_get_exclusive(&pdev->dev,
+							  "tsadc-apb");
 	if (IS_ERR(thermal->reset)) {
 		error = PTR_ERR(thermal->reset);
 		dev_err(&pdev->dev, "failed to get tsadc reset: %d\n", error);
-- 
2.11.0
