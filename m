Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E247CC4361B
	for <linux-pm@archiver.kernel.org>; Wed, 16 Dec 2020 06:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E11423343
	for <linux-pm@archiver.kernel.org>; Wed, 16 Dec 2020 06:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgLPGKM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 16 Dec 2020 01:10:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9208 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgLPGKM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 01:10:12 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cwl7G1jhfzkqyS;
        Wed, 16 Dec 2020 14:08:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 14:09:29 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <sre@kernel.org>, <hdegoede@redhat.com>, <wens@csie.org>
CC:     <linux-pm@vger.kernel.org>
Subject: [PATCH] power: supply: axp288_charger: switch to using devm_add_action_or_reset()
Date:   Wed, 16 Dec 2020 14:09:38 +0800
Message-ID: <1608098978-53068-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

switch to using devm_add_action_or_reset() instead of devm_add_action.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/power/supply/axp288_charger.c | 2 +-
 kernel/dma/map_benchmark.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index a4df1ea..6480c2e 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -855,7 +855,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	}
 
 	/* Cancel our work on cleanup, register this before the notifiers */
-	ret = devm_add_action(dev, axp288_charger_cancel_work, info);
+	ret = devm_add_action_or_reset(dev, axp288_charger_cancel_work, info);
 	if (ret)
 		return ret;
 
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 19f6616..775191d 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -294,7 +294,7 @@ static int __map_benchmark_probe(struct device *dev)
 		return -ENOMEM;
 	map->dev = dev;
 
-	ret = devm_add_action(dev, map_benchmark_remove_debugfs, map);
+	ret = devm_add_action_or_reset(dev, map_benchmark_remove_debugfs, map);
 	if (ret) {
 		pr_err("Can't add debugfs remove action\n");
 		return ret;
-- 
2.7.4

