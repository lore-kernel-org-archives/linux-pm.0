Return-Path: <SRS0=+XkI=CE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D83C433DF
	for <linux-pm@archiver.kernel.org>; Wed, 26 Aug 2020 14:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE962177B
	for <linux-pm@archiver.kernel.org>; Wed, 26 Aug 2020 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453505;
	bh=LycaQSGaloOUqvEORm0xKf+LaE0nPIKIca2wfiCCu2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KDb2sMX3x3TtdW90uZFPk9ifW+u0xACDBG6dyuESOAGOu9+eiOn5qP3z88ZnyRQgn
	 R/lh/z3o29V+4B8Fpck1l8jqDcMbFbT1cDlaqx+ASHUqd0eQX8pRfh+sWYp9JKg0f2
	 QKIKMlS/d7h9E8r9GmtWRIi7xuLK7LjVeVOYhbKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgHZOvo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgHZOtM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 10:49:12 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0A472224D;
        Wed, 26 Aug 2020 14:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453351;
        bh=LycaQSGaloOUqvEORm0xKf+LaE0nPIKIca2wfiCCu2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEWutV3QgsELRIb1JG7lDvt1V2ou2zvlvgwt6fOHgqDX/T7635Gxk8f0n2lT6xszX
         EZBojci3kovJQEqGcd8PcmnzW6y1EH2Pe5d6II5Ka0twadJoxWplHp7mkUOAwka1sV
         JjWC7b6ChUYJ23fpW/iQ46SWgm94nYNk3dzBwW/M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        David Lechner <david@lechnology.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/5] power: supply: gpio-charger: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:48:56 +0200
Message-Id: <20200826144858.9584-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826144858.9584-1-krzk@kernel.org>
References: <20200826144858.9584-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/gpio-charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 875735d50716..557f879a6499 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -173,10 +173,8 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		gpio_charger->gpiod = gpio_to_desc(pdata->gpio);
 	} else if (IS_ERR(gpio_charger->gpiod)) {
 		/* Just try again if this happens */
-		if (PTR_ERR(gpio_charger->gpiod) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		dev_err(dev, "error getting GPIO descriptor\n");
-		return PTR_ERR(gpio_charger->gpiod);
+		return dev_err_probe(dev, PTR_ERR(gpio_charger->gpiod),
+				     "error getting GPIO descriptor\n");
 	}
 
 	if (gpio_charger->gpiod) {
-- 
2.17.1

