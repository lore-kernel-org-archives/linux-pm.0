Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14A9C5519F
	for <linux-pm@archiver.kernel.org>; Wed, 25 Nov 2020 04:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611A3208B8
	for <linux-pm@archiver.kernel.org>; Wed, 25 Nov 2020 04:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgKYErJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 24 Nov 2020 23:47:09 -0500
Received: from comms.puri.sm ([159.203.221.185]:48106 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgKYErJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 23:47:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 3FDC3E0399;
        Tue, 24 Nov 2020 20:47:09 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oYTaweB7_C_3; Tue, 24 Nov 2020 20:47:08 -0800 (PST)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Geordan Neukum <gneukum1@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Subject: [PATCH 3/4] power: max17042_battery: Take r_sns value into account in charge_counter
Date:   Wed, 25 Nov 2020 05:47:04 +0100
Message-ID: <146027451.poJRWWCWiI@pliszka>
In-Reply-To: <2264396.HPVdm0XNkV@pliszka>
References: <2264396.HPVdm0XNkV@pliszka>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The default r_sns value was hardcoded there, so let's change it to the
actually configured one.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/power/supply/max17042_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 86adccb0f32d..26f6f89eb648 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -354,7 +354,8 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		val->intval = data * 1000 / 2;
+		data64 = sign_extend64(data, 15) * 5000000ll;
+		val->intval = div_s64(data64, chip->pdata->r_sns);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
 		ret = max17042_get_temperature(chip, &val->intval);
-- 
2.29.2



