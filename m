From: Mason <slash.tmp@free.fr>
Subject: [PATCH] thermal: tango: initialize TEMPSI_CFG
Date: Tue, 3 May 2016 17:40:08 +0200
Message-ID: <5728C658.7050206@free.fr>
References: <57222B46.4070502@free.fr> <5728C4FA.6040200@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:8272 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755546AbcECPkY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 3 May 2016 11:40:24 -0400
In-Reply-To: <5728C4FA.6040200@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@arm.com>, Sebastian Frias <sf84@laposte.net>

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

TEMPSI_CFG is not equal to 0 at reset. It must be initialized.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/thermal/tango_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
index 22f9b1e92db1..70e0d9f406e9 100644
--- a/drivers/thermal/tango_thermal.c
+++ b/drivers/thermal/tango_thermal.c
@@ -80,6 +80,7 @@ static int tango_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	priv->thresh_idx = IDX_MIN;
+	writel(0, priv->base + TEMPSI_CFG);
 	writel(CMD_ON, priv->base + TEMPSI_CMD);
 
 	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &ops);
-- 
2.8.1
