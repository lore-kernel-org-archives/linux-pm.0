Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE97FC0502A
	for <linux-pm@archiver.kernel.org>; Mon, 29 Aug 2022 01:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiH2BIB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 28 Aug 2022 21:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2BIA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Aug 2022 21:08:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C7421253;
        Sun, 28 Aug 2022 18:07:58 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MGC1b328czGptB;
        Mon, 29 Aug 2022 09:06:11 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 09:07:56 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 29 Aug
 2022 09:07:55 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liaoyu15@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH] cpuidle: remove redundant check in cpuidle_switch_governor
Date:   Mon, 29 Aug 2022 09:15:34 +0800
Message-ID: <20220829011534.445092-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

gov has already been NULL checked at the beginning of
cpuidle_switch_governor, so remove redundant check.

And use pr_info instead printk to fix the following checkpatch warning.

WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/cpuidle/governor.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index 29acaf48e575..9e6865edb942 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -63,12 +63,10 @@ int cpuidle_switch_governor(struct cpuidle_governor *gov)
 
 	cpuidle_curr_governor = gov;
 
-	if (gov) {
-		list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
-			cpuidle_enable_device(dev);
-		cpuidle_install_idle_handler();
-		printk(KERN_INFO "cpuidle: using governor %s\n", gov->name);
-	}
+	list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
+		cpuidle_enable_device(dev);
+	cpuidle_install_idle_handler();
+	pr_info("cpuidle: using governor %s\n", gov->name);
 
 	return 0;
 }
-- 
2.25.1

