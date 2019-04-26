Return-Path: <SRS0=x0P7=S4=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C51C4321A
	for <linux-pm@archiver.kernel.org>; Fri, 26 Apr 2019 19:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6BA214C6
	for <linux-pm@archiver.kernel.org>; Fri, 26 Apr 2019 19:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2Jq6NeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfDZTPY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:15:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45641 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfDZTPY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Apr 2019 15:15:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so5783818wra.12
        for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2019 12:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WZ/vAAa0X/NtLjj3yurjTJR/c2NdPPFOeqtxoYjAra4=;
        b=e2Jq6NeFOkrkb5tcKAr86K0ml0paks5BSvSabhnLF0W1JZ7gHdDtZNE+KlHn28doMD
         922g01NnvqWh9VTwKH2m0q/gvLtxvCOjKgI6UldT9po5/ISfnoZYWL0YzzwYvEPoEP0l
         X+7/3RSqRdAVsWKS0P5+x01h48FsIbD5twTeSWjHAtjeWSv3KW+kdewko4TP91oqvv4u
         Kn0WDeOaXgcxpoLdtQSMxCYL1QtdH7bYMxA64bE75KNysdcr92KqkzjTG9WgFaPkqeST
         /c+3KLmr3g75wMK/6As1wpBkA/HAGItItZRr9gUr2rPnl06zvpgdwWiJ6dv6TbdOPMBl
         ZAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WZ/vAAa0X/NtLjj3yurjTJR/c2NdPPFOeqtxoYjAra4=;
        b=YYGKZwDw/EVG6ExDnhoPktEHn9v3LLbQPHNS5KqE6F/OFrjyqJLX4Vmji9m/ORfHzu
         m/0Ok39V4iSv8wsBnG6fXM5cE+Lt0lbxUC8IUE7mFs/1TpWQDIxvue7mv7H2hfNqKuZ7
         oSj8H9hPZsgU+z9JHshV5504T770UxxF1NqG8NoPW0UXM9QDiJYtQ0XEDCjTlYF9HB21
         S4SJYQ53xoquWYHR2PC28X0vfqKVSrx2SmzgxOzrrRtDn7PSDMos57sKj24+bV/jNZd0
         rJq19C3K1RtHgqdI1Fy4yyiXXeVjuEZSTvRbBL28y9aqTGHWJ/z1p4wfq81IrnweF65R
         R9OQ==
X-Gm-Message-State: APjAAAXctr/joJcDL/y49nGihGHd9wGgfX1N0BsoZKSijJUTLdEAPfV6
        hQMqfC3k4qEFFwe/Ow2Azj7Z7A==
X-Google-Smtp-Source: APXvYqzzdLlY2dU5lMAVFhz206phB4noYNFjVKpigUWx85PrQrQNdm3T7bg5itIZByQb8RrB97WzbQ==
X-Received: by 2002:adf:9c91:: with SMTP id d17mr6841850wre.285.1556306122664;
        Fri, 26 Apr 2019 12:15:22 -0700 (PDT)
Received: from localhost ([49.248.199.210])
        by smtp.gmail.com with ESMTPSA id v13sm49730975wrg.46.2019.04.26.12.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 12:15:21 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1] thermal: Add some error messages
Date:   Sat, 27 Apr 2019 00:45:15 +0530
Message-Id:
 <640cd0cd93e199459af6d6d04bad228e909faf54.1556305991.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1556305991.git.amit.kucheria@linaro.org>
References: <cover.1556305991.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426191515.3toN34AQIfrW2_oNkw7wl9Gr2aCjdprh_p2wRXlKOIc@z>

When registering a thermal zone device, we currently return -EINVAL in
four cases. This is makes is a little hard to debug the real cause of
the failure.

Print some error messages to make it easier for developer to figure out
what happened.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6590bb5cb688..51cb6d2bf7a2 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1189,17 +1189,26 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	int count;
 	struct thermal_governor *governor;
 
-	if (!type || strlen(type) == 0)
+	if (!type || strlen(type) == 0) {
+		pr_err("Error: No thermal zone type defined");
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
+	if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
+		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars",
+		       type, THERMAL_NAME_LENGTH);
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips)
+	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
+		pr_err("Error: Incorrect number of thermal trips");
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (!ops)
+	if (!ops) {
+		pr_err("Error: Thermal zone device ops not defined");
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
 		return ERR_PTR(-EINVAL);
-- 
2.17.1

