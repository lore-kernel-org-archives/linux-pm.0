Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938C8C77B62
	for <linux-pm@archiver.kernel.org>; Fri, 17 Mar 2023 22:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjCQW5S (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 17 Mar 2023 18:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjCQW5P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2023 18:57:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6532D146;
        Fri, 17 Mar 2023 15:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4CA460C6B;
        Fri, 17 Mar 2023 22:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F104C433EF;
        Fri, 17 Mar 2023 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679093833;
        bh=yPzVoyb/Gfy3GbgXbS/xEPN0qDCVRKIVaWj3y97xOno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WdE73w50sNZk20kUQgGtgZ4h0UrPZstvUS4wpCqZ9mkwvcd1IND5KzB1o91k0mROu
         Acdn7L7C56PhUyOKBjRZrhy7KRmQAnzkoI1qHtD3A/SfToxq/VOImV9rj9h6bPNFN5
         eKzlOYmor7Bkwfo7PQgA3kG/AB+sn2JcccqouUa95B/MhG4oRnNoTyu7qUlSLTrmUq
         bzqmpCo7XMajYypTsl7igx2ZtWBa514Yib858dUWAcYB7XKntPgImIQug+0vi/+cz+
         Y8JpEegTuPsJi5HwArn+xzZc2J7fgBQyNzprJgyhIeaFXbtaaD0yBFo73ZAPSzOKo1
         t6H+XNqYHIXcQ==
Received: by mercury (Postfix, from userid 1000)
        id 9149A1062108; Fri, 17 Mar 2023 23:57:08 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv3 07/14] power: supply: generic-adc-battery: drop memory alloc error message
Date:   Fri, 17 Mar 2023 23:57:00 +0100
Message-Id: <20230317225707.1552512-8-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317225707.1552512-1-sre@kernel.org>
References: <20230317225707.1552512-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Error printing happens automatically for memory allocation problems.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index d07eeb7d46d3..771e5cfc49c3 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -243,10 +243,8 @@ static int gab_probe(struct platform_device *pdev)
 	bool any = false;
 
 	adc_bat = devm_kzalloc(&pdev->dev, sizeof(*adc_bat), GFP_KERNEL);
-	if (!adc_bat) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
+	if (!adc_bat)
 		return -ENOMEM;
-	}
 
 	psy_cfg.drv_data = adc_bat;
 	psy_desc = &adc_bat->psy_desc;
-- 
2.39.2

