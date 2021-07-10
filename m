Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E29C11F66
	for <linux-pm@archiver.kernel.org>; Sat, 10 Jul 2021 23:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA017611B0
	for <linux-pm@archiver.kernel.org>; Sat, 10 Jul 2021 23:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhGJX5k (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 10 Jul 2021 19:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhGJX4V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 10 Jul 2021 19:56:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4842C61404;
        Sat, 10 Jul 2021 23:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625961135;
        bh=GgCao4b7Q6g8zIdR9C76BmzdK9glO3ae6YFNE1zqA3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FBSLR01TCtZLPl4Pbf75Yqpxnq04J4H38wbdizLVXYRw1AvuRB24hzRl1NSHd0J30
         F3gBnbWBMnf7s15BM3BeEsGQqUH2zZy3JY27Bmsu0Gec2vb0iYTvsUrWrpePJFkRan
         LbdVJvZ1Ojlu5o9dhiR08yzzu7K/pUCpn4KhNHbl2atIivp3XRtt/A9zeEhCsPEtJG
         oF7Vbws8OFfloE75XD+FohqGpWAWxoIqYsCa/ee+pRWxAe6ujwRCxnj2Mpm5BA8ZFX
         xqFqAcNWDkkGyaNUnxwZCdsU9BereWmsEwJd62WeMTKesHoHJtlQSTl6ZVPvQP18J5
         gxoQd/8+G7n8Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 02/21] power: supply: ab8500: Avoid NULL pointers
Date:   Sat, 10 Jul 2021 19:51:53 -0400
Message-Id: <20210710235212.3222375-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710235212.3222375-1-sashal@kernel.org>
References: <20210710235212.3222375-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 5bcb5087c9dd3dca1ff0ebd8002c5313c9332b56 ]

Sometimes the code will crash because we haven't enabled
AC or USB charging and thus not created the corresponding
psy device. Fix it by checking that it is there before
notifying.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ab8500_charger.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 5a76c6d343de..8e74d27fad29 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -409,6 +409,14 @@ static void ab8500_enable_disable_sw_fallback(struct ab8500_charger *di,
 static void ab8500_power_supply_changed(struct ab8500_charger *di,
 					struct power_supply *psy)
 {
+	/*
+	 * This happens if we get notifications or interrupts and
+	 * the platform has been configured not to support one or
+	 * other type of charging.
+	 */
+	if (!psy)
+		return;
+
 	if (di->autopower_cfg) {
 		if (!di->usb.charger_connected &&
 		    !di->ac.charger_connected &&
@@ -435,7 +443,15 @@ static void ab8500_charger_set_usb_connected(struct ab8500_charger *di,
 		if (!connected)
 			di->flags.vbus_drop_end = false;
 
-		sysfs_notify(&di->usb_chg.psy->dev.kobj, NULL, "present");
+		/*
+		 * Sometimes the platform is configured not to support
+		 * USB charging and no psy has been created, but we still
+		 * will get these notifications.
+		 */
+		if (di->usb_chg.psy) {
+			sysfs_notify(&di->usb_chg.psy->dev.kobj, NULL,
+				     "present");
+		}
 
 		if (connected) {
 			mutex_lock(&di->charger_attached_mutex);
-- 
2.30.2

