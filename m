Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F81BC7EE31
	for <linux-pm@archiver.kernel.org>; Wed, 31 May 2023 13:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbjEaNsr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 31 May 2023 09:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbjEaNsV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2023 09:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9172686;
        Wed, 31 May 2023 06:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6C5863B1B;
        Wed, 31 May 2023 13:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52221C433D2;
        Wed, 31 May 2023 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540603;
        bh=ll0vE8kIeS0vOprbv+35WOxuWa6YWtWpGEHFAHrLAfk=;
        h=From:To:Cc:Subject:Date:From;
        b=N8Qmne9wdYwZzjKAc4HbmvdKaGhhnSpNUrRNy0MoGf9wcOPeUGjE31fqaL79Q7ugK
         8pbhyFfBInKD4iKOKRzO8wdSHXKHfnTOc7Wo2cxQVARSPYa4HPfJ343M+8jF30DR/E
         yeUsn3y8iRVDFPU3Z/BtzM0t4Bjf0+cWrG+RGem4BRk6Ruv1FFZ8AWd8QcpyEcw3DV
         +rS0Ia6K03+cE/2ZrQJOOt81a0qgduJR+Q2RhRbWKl0Lj0Tatjgs7+qrC1UdyUfBmt
         2AaIotpoV47INGdhMYCwVBCalNik2KSBlp7YjjA43pm0EKRNu54NqCAt4lUMilIYBk
         5GoY86TCKnb+g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 01/24] power: supply: ab8500: Fix external_power_changed race
Date:   Wed, 31 May 2023 09:42:57 -0400
Message-Id: <20230531134320.3384102-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit a5299ce4e96f3e8930e9c051b28d8093ada87b08 ]

ab8500_btemp_external_power_changed() dereferences di->btemp_psy,
which gets sets in ab8500_btemp_probe() like this:

        di->btemp_psy = devm_power_supply_register(dev, &ab8500_btemp_desc,
                                                   &psy_cfg);

As soon as devm_power_supply_register() has called device_add()
the external_power_changed callback can get called. So there is a window
where ab8500_btemp_external_power_changed() may get called while
di->btemp_psy has not been set yet leading to a NULL pointer dereference.

Fixing this is easy. The external_power_changed callback gets passed
the power_supply which will eventually get stored in di->btemp_psy,
so ab8500_btemp_external_power_changed() can simply directly use
the passed in psy argument which is always valid.

And the same applies to ab8500_fg_external_power_changed().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ab8500_btemp.c | 6 ++----
 drivers/power/supply/ab8500_fg.c    | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index b6c9111d77d7d..896309d3cadfe 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -902,10 +902,8 @@ static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
  */
 static void ab8500_btemp_external_power_changed(struct power_supply *psy)
 {
-	struct ab8500_btemp *di = power_supply_get_drvdata(psy);
-
-	class_for_each_device(power_supply_class, NULL,
-		di->btemp_psy, ab8500_btemp_get_ext_psy_data);
+	class_for_each_device(power_supply_class, NULL, psy,
+			      ab8500_btemp_get_ext_psy_data);
 }
 
 /* ab8500 btemp driver interrupts and their respective isr */
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 57799a8079d44..eb7eac23da70f 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2384,10 +2384,8 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
  */
 static void ab8500_fg_external_power_changed(struct power_supply *psy)
 {
-	struct ab8500_fg *di = power_supply_get_drvdata(psy);
-
-	class_for_each_device(power_supply_class, NULL,
-		di->fg_psy, ab8500_fg_get_ext_psy_data);
+	class_for_each_device(power_supply_class, NULL, psy,
+			      ab8500_fg_get_ext_psy_data);
 }
 
 /**
-- 
2.39.2

