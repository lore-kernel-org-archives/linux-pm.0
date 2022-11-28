Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00662C433FE
	for <linux-pm@archiver.kernel.org>; Mon, 28 Nov 2022 14:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiK1OJL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiK1OIs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 09:08:48 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7632188C;
        Mon, 28 Nov 2022 06:07:54 -0800 (PST)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NLRyv3vHdzqSk3;
        Mon, 28 Nov 2022 22:03:51 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 22:07:51 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qiheng Lin <linqiheng@huawei.com>
Subject: [PATCH] power: supply: Fix refcount leak in rk817_charger_probe
Date:   Mon, 28 Nov 2022 22:27:40 +0800
Message-ID: <20221128142740.1414-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
 drivers/power/supply/rk817_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 635f051b0821..d25a81d79fac 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1060,8 +1060,10 @@ static int rk817_charger_probe(struct platform_device *pdev)
 		return -ENODEV;

 	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
-	if (!charger)
+	if (!charger) {
+		of_node_put(node);
 		return -ENOMEM;
+	}

 	charger->rk808 = rk808;

--
2.32.0

