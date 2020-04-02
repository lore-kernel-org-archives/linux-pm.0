Return-Path: <SRS0=3neH=5S=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19181C2BA12
	for <linux-pm@archiver.kernel.org>; Thu,  2 Apr 2020 14:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47A22080C
	for <linux-pm@archiver.kernel.org>; Thu,  2 Apr 2020 14:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="LFINZhAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389043AbgDBO6e (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:58:34 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:38650 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388810AbgDBO6c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:32 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5f4N0ZzpX;
        Thu,  2 Apr 2020 16:58:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839510; bh=mKRZQCnghprUjuua4YgNrBV4tEAzgIfaruToSEdSL8Q=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=LFINZhAiLjqUgJM3G8AuCdh6p8gNHhyiDpTZKTo5nwKm2tNUr2q2VUI+IeJpCEOtX
         MtMNFCjEzO5uWYIrRN6eiJoLS/JtuL3o8yD9VJ5J4/Sk39UAdy1p7zwzmuj3rZqORK
         rEHFEQ26x03oy1Yroib7fgpYYZIouoccSIM74JjH6MIoTdcVD9rMzq8p2f7lfqSXCY
         2wHu6Ld5L7EUlmbTPdxu0c0HrLaRIEBRWxiEneWd7QB1gRhCVYAYdGLC5aanroEaol
         rYt+eirrkjdAqheuNIALyf6h61nLphPHh7I6G0euXnzF3+vdhlG/HSL63VKbnG3nzJ
         GA3LHzPkp4d1g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:30 +0200
Message-Id: <d5884e0a056e5b7d71187467b0d1d07a5b2a55f6.1585838678.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 02/14] power: supply: bq25890: simplify chip name property
 getter
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Driver rejects unknown chips early in the probe(), so when
bq25890_power_supply_get_property() is made reachable, bq->chip_version
will already be set to correct value - there is no need to check
it again.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index c642519ef7b2..f9f29edadddc 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -32,6 +32,13 @@ enum bq25890_chip_version {
 	BQ25896,
 };
 
+static const char *const bq25890_chip_name[] = {
+	"BQ25890",
+	"BQ25892",
+	"BQ25895",
+	"BQ25896",
+};
+
 enum bq25890_fields {
 	F_EN_HIZ, F_EN_ILIM, F_IILIM,				     /* Reg00 */
 	F_BHOT, F_BCOLD, F_VINDPM_OFS,				     /* Reg01 */
@@ -400,17 +407,7 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_MODEL_NAME:
-		if (bq->chip_version == BQ25890)
-			val->strval = "BQ25890";
-		else if (bq->chip_version == BQ25892)
-			val->strval = "BQ25892";
-		else if (bq->chip_version == BQ25895)
-			val->strval = "BQ25895";
-		else if (bq->chip_version == BQ25896)
-			val->strval = "BQ25896";
-		else
-			val->strval = "UNKNOWN";
-
+		val->strval = bq25890_chip_name[bq->chip_version];
 		break;
 
 	case POWER_SUPPLY_PROP_ONLINE:
-- 
2.20.1

