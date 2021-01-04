Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EBCC433DB
	for <linux-pm@archiver.kernel.org>; Mon,  4 Jan 2021 13:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1FE21D93
	for <linux-pm@archiver.kernel.org>; Mon,  4 Jan 2021 13:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbhADNF4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 4 Jan 2021 08:05:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46422 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADNF4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 08:05:56 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kwPXu-0001Z7-1B; Mon, 04 Jan 2021 13:05:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: supply: max8997_charger: fix spelling mistake "diconnected" -> "disconnected"
Date:   Mon,  4 Jan 2021 13:05:13 +0000
Message-Id: <20210104130513.35563-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/max8997_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
index 23df91ed2c72..321bd6b8ee41 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -124,7 +124,7 @@ static void max8997_battery_extcon_evt_worker(struct work_struct *work)
 		dev_dbg(charger->dev, "USB CDP charger is connected\n");
 		current_limit = 650000;
 	} else {
-		dev_dbg(charger->dev, "USB charger is diconnected\n");
+		dev_dbg(charger->dev, "USB charger is disconnected\n");
 		current_limit = -1;
 	}
 
-- 
2.29.2

