Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFE5C433DB
	for <linux-pm@archiver.kernel.org>; Tue,  9 Mar 2021 18:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C90652BE
	for <linux-pm@archiver.kernel.org>; Tue,  9 Mar 2021 18:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhCISEm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Mar 2021 13:04:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35236 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhCISEQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 13:04:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 028A21F457FD
Received: by jupiter.universe (Postfix, from userid 1000)
        id AFDBB4800C7; Tue,  9 Mar 2021 19:04:12 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 2/7] power: supply: sbs-charger: use dev_err_probe
Date:   Tue,  9 Mar 2021 19:04:02 +0100
Message-Id: <20210309180407.650943-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309180407.650943-1-sebastian.reichel@collabora.com>
References: <20210309180407.650943-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce usage of dev_err_probe in probe routine, which
makes the code slightly more readable and removes some
lines of code. It also removes PROBE_DEFER errors being
logged by default.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-charger.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index fbfb6a620961..36a048d687e0 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -189,18 +189,14 @@ static int sbs_probe(struct i2c_client *client,
 	 * to the battery.
 	 */
 	ret = regmap_read(chip->regmap, SBS_CHARGER_REG_STATUS, &val);
-	if (ret) {
-		dev_err(&client->dev, "Failed to get device status\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to get device status\n");
 	chip->last_state = val;
 
-	chip->power_supply = devm_power_supply_register(&client->dev, &sbs_desc,
-							&psy_cfg);
-	if (IS_ERR(chip->power_supply)) {
-		dev_err(&client->dev, "Failed to register power supply\n");
-		return PTR_ERR(chip->power_supply);
-	}
+	chip->power_supply = devm_power_supply_register(&client->dev, &sbs_desc, &psy_cfg);
+	if (IS_ERR(chip->power_supply))
+		return dev_err_probe(&client->dev, PTR_ERR(chip->power_supply),
+				     "Failed to register power supply\n");
 
 	/*
 	 * The sbs-charger spec doesn't impose the use of an interrupt. So in
@@ -212,10 +208,8 @@ static int sbs_probe(struct i2c_client *client,
 					NULL, sbs_irq_thread,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					dev_name(&client->dev), chip);
-		if (ret) {
-			dev_err(&client->dev, "Failed to request irq, %d\n", ret);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(&client->dev, ret, "Failed to request irq\n");
 	} else {
 		INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
 		schedule_delayed_work(&chip->work,
-- 
2.30.1

