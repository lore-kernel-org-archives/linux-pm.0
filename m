Return-Path: <SRS0=Wbju=TJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52148C04AB1
	for <linux-pm@archiver.kernel.org>; Thu,  9 May 2019 12:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCFA2173C
	for <linux-pm@archiver.kernel.org>; Thu,  9 May 2019 12:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="G9wQb2v5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfEIMbN (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 9 May 2019 08:31:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40343 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEIMbN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 08:31:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so1151859pgl.7
        for <linux-pm@vger.kernel.org>; Thu, 09 May 2019 05:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bX9fynWNx2rR1u6KZJt+Xl0Rl1d3gCgoD8/fabCDdY=;
        b=G9wQb2v5qZHTDZxakpQfPY6NRoW9Fd9LrSk7visuguj9rz2qA2wYh05F/MqSVEOS83
         qdgvkqJ6fvRrESETA8qwSF7zCtiomXboyHiAoDZnOKew9z9jMU4E1ZXdrfj6pKjlXtnW
         0/nKNCOIPSBA4PYrvHuxwnlWentEmhI0gcAmFUo3ipvJFzWrX25PQP3chdPfixOyo2FC
         fGlFjETsuLlS8fvNKjxzlXfO4clKs/zcvBl8ErfYNYLhlOlH2CxYtShw4IGWqTP51yMD
         kOs387vtA7nJDsRsOTUmnE2Qt1GyM9mZuFYIqgdGcBPDrA4FugBFyqPPsMukVwNtozuk
         l2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bX9fynWNx2rR1u6KZJt+Xl0Rl1d3gCgoD8/fabCDdY=;
        b=Oe3El8ynjTnZtP0wqyBM1KBBUczy5Z9wjZ/28KXDNrHIWmqT4ct1n4Z7JyAdwwI9+r
         H/t5JT9DI+t9shaD8DMt2i7Dxfz/wDJpPm7RoXN3LCrgTuWH3XfNWtSfRUS/YkqyqscC
         b0zTBEELpPSj+4CTC7bkLqoonzXi6shiXxD+sb3dEUcu1FQv304CBLXa7ZtM0XI0dKo3
         G5iWg8dezpXG5OK4vqDzqMlHBCFtPlEch9859KwRFviNI2LDckuSHD65VZPT5/VRGQO9
         j/nILR3sBdwUPRCO3wMib3ZIz6OnVc94P9d+CSMzggHTcE6KmlpvlTefTmj+mnJXy9Hx
         LCvA==
X-Gm-Message-State: APjAAAVxryyRqVn51N0AtquMElgzc5Bkj14Ufh4Ah78q2605U1yEv3nK
        m+C6+Y7SbS6H6y3FTmB3rW9TTg==
X-Google-Smtp-Source: APXvYqzrmZ3kQHepWnFt0I+6NQOsU7O09d0ut41LQbSocXDfWH3ni+fgsZrP3B7AZRVnOzHDf50XmA==
X-Received: by 2002:a62:594b:: with SMTP id n72mr4685114pfb.186.1557405072101;
        Thu, 09 May 2019 05:31:12 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id o20sm1520000pgj.70.2019.05.09.05.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 05:31:11 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] power: supply: ucs1002: Fix checking return value of devm_regmap_init_i2c
Date:   Thu,  9 May 2019 20:30:47 +0800
Message-Id: <20190509123047.27466-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Current code checks wrong return value, it should check info->regmap rather
than info->charger. Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/power/supply/ucs1002_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index 33409b13232a..1c89d030c045 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -508,7 +508,7 @@ static int ucs1002_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	info->regmap = devm_regmap_init_i2c(client, &regmap_config);
-	ret = PTR_ERR_OR_ZERO(info->charger);
+	ret = PTR_ERR_OR_ZERO(info->regmap);
 	if (ret) {
 		dev_err(dev, "Regmap initialization failed: %d\n", ret);
 		return ret;
-- 
2.20.1

