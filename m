Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95725C433DB
	for <linux-pm@archiver.kernel.org>; Thu, 18 Feb 2021 19:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C94664EB9
	for <linux-pm@archiver.kernel.org>; Thu, 18 Feb 2021 19:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhBRTMG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhBRST0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 13:19:26 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BF4C061574
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 10:18:45 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.93.0.4)
        (envelope-from <daniel@makrotopia.org>)
        id 1lCnsx-0001HI-Rw; Thu, 18 Feb 2021 19:18:44 +0100
Date:   Thu, 18 Feb 2021 18:18:36 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel =?iso-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH] power: reset: replace curly brackets in Makefile
Message-ID: <YC6vfCWycDwbz5Sf@makrotopia.org>
References: <CABwr4_sfV_sRexcpBsGZw2UJf4cGRCFrNsNnmffvYHGknP2XMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABwr4_sfV_sRexcpBsGZw2UJf4cGRCFrNsNnmffvYHGknP2XMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Normal parentheses should be used when referring to config variables
in Makefile. Replace the accidentally introduced curly brackets by
regular parentheses.

Fixes: a7f79f99541ef ("power: reset: add driver for LinkStation power off")
Acked-by: Daniel González Cabanelas <dgcbueu@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/power/reset/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 4f959b6976066..cf3f4d02d8a54 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) += gemini-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
-obj-${CONFIG_POWER_RESET_LINKSTATION} += linkstation-poweroff.o
+obj-$(CONFIG_POWER_RESET_LINKSTATION) += linkstation-poweroff.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_MT6323) += mt6323-poweroff.o
 obj-$(CONFIG_POWER_RESET_OXNAS) += oxnas-restart.o
-- 
2.30.0

