Return-Path: <SRS0=yWkS=5L=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937CCC2D0E5
	for <linux-pm@archiver.kernel.org>; Thu, 26 Mar 2020 21:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C44220848
	for <linux-pm@archiver.kernel.org>; Thu, 26 Mar 2020 21:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgCZVJ5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:09:57 -0400
Received: from sauhun.de ([88.99.104.3]:54372 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgCZVJ5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 17:09:57 -0400
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
        by pokefinder.org (Postfix) with ESMTPSA id 1DC892C1F8B;
        Thu, 26 Mar 2020 22:09:55 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] power: supply: bq24190_charger: convert to use i2c_new_client_device()
Date:   Thu, 26 Mar 2020 22:09:54 +0100
Message-Id: <20200326210954.12931-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326210954.12931-1-wsa+renesas@sang-engineering.com>
References: <20200326210954.12931-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move away from the deprecated API in this comment.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/power/supply/bq24190_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 453d6332d43a..4540e913057f 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -673,7 +673,7 @@ static int bq24190_register_reset(struct bq24190_dev_info *bdi)
 	 *   { .type = "bq24190", .addr = 0x6b, .properties = pe, .irq = irq };
 	 * struct i2c_adapter ad = { ... };
 	 * i2c_add_adapter(&ad);
-	 * i2c_new_device(&ad, &bi);
+	 * i2c_new_client_device(&ad, &bi);
 	 */
 	if (device_property_read_bool(bdi->dev, "disable-reset"))
 		return 0;
-- 
2.20.1

