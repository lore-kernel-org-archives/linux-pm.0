Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4D7C433B4
	for <linux-pm@archiver.kernel.org>; Wed, 31 Mar 2021 13:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF5E6052B
	for <linux-pm@archiver.kernel.org>; Wed, 31 Mar 2021 13:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhCaNwU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 31 Mar 2021 09:52:20 -0400
Received: from smtp2.axis.com ([195.60.68.18]:33355 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235763AbhCaNvs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Mar 2021 09:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1617198708;
  x=1648734708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ups7Ah437rpP0+YCCt+5xpcxnMbDUqK2fZsEZLoiGNY=;
  b=R5G8Tv4WADo2MbWH8uml1+wpv8hm7pLAFtJDsCGBY8+uEJ8hERQC6+vv
   byvWAUQXRLSmb1zRMw6atTEXxkJrfMCaLgcQAPT8qRl5cuemIymuj18c9
   1oP3lkMB54tuicvonJpfRRUOK/ne5vrITQPnuM+n02SMX7OsZegUnTwIJ
   W4FShV88PUBsTAOu5H8w4vImtxov2GkdAELL9yvJs3BudWXzDxAiSwky+
   Siw0Cxog4UJaBQ2y3zrUEZBMTCeGF0MT+WNiroL+B5vzbKm8ukrMltXa8
   3UvJPmL87zRYYiHjyxDAkDL451oF9G91ER7x1uplOzuFDtxw0U0/MK048
   A==;
From:   Hermes Zhang <chenhui.zhang@axis.com>
To:     <lars@metafoo.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
CC:     <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] power: supply: bq27xxx: Return the value instead of -ENODATA
Date:   Wed, 31 Mar 2021 21:51:41 +0800
Message-ID: <20210331135141.8063-1-chenhui.zhang@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Hermes Zhang <chenhuiz@axis.com>

It might be better to return value (e.g. 65535) instead of an error
(e.g. No data available) for the time property.

Normally a common function will handle the read string and parse to
integer for all the properties, but will have problem when read the
time property because need to handle the NODATA error as non-error.
So it will make simple for application which indicate success when
read a number, otherwise as an error to handle.

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---
 drivers/power/supply/bq27xxx_battery.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 4c4a7b1c64c5..b75e54aa8ada 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1655,9 +1655,6 @@ static int bq27xxx_battery_read_time(struct bq27xxx_device_info *di, u8 reg)
 		return tval;
 	}
 
-	if (tval == 65535)
-		return -ENODATA;
-
 	return tval * 60;
 }
 
-- 
2.20.1

