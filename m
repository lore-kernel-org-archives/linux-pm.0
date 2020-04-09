Return-Path: <SRS0=OdXI=5Z=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A109C2D0EA
	for <linux-pm@archiver.kernel.org>; Thu,  9 Apr 2020 08:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB16921473
	for <linux-pm@archiver.kernel.org>; Thu,  9 Apr 2020 08:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDIIzg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:55:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12629 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgDIIzg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Apr 2020 04:55:36 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EFA14AC271DD9720191F;
        Thu,  9 Apr 2020 16:55:34 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 16:55:27 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] power: supply: max14656: remove set but not used 'ret'
Date:   Thu, 9 Apr 2020 16:54:01 +0800
Message-ID: <20200409085401.47516-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following gcc warning:

drivers/power/supply/max14656_charger_detector.c:142:6: warning:
variable ‘ret’ set but not used [-Wunused-but-set-variable]
  int ret = 0;
      ^~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/power/supply/max14656_charger_detector.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/power/supply/max14656_charger_detector.c
index 3bbb8b4c8ae7..137f9fafce8c 100644
--- a/drivers/power/supply/max14656_charger_detector.c
+++ b/drivers/power/supply/max14656_charger_detector.c
@@ -139,10 +139,9 @@ static void max14656_irq_worker(struct work_struct *work)
 
 	u8 buf[REG_TOTAL_NUM];
 	u8 chg_type;
-	int ret = 0;
 
-	ret = max14656_read_block_reg(chip->client, MAX14656_DEVICE_ID,
-				      REG_TOTAL_NUM, buf);
+	max14656_read_block_reg(chip->client, MAX14656_DEVICE_ID,
+				REG_TOTAL_NUM, buf);
 
 	if ((buf[MAX14656_STATUS_1] & STATUS1_VB_VALID_MASK) &&
 		(buf[MAX14656_STATUS_1] & STATUS1_CHG_TYPE_MASK)) {
-- 
2.17.2

