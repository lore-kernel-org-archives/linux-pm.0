Return-Path: <SRS0=3neH=5S=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5F6C43331
	for <linux-pm@archiver.kernel.org>; Thu,  2 Apr 2020 14:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A5320784
	for <linux-pm@archiver.kernel.org>; Thu,  2 Apr 2020 14:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="fD/KixoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388923AbgDBO6b (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:58:31 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:30174 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388782AbgDBO6b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:31 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5f2JwnzHd;
        Thu,  2 Apr 2020 16:58:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839510; bh=9+54rd/b9MFSvGJ5H7aKdvK4EyDceTpr1Ul1xvO7tH8=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=fD/KixoETC6wnb4NjFzbS6rBcLYkFUzKnwIkEyAe6Em1zr5q5CVSS+omMZrenu4wB
         9gImfXsp7eBG31v9jil0QotWAGe4jOqX4osO83JizCqVi+rFrkMkUxVOvTTIYgdCQy
         vbtF/wb8veaKNQLTItLia9uJ6p1sg3dyAgr7+TUV/9e9g3kDnglnbRhBybLMjBcRQI
         RJggPu9dwNVAHpFANsoNVnmBA+qw3eCLxgpxsDAS+MHAGyQCO5zjEkkoDRXWqO0DlF
         gYv6pCw1Ph0Tq5JkOmvWoCESQTr0TV3B0JQLYPVMn/TY6SidF96tSsoqtdA52Ba/vL
         C1Lv2PNRjZCHA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:30 +0200
Message-Id: <6a0db93bd3345ed634f489e93526f3317fbefe31.1585838678.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 01/14] power: supply: bq25890: remove redundant I2C bus check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

regmap initialization will check I2C adapter functionality.
Remove redundant check in the driver.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index aebd1253dbc9..c642519ef7b2 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -881,17 +881,11 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 static int bq25890_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	struct i2c_adapter *adapter = client->adapter;
 	struct device *dev = &client->dev;
 	struct bq25890_device *bq;
 	int ret;
 	int i;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
-		dev_err(dev, "No support for SMBUS_BYTE_DATA\n");
-		return -ENODEV;
-	}
-
 	bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
 	if (!bq)
 		return -ENOMEM;
-- 
2.20.1

