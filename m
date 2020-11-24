Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03088C71156
	for <linux-pm@archiver.kernel.org>; Tue, 24 Nov 2020 09:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AACE2073C
	for <linux-pm@archiver.kernel.org>; Tue, 24 Nov 2020 09:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O1C0lQ4r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hq/yhBM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbgKXJgq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 24 Nov 2020 04:36:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42038 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbgKXJgm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:42 -0500
Date:   Tue, 24 Nov 2020 09:36:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewiKiMcrdTvyZ5/HQ5/b5yq3yLlfTNI6mECMdlN1YHs=;
        b=O1C0lQ4reEsXmIJRqUlD1qD2wSYsOWDU1FU7nc5VePjcAg+fSl9bH6Rie0hEh9JLi88bFz
        HDUrvAeo3qNFOrmjpzn6cefKKffaApXMi3SnjrZppJROD0Cswh1jXgQzrUIoBqNIcMk7rG
        270FdQkH9A6JPe3HeUUNdayKVzFevpfquQmiLF/G6MfBBprI93yhupL8mvSON0wCUtxYSW
        ye7h6Itnd5YcghBBJ+3U9Zau/H47o75vlWY8zfBdMvtlZ0mxiGKg95BS7ADQVOmhYadfH2
        YBuEybs25xkHtqGp68ulaJ51MWj2D41AJst0vcPpKEGCesr7IQMiVZmoBhoNtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewiKiMcrdTvyZ5/HQ5/b5yq3yLlfTNI6mECMdlN1YHs=;
        b=Hq/yhBM/nIAN8WscyKvUPu74dDnUxjPy4PrjjgTzqqS74/L8qCTcl7NlUxyNYr3oHR1+tn
        AiLG5Fnv4nnF6eAg==
From:   "thermal-bot for Fabien Parent" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: mtk_thermal: make device_reset optional
Cc:     Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201021164231.3029956-3-fparent@baylibre.com>
References: <20201021164231.3029956-3-fparent@baylibre.com>
MIME-Version: 1.0
Message-ID: <160621059996.11115.2799274172961327015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     703456ba76e9449b5ade6597c04a90ee3421cd94
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//703456ba76e9449b5ade6597c04a90ee3421cd94
Author:        Fabien Parent <fparent@baylibre.com>
AuthorDate:    Wed, 21 Oct 2020 18:42:31 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Oct 2020 11:19:18 +01:00

thermal: mtk_thermal: make device_reset optional

MT8516 does not support thermal reset. Use device_reset_optional
instead of device_reset.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201021164231.3029956-3-fparent@baylibre.com
---
 drivers/thermal/mtk_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 0bd7aa5..149c6d7 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -1052,7 +1052,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = device_reset(&pdev->dev);
+	ret = device_reset_optional(&pdev->dev);
 	if (ret)
 		return ret;
 
