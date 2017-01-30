From: Shailendra Verma <shailendra.v@samsung.com>
Subject: [PATCH] Thermal - Fix possible NULL derefrence.
Date: Mon, 30 Jan 2017 10:34:58 +0530
Message-ID: <1485752698-30248-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170130050525epcas1p3686ebf52f0215eef64a358338843305d@epcas1p3.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38809 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbdA3FF2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2017 00:05:28 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.v@samsung.com>, Shailendra Verma <shailendra.capricorn@gmail.com>

of_device_get_match_data could return NULL, and so can cause
a NULL pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 drivers/thermal/imx_thermal.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 06912f0..fb648a4 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -489,6 +489,10 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	data->tempmon = map;
 
 	data->socdata = of_device_get_match_data(&pdev->dev);
+	if (!data->socdata) {
+		dev_err(&pdev->dev, "no device match found\n");
+		return -ENODEV;
+	}
 
 	/* make sure the IRQ flag is clear before enabling irq on i.MX6SX */
 	if (data->socdata->version == TEMPMON_IMX6SX) {
-- 
1.7.9.5

