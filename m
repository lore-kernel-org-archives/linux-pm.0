From: Bai Ping <B51503@freescale.com>
Subject: [PATCH v2] thermal: imx: correct driver load sequence for cpu cooling
Date: Tue, 14 Oct 2014 13:12:07 +0800
Message-ID: <1413263527-31102-1-git-send-email-B51503@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1bbn0102.outbound.protection.outlook.com ([157.56.111.102]:7466
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754323AbaJNGRT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Oct 2014 02:17:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org

From: Bai Ping <b51503@freescale.com>

thermal driver should be regisetered after cpufreq driver has
been registered and probed. Doing so is to make sure that thermal
driver can get the max cpu cooling states correctly when calling
get_property.

Signed-off-by: Bai Ping <b51503@freescale.com>
---
Changes for v2
-Address the comments from Eduardo Valentin

 drivers/thermal/imx_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 2c516f2..8697caf 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -406,6 +406,10 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	int measure_freq;
 	int ret;
 
+	if (!cpufreq_get_current_driver()) {
+		dev_dbg(&pdev->dev, "no cpufreq driver!");
+		return -EPROBE_DEFER;
+	}
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-- 
1.9.1

