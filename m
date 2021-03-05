Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C798C433E0
	for <linux-pm@archiver.kernel.org>; Fri,  5 Mar 2021 06:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 263B36501C
	for <linux-pm@archiver.kernel.org>; Fri,  5 Mar 2021 06:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhCEG4X (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 5 Mar 2021 01:56:23 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:38439 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhCEG4X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 01:56:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UQVykeW_1614927374;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UQVykeW_1614927374)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Mar 2021 14:56:19 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] power: supply: cpcap-charger: Remove unnecessary conversion to bool
Date:   Fri,  5 Mar 2021 14:56:10 +0800
Message-Id: <1614927370-84987-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/power/supply/cpcap-charger.c:468:31-36: WARNING: conversion to
bool not needed here.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/power/supply/cpcap-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 641dcad..0437480 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -465,7 +465,7 @@ static bool cpcap_charger_vbus_valid(struct cpcap_charger_ddata *ddata)
 
 	error = iio_read_channel_processed(channel, &value);
 	if (error >= 0)
-		return value > 3900 ? true : false;
+		return value > 3900;
 
 	dev_err(ddata->dev, "error reading VBUS: %i\n", error);
 
-- 
1.8.3.1

