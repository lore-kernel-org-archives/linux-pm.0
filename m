Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0ACC433ED
	for <linux-pm@archiver.kernel.org>; Sat, 10 Apr 2021 03:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0BF611AE
	for <linux-pm@archiver.kernel.org>; Sat, 10 Apr 2021 03:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhDJDvp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 9 Apr 2021 23:51:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16514 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbhDJDvo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 23:51:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FHLZc0x9TzNvHF;
        Sat, 10 Apr 2021 11:48:40 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Sat, 10 Apr 2021
 11:51:20 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <cuibixuan@huawei.com>, Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] power/reset: Add missing MODULE_DEVICE_TABLE
Date:   Sat, 10 Apr 2021 11:50:40 +0800
Message-ID: <20210410035040.11370-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 drivers/power/reset/restart-poweroff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
index d233daa5835b..04d4228119b2 100644
--- a/drivers/power/reset/restart-poweroff.c
+++ b/drivers/power/reset/restart-poweroff.c
@@ -45,6 +45,7 @@ static const struct of_device_id of_restart_poweroff_match[] = {
 	{ .compatible = "restart-poweroff", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, of_restart_poweroff_match);
 
 static struct platform_driver restart_poweroff_driver = {
 	.probe = restart_poweroff_probe,

