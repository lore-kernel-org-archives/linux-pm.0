Return-Path: <SRS0=dFIf=ZA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF79FC6194
	for <linux-pm@archiver.kernel.org>; Fri,  8 Nov 2019 11:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A940207FA
	for <linux-pm@archiver.kernel.org>; Fri,  8 Nov 2019 11:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214182;
	bh=W1/lV2XXwhI/fw03aQUefAxM/mttitnn52A6z2VdHYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1+kDbAuMg8PFXfHGNGZ8wZGAWDegXioF81cW4Cc4WdaFUs2kJL3/vwJdv3oDn6BQf
	 hyrNZixVzy+mm78W3PU4QOs66cMKxh8VPmXRX2zEwoXO5yGykany/TqKNOhvpV3qyS
	 SnCDSkxkbw5qSOgrPgfBAwJBownndMXEOHLJhBA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390055AbfKHL4V (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:56:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:32780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391139AbfKHLpf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Nov 2019 06:45:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A334E2245A;
        Fri,  8 Nov 2019 11:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213534;
        bh=W1/lV2XXwhI/fw03aQUefAxM/mttitnn52A6z2VdHYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXtRpyDJH8Gan9ZE7OYXjisbY+Xv8MezrcHWPlfovh318yWTzo6SkTRdSNp0ZWB1R
         1y4s7q8KPBAPLzHsfkYeuNULaDgKviQTamzNb1kksQT4aCPwMVBE4cstsPh/2lBYK5
         RoXkwL3FRTOTtikLgHCPLL+DlNM4r4nosiE/dods=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 097/103] power: supply: max8998-charger: Fix platform data retrieval
Date:   Fri,  8 Nov 2019 06:43:02 -0500
Message-Id: <20191108114310.14363-97-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

[ Upstream commit cb90a2c6f77fe9b43d1e3f759bb2f13fe7fa1811 ]

Since the max8998 MFD driver supports instantiation by DT, platform data
retrieval is handled in MFD probe and cell drivers should get use
the pdata field of max8998_dev struct to obtain them.

Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/max8998_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max8998_charger.c b/drivers/power/supply/max8998_charger.c
index b64cf0f141425..66438029bdd0c 100644
--- a/drivers/power/supply/max8998_charger.c
+++ b/drivers/power/supply/max8998_charger.c
@@ -85,7 +85,7 @@ static const struct power_supply_desc max8998_battery_desc = {
 static int max8998_battery_probe(struct platform_device *pdev)
 {
 	struct max8998_dev *iodev = dev_get_drvdata(pdev->dev.parent);
-	struct max8998_platform_data *pdata = dev_get_platdata(iodev->dev);
+	struct max8998_platform_data *pdata = iodev->pdata;
 	struct power_supply_config psy_cfg = {};
 	struct max8998_battery_data *max8998;
 	struct i2c_client *i2c;
-- 
2.20.1

