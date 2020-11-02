Return-Path: <SRS0=ViTu=EI=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C18C388F2
	for <linux-pm@archiver.kernel.org>; Mon,  2 Nov 2020 14:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B961206F8
	for <linux-pm@archiver.kernel.org>; Mon,  2 Nov 2020 14:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgKBO0A (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 2 Nov 2020 09:26:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7402 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgKBOWy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 09:22:54 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CPw9W581Lz72J1;
        Mon,  2 Nov 2020 22:22:39 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 2 Nov 2020
 22:22:37 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>
Subject: [PATCH] power: supply: bq24190_charger: fix reference leak
Date:   Mon, 2 Nov 2020 22:33:21 +0800
Message-ID: <20201102143321.143443-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it
failed. Forgetting to call pm_runtime_put_noidle will result
in reference leak in callers(bq24190_sysfs_show,
bq24190_charger_get_property, bq24190_charger_set_property,
bq24190_battery_get_property, bq24190_battery_set_property),
so we should fix it.

Fixes: f385e6e2a1532 ("power: bq24190_charger: Use PM runtime autosuspend")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/power/supply/bq24190_charger.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index d14186525e1e..845af0f44c02 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -448,8 +448,10 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(bdi->dev);
 		return ret;
+	}
 
 	ret = bq24190_read_mask(bdi, info->reg, info->mask, info->shift, &v);
 	if (ret)
@@ -1077,8 +1079,10 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
 	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(bdi->dev);
 		return ret;
+	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
@@ -1149,8 +1153,10 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
 	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(bdi->dev);
 		return ret;
+	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -1410,8 +1416,10 @@ static int bq24190_battery_get_property(struct power_supply *psy,
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
 	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(bdi->dev);
 		return ret;
+	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -1456,8 +1464,10 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
 	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(bdi->dev);
 		return ret;
+	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
-- 
2.17.1

