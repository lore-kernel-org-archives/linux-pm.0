From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] thermal: hisilicon: Handle return value of clk_prepare_enable
Date: Tue,  6 Jun 2017 15:04:46 +0530
Message-ID: <3343de0616933425916bbe0dc3359d9e3e3608a1.1496741588.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34492 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdFFJfG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jun 2017 05:35:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/thermal/hisi_thermal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index f642966..9c3ce34 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -397,8 +397,11 @@ static int hisi_thermal_suspend(struct device *dev)
 static int hisi_thermal_resume(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
+	int ret;
 
-	clk_prepare_enable(data->clk);
+	ret = clk_prepare_enable(data->clk);
+	if (ret)
+		return ret;
 
 	data->irq_enabled = true;
 	hisi_thermal_enable_bind_irq_sensor(data);
-- 
1.9.1
