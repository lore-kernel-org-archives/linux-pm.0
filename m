Return-Path: <SRS0=u7FU=ZC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D3CC43331
	for <linux-pm@archiver.kernel.org>; Sun, 10 Nov 2019 03:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F9A20854
	for <linux-pm@archiver.kernel.org>; Sun, 10 Nov 2019 03:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355767;
	bh=GoZOEk//ETXD6J0deAkiRjiiaR686w21jUnxlJ4hgm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zqwJnzOKijtNVtz7b7GR6+XWFh6OuHXHdnVxCP5cpexDR+LwWBxDcWvjWpCSbMufB
	 ErsSw3AXLhfM7n9KcZ/6uyCBfxhy6J7xyL+03RcLR7q8lGbgPSE4pHc/aZKpmQsKze
	 ytIHU+o63u3LTO9pJrtYxFNENdzT4DjVEn9nH7kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfKJDQC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:16:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbfKJClM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 9 Nov 2019 21:41:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0665214E0;
        Sun, 10 Nov 2019 02:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353671;
        bh=GoZOEk//ETXD6J0deAkiRjiiaR686w21jUnxlJ4hgm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7eDStHjzLyjDo4vuRohZ677i6qe6xsDPlEVMfOZ/v6aPkLYGldPCQefUm5Ab+OlI
         ybDXQsao4eQBn7aNrp4tomUYWCwr4GuHMDQ3weB4BfLEYWzHUoqXX31zyPyPbkNdI2
         fZiAl/1v8BzingDCvAgfCeF75dVHDEdF7MJrN/WU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 037/191] power: supply: twl4030_charger: fix charging current out-of-bounds
Date:   Sat,  9 Nov 2019 21:37:39 -0500
Message-Id: <20191110024013.29782-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Andreas Kemnade <andreas@kemnade.info>

[ Upstream commit 8314c212f995bc0d06b54ad02ef0ab4089781540 ]

the charging current uses unsigned int variables, if we step back
if the current is still low, we would run into negative which
means setting the target to a huge value.
Better add checks here.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/twl4030_charger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index b6a7d9f74cf30..adcaa0a10a6f4 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -420,7 +420,8 @@ static void twl4030_current_worker(struct work_struct *data)
 
 	if (v < USB_MIN_VOLT) {
 		/* Back up and stop adjusting. */
-		bci->usb_cur -= USB_CUR_STEP;
+		if (bci->usb_cur >= USB_CUR_STEP)
+			bci->usb_cur -= USB_CUR_STEP;
 		bci->usb_cur_target = bci->usb_cur;
 	} else if (bci->usb_cur >= bci->usb_cur_target ||
 		   bci->usb_cur + USB_CUR_STEP > USB_MAX_CURRENT) {
-- 
2.20.1

