Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1858CC4332F
	for <linux-pm@archiver.kernel.org>; Thu, 17 Nov 2022 02:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiKQCrg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 16 Nov 2022 21:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKQCrg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Nov 2022 21:47:36 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AA743AD6
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2022 18:47:34 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NCPTC72Y6zRpGl;
        Thu, 17 Nov 2022 10:47:11 +0800 (CST)
Received: from huawei.com (10.175.100.227) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 10:47:32 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <t.schramm@manjaro.org>, <sre@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <linux-pm@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH] power: supply: cw2015: Fix potential null-ptr-deref in cw_bat_probe()
Date:   Thu, 17 Nov 2022 10:45:58 +0800
Message-ID: <20221117024558.4014-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cw_bat_probe() calls create_singlethread_workqueue() and not checked the
ret value, which may return NULL. And a null-ptr-deref may happen:

cw_bat_probe()
    create_singlethread_workqueue() # failed, cw_bat->wq is NULL
    queue_delayed_work()
        queue_delayed_work_on()
            __queue_delayed_work()  # warning here, but continue
                __queue_work()      # access wq->flags, null-ptr-deref

Check the ret value and return -ENOMEM if it is NULL.

Fixes: b4c7715c10c1 ("power: supply: add CellWise cw2015 fuel gauge driver")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 drivers/power/supply/cw2015_battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 6d52641151d9..473522b4326a 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -699,6 +699,9 @@ static int cw_bat_probe(struct i2c_client *client)
 	}
 
 	cw_bat->battery_workqueue = create_singlethread_workqueue("rk_battery");
+	if (!cw_bat->battery_workqueue)
+		return -ENOMEM;
+
 	devm_delayed_work_autocancel(&client->dev,
 							  &cw_bat->battery_delay_work, cw_bat_work);
 	queue_delayed_work(cw_bat->battery_workqueue,
-- 
2.17.1

