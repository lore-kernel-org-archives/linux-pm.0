Return-Path: <SRS0=3neH=5S=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C224CC2BA17
	for <linux-pm@archiver.kernel.org>; Thu,  2 Apr 2020 14:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF1520784
	for <linux-pm@archiver.kernel.org>; Thu,  2 Apr 2020 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="rmFm6V7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbgDBO6g (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:58:36 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:36003 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389042AbgDBO6g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:36 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5j53x1zHd;
        Thu,  2 Apr 2020 16:58:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839513; bh=j/RXM+fNBpI5abZHjWXnC0UL+wj8lzgTO3a3XRS4VRU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=rmFm6V7voMtzUHDPx3PWN0+P4CziTICw6Z7LysscEHLrdiP7/ecGP58nkJ/5c2RSm
         cvp9U/v4FK3s0UmhzE91eNGmraL97/NOqfM/34/ZOeICAa1dJxTjTBL68nnCynORK2
         MlnKexcT2l5bNmNZa2VyO7xvIPjqHgK7BJ9NRBBpjZ24EG+EqsKHvO4RpBppEHGSZ3
         FcvugbBbO9UeW7+x3PfsBWSust7bIWhhoswfY//j+NqLOECLIr4ttvSe6BoWWkj2QU
         8OeCJk+N8YTkbMDFqMsjnnS7qtol6RKsPur9RUqv8Cpa8n0xNM4pEThTFPxTqnPL+T
         4LaCur2WhwNPQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:33 +0200
Message-Id: <42a64bb02651d731de1a88d382eec9ca61885994.1585838679.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 08/14] power: supply: bq25890: implement PRECHARGE_CURRENT
 property
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Report configured precharge current.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index ad0901fdceb6..b48685009048 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -497,6 +497,10 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
 		break;
 
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		val->intval = bq25890_find_val(bq->init_data.iprechg, TBL_ITERM);
+		break;
+
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		val->intval = bq25890_find_val(bq->init_data.iterm, TBL_ITERM);
 		break;
@@ -689,6 +693,7 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 };
-- 
2.20.1

