Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA288C11F66
	for <linux-pm@archiver.kernel.org>; Sat, 10 Jul 2021 23:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9622B61057
	for <linux-pm@archiver.kernel.org>; Sat, 10 Jul 2021 23:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhGJX6j (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 10 Jul 2021 19:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234287AbhGJX5k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 10 Jul 2021 19:57:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31F0761057;
        Sat, 10 Jul 2021 23:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625961163;
        bh=H0q5fP5antJ6Djnomh+4kNBF4JKiQHOWmcYbDVwLxko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXZjGrliqoBWpT6RAwrs/lM5HWzw22IZKwldMPeP0rrmaeglXmxtL2LE4YRoKtgTV
         IVYy0ppbZS98842rh6GWhdLWaxf9dPaj7rX/PzMU7I20d0ICS5evPfUUBTsu76myb6
         sxhx4ntMM1jDd1EfYg+G8WP2LjI04gMDFbclb9TDQXN8GbcNxMapkZunoiaeGC0cBW
         X0+mx2rcCWW8EvaEVClk+J7ul40foy3GSTm18gegH42KkrV+/VfFb0DM/bEavCAS/p
         Lec/1U7nluH/bkx/ew630hWNnTrbVvQ7nrKXCaG4GYhFH7RA7kU17b9MBodqKQHYpf
         Eb47ggK/7tvxg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 02/16] power: supply: ab8500: Avoid NULL pointers
Date:   Sat, 10 Jul 2021 19:52:26 -0400
Message-Id: <20210710235240.3222618-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710235240.3222618-1-sashal@kernel.org>
References: <20210710235240.3222618-1-sashal@kernel.org>
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
index 48a11fd86a7f..2d44a68b62c0 100644
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

