Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88F3C4332F
	for <linux-pm@archiver.kernel.org>; Tue, 29 Nov 2022 09:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiK2JB2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 29 Nov 2022 04:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiK2JB0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Nov 2022 04:01:26 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB7B65AE;
        Tue, 29 Nov 2022 01:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1669712485;
  x=1701248485;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cXRJQL3OW0O3RetIWNaCoK87alGVsI/co+OWhHfGavI=;
  b=pqZPtrTWuLZVz68ulQUUcsI3AQbCRlHv+bGAx/s2prnkA3yIJLoJv4V0
   WpQKcpdcgyBBiOIQre3DbYpmdTYw1MYjyQmQpZZHLlhXxiOVcYAPXlNKq
   yXd4Qjp5Qlzkugqh0OQOdaoKHHtmiy9sPmtFjUeOWkxYP0rWte3/1ZLGQ
   qTCPXvDXMZxBRT9VyfRxh7XtaNpxARNvc26MSzzdBOfanyhumbM0EUvLx
   vHFXx2hufYfIMAqq2NbW+JXCFvpAMbXxhKN+66pheL5LwhOFpHZ6Lqo7W
   3RB7tfvr095se+WCexzPheIp2WNzfrMB+dv8vpzPD91blCbCrfYBauOTD
   Q==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] power: supply: bq256xx: Remove init ichg/vbat with max value
Date:   Tue, 29 Nov 2022 17:01:12 +0800
Message-ID: <20221129090112.3451501-1-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Init the ichg and vbat reg with max value is not good. First the chip
already has a default value for ichg and vbat (small value). Init these
two reg with max value will result an unsafe case (e.g. battery is over
charging in a hot environment) if no user space change them later.

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---
 drivers/power/supply/bq256xx_charger.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 01ad84fd147c..d1aa92c10c22 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1562,21 +1562,11 @@ static int bq256xx_hw_init(struct bq256xx_device *bq)
 	if (ret)
 		return ret;
 
-	ret = bq->chip_info->bq256xx_set_ichg(bq,
-				bat_info->constant_charge_current_max_ua);
-	if (ret)
-		return ret;
-
 	ret = bq->chip_info->bq256xx_set_iprechg(bq,
 				bat_info->precharge_current_ua);
 	if (ret)
 		return ret;
 
-	ret = bq->chip_info->bq256xx_set_vbatreg(bq,
-				bat_info->constant_charge_voltage_max_uv);
-	if (ret)
-		return ret;
-
 	ret = bq->chip_info->bq256xx_set_iterm(bq,
 				bat_info->charge_term_current_ua);
 	if (ret)
-- 
2.30.2

