Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9136FC433FE
	for <linux-pm@archiver.kernel.org>; Mon, 21 Nov 2022 01:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKUBOK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 20 Nov 2022 20:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKUBOJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Nov 2022 20:14:09 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE5F2AC6E
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 17:14:07 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NFqCR2LRtzRpP8;
        Mon, 21 Nov 2022 09:13:39 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 09:13:32 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 09:13:31 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <sre@kernel.org>, <linus.walleij@linaro.org>, <daniel@zonque.org>
CC:     <linux-pm@vger.kernel.org>
Subject: [PATCH] power: supply: z2_battery: Fix possible memleak in z2_batt_probe()
Date:   Mon, 21 Nov 2022 09:18:31 +0800
Message-ID: <20221121011834.119060-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If devm_gpiod_get_optional() returns error, the charger should be
freed before z2_batt_probe returns according to the context. We
fix it by just gotoing to 'err' branch.

Fixes: a3b4388ea19b ("power: supply: z2_battery: Convert to GPIO descriptors")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/power/supply/z2_battery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/z2_battery.c b/drivers/power/supply/z2_battery.c
index 1897c2984860..d033c1d3ee42 100644
--- a/drivers/power/supply/z2_battery.c
+++ b/drivers/power/supply/z2_battery.c
@@ -206,10 +206,12 @@ static int z2_batt_probe(struct i2c_client *client,
 
 	charger->charge_gpiod = devm_gpiod_get_optional(&client->dev,
 							NULL, GPIOD_IN);
-	if (IS_ERR(charger->charge_gpiod))
-		return dev_err_probe(&client->dev,
+	if (IS_ERR(charger->charge_gpiod)) {
+		ret = dev_err_probe(&client->dev,
 				     PTR_ERR(charger->charge_gpiod),
 				     "failed to get charge GPIO\n");
+		goto err;
+	}
 
 	if (charger->charge_gpiod) {
 		gpiod_set_consumer_name(charger->charge_gpiod, "BATT CHRG");
-- 
2.25.1

