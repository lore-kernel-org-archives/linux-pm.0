Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87E0C433DB
	for <linux-pm@archiver.kernel.org>; Wed,  3 Feb 2021 02:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B89064F65
	for <linux-pm@archiver.kernel.org>; Wed,  3 Feb 2021 02:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhBCCzH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 2 Feb 2021 21:55:07 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:52760 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231160AbhBCCzG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 21:55:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UNiyQmw_1612320860;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNiyQmw_1612320860)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Feb 2021 10:54:20 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     sre@kernel.org
Cc:     liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] power: vexpress: remove unneeded semicolon
Date:   Wed,  3 Feb 2021 10:54:19 +0800
Message-Id: <1612320859-10439-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/power/reset/vexpress-poweroff.c:136:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/power/reset/vexpress-poweroff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 1fdbcbd..447ffda 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -133,7 +133,7 @@ static int vexpress_reset_probe(struct platform_device *pdev)
 	case FUNC_REBOOT:
 		ret = _vexpress_register_restart_handler(&pdev->dev);
 		break;
-	};
+	}
 
 	return ret;
 }
-- 
1.8.3.1

