Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD53C4332F
	for <linux-pm@archiver.kernel.org>; Fri,  2 Dec 2022 06:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiLBG1S (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 2 Dec 2022 01:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiLBG1R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 01:27:17 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD63E98548
        for <linux-pm@vger.kernel.org>; Thu,  1 Dec 2022 22:27:16 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NNjdL6L1kzHwCm;
        Fri,  2 Dec 2022 14:26:30 +0800 (CST)
Received: from huawei.com (10.175.100.227) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 2 Dec
 2022 14:27:14 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux@rempel-privat.de>, <linux-pm@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH] thermal: imx: Fix missing clk_disable_unprepare in imx_thermal_runtime_resume()
Date:   Fri, 2 Dec 2022 14:25:14 +0800
Message-ID: <20221202062514.6989-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The clk_disable_unprepare() should be called in the error handling of
imx_thermal_runtime_resume().

Fixes: 4cf2ddf16e17 ("thermal/drivers/imx: Implement runtime PM support")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 drivers/thermal/imx_thermal.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 16663373b682..67925a7f5b25 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -897,12 +897,12 @@ static int __maybe_unused imx_thermal_runtime_resume(struct device *dev)
 	ret = regmap_write(map, socdata->sensor_ctrl + REG_CLR,
 			   socdata->power_down_mask);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	ret = regmap_write(map, socdata->sensor_ctrl + REG_SET,
 			   socdata->measure_temp_mask);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	/*
 	 * According to the temp sensor designers, it may require up to ~17us
@@ -911,6 +911,10 @@ static int __maybe_unused imx_thermal_runtime_resume(struct device *dev)
 	usleep_range(20, 50);
 
 	return 0;
+
+err_clk:
+	clk_disable_unprepare(data->thermal_clk);
+	return ret;
 }
 
 static const struct dev_pm_ops imx_thermal_pm_ops = {
-- 
2.17.1

