Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFE9C54EE9
	for <linux-pm@archiver.kernel.org>; Tue, 27 Sep 2022 13:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiI0Nkm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 27 Sep 2022 09:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiI0Nkj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 09:40:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB46751A15
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 06:40:37 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4McLH90VcFzHthJ;
        Tue, 27 Sep 2022 21:35:49 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 21:40:35 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <linus.walleij@linaro.org>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH] power: supply: ab8500: Remove unused struct ab8500_chargalg_sysfs_entry
Date:   Tue, 27 Sep 2022 13:37:58 +0000
Message-ID: <20220927133758.98745-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

After commit 75ee3f6f0c1a("power: supply: ab8500_chargalg: Drop enable/disable
sysfs"), no one use struct ab8500_chargalg_sysfs_entry, so remove it.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/power/supply/ab8500_chargalg.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 05146d436a6a..ea4ad61d4c7e 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -252,12 +252,6 @@ static enum power_supply_property ab8500_chargalg_props[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 };
 
-struct ab8500_chargalg_sysfs_entry {
-	struct attribute attr;
-	ssize_t (*show)(struct ab8500_chargalg *di, char *buf);
-	ssize_t (*store)(struct ab8500_chargalg *di, const char *buf, size_t length);
-};
-
 /**
  * ab8500_chargalg_safety_timer_expired() - Expiration of the safety timer
  * @timer:     pointer to the hrtimer structure
-- 
2.17.1

