Return-Path: <SRS0=vmax=7H=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18FFC433E0
	for <linux-pm@archiver.kernel.org>; Mon, 25 May 2020 11:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8579207FB
	for <linux-pm@archiver.kernel.org>; Mon, 25 May 2020 11:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590406348;
	bh=wiKO9ZZ2xlGA++fntc5tHue7H7VM7k0ZGV0z0X7E/BE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=G92FGWMQKdgnMgAnEWL3hoqVv/J+HAgJfRrtbAXBZ3Gdv2L/tKHVlHzR0+r3NZMc2
	 lhggqLruugPL005e+pGUAg31w6JTLgMvmPaJ7ZpHtZYxQIP2xUXzB6y2YSxGeM/xhp
	 JWmcSEr4/qRBs+LGGcdRWa7Jer1XbofHfWb+nBho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390137AbgEYLc2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 25 May 2020 07:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388733AbgEYLc1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 May 2020 07:32:27 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D195F20787;
        Mon, 25 May 2020 11:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590406346;
        bh=wiKO9ZZ2xlGA++fntc5tHue7H7VM7k0ZGV0z0X7E/BE=;
        h=From:To:Cc:Subject:Date:From;
        b=bjbxUQ+9O7AIW3rZSJ2V/MYQ7lfowjf+b01Pg8o9Y7sbrMjFunOJQ+kqyed9Ow3yB
         0SW7Ws7esp2tIDjPUJpY7byOGS64erfIYdee/cphuPChMCnSUZLSFY/BUicdS6b6cW
         kfWopQodjT0h1otwWiKfY5hReiFK21iA4NaUhk1w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        Anton Vorontsov <cbouatmailru@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
Subject: [RFC] power: supply: bq27xxx_battery: Fix polling interval after re-bind
Date:   Mon, 25 May 2020 13:32:19 +0200
Message-Id: <20200525113220.369-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit 8cfaaa811894a3ae2d7360a15a6cfccff3ebc7db.

If device was unbound and bound, the polling interval would be set to 0.
This is both unexpected and messes up with other bq27xxx devices (if
more than one battery device is used).

This reset of polling interval was added in commit 8cfaaa811894
("bq27x00_battery: Fix OOPS caused by unregistring bq27x00 driver")
stating that power_supply_unregister() calls get_property().  However in
Linux kernel v3.1 and newer, such call trace does not exist.
Unregistering power supply does not call get_property() on unregistered
power supply.

Fixes: 8cfaaa811894 ("bq27x00_battery: Fix OOPS caused by unregistring bq27x00 driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

I really could not identify the issue being fixed in offending commit
8cfaaa811894 ("bq27x00_battery: Fix OOPS caused by unregistring bq27x00
driver"), therefore maybe I missed here something important.

Please share your thoughts on this.
---
 drivers/power/supply/bq27xxx_battery.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 942c92127b6d..4c94ee72de95 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1905,14 +1905,6 @@ EXPORT_SYMBOL_GPL(bq27xxx_battery_setup);
 
 void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 {
-	/*
-	 * power_supply_unregister call bq27xxx_battery_get_property which
-	 * call bq27xxx_battery_poll.
-	 * Make sure that bq27xxx_battery_poll will not call
-	 * schedule_delayed_work again after unregister (which cause OOPS).
-	 */
-	poll_interval = 0;
-
 	cancel_delayed_work_sync(&di->work);
 
 	power_supply_unregister(di->bat);
-- 
2.17.1

