Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA4EC433F5
	for <linux-pm@archiver.kernel.org>; Sun, 12 Sep 2021 20:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47AB161052
	for <linux-pm@archiver.kernel.org>; Sun, 12 Sep 2021 20:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhILUzt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 12 Sep 2021 16:55:49 -0400
Received: from comms.puri.sm ([159.203.221.185]:32798 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236373AbhILUzs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Sep 2021 16:55:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id BC49CE030C;
        Sun, 12 Sep 2021 13:54:33 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2HDY2MG3q67W; Sun, 12 Sep 2021 13:54:33 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        Ramakrishna Pallala <ramakrishna.pallala@intel.com>,
        Dirk Brandewie <dirk.brandewie@gmail.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] power: supply: max17042_battery: Prevent int underflow in set_soc_threshold
Date:   Sun, 12 Sep 2021 22:54:02 +0200
Message-Id: <20210912205402.160939-2-sebastian.krzyszkowiak@puri.sm>
In-Reply-To: <20210912205402.160939-1-sebastian.krzyszkowiak@puri.sm>
References: <20210912205402.160939-1-sebastian.krzyszkowiak@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes: e5f3872d2044 ("max17042: Add support for signalling change in SOC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/power/supply/max17042_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index c53980c8432a..caf83b4d622f 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -857,7 +857,8 @@ static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 off)
 	regmap_read(map, MAX17042_RepSOC, &soc);
 	soc >>= 8;
 	soc_tr = (soc + off) << 8;
-	soc_tr |= (soc - off);
+	if (off < soc)
+		soc_tr |= soc - off;
 	regmap_write(map, MAX17042_SALRT_Th, soc_tr);
 }
 
-- 
2.33.0

