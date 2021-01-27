Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE5FC433E0
	for <linux-pm@archiver.kernel.org>; Wed, 27 Jan 2021 08:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D986920754
	for <linux-pm@archiver.kernel.org>; Wed, 27 Jan 2021 08:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhA0IpG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:45:06 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:57673 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231228AbhA0Im4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 03:42:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UN1xQ0z_1611736927;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UN1xQ0z_1611736927)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Jan 2021 16:42:10 +0800
From:   Abaci Team <abaci-bugfix@linux.alibaba.com>
To:     rjw@rjwysocki.net
Cc:     khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abaci Team <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] PM: domains: Simplify the calculation of variables
Date:   Wed, 27 Jan 2021 16:42:05 +0800
Message-Id: <1611736925-32547-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/base/power/domain.c:938:31-33: WARNING !A || A && B is
equivalent to !A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Suggested-by: Jiapeng Zhong <oswb@linux.alibaba.com>
Signed-off-by: Abaci Team <abaci-bugfix@linux.alibaba.com>
---
 drivers/base/power/domain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9a14eed..e689710 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -934,8 +934,7 @@ static int genpd_runtime_resume(struct device *dev)
 err_stop:
 	genpd_stop_dev(genpd, dev);
 err_poweroff:
-	if (!pm_runtime_is_irq_safe(dev) ||
-		(pm_runtime_is_irq_safe(dev) && genpd_is_irq_safe(genpd))) {
+	if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
 		genpd_lock(genpd);
 		genpd_power_off(genpd, true, 0);
 		genpd_unlock(genpd);
-- 
1.8.3.1

