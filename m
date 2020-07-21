Return-Path: <SRS0=i/1K=BA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2440DC433E2
	for <linux-pm@archiver.kernel.org>; Tue, 21 Jul 2020 12:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33772065D
	for <linux-pm@archiver.kernel.org>; Tue, 21 Jul 2020 12:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ib1bZOSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGUMHm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgGUMHm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 08:07:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5451CC0619D8
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2020 05:07:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so6006784wrh.10
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2020 05:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npznphlDVv95ehRrHa25K6/37D7lyoH9vNDTfyrHV8o=;
        b=Ib1bZOSQY4liaBprcJTobQOsSM1ujiVEYXJWHQqVGnvE4yv0tHq72tpitVyrD3KM6D
         ZrTcl+yJEVDMxpdpHRtRa5pIC4GvuWfR+2+4Kkfc7Pkq+2cd/islUOLAEKsAXWuHuEXi
         qaf82L42Fbi1gMCgtsOZY7d1sw2NXVJRNaCK9TKvrHp4pwZcR0tGxl+AOqh8/7VKP2Z6
         o0fR69XozX1GzaPPQFayryxG/6uFGvKUPT4eXMAZZkdAp6Ur2EIztAXnsrAUYK9BNS43
         AiXaeHFqem370oI8xXpUlzQ+4KrVLNuwvbw+Cjw1QybNmoEp8QJ0LfyTqaihMQOcopU8
         tmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npznphlDVv95ehRrHa25K6/37D7lyoH9vNDTfyrHV8o=;
        b=PM9UaJy7VQNAiPWotyMxSXrYxxyUtBY7QRtvye+gH77k0W0nVO+tpaPVLadzq2jS8T
         nDl8IXq7n6RCHQpAAQE4w5bGyU8mMzqIaEYEe56i+uXb9CYtG9hRXiUxHouEyC1a7NlF
         Ipy/TCAVMkUkXuNSd5WBF64YZQ6WRQSZUkpEhbR+OgowjGDW0aW/dTfH3AOQh6pHj1Zv
         puqojH0DWYa6ToAiKL6uoD5p6f3RKJ03Lml/P1vGz+Ag8aVieucwQ1XC9gLi2Pn7whp7
         PxmQBVsEZFReOnmVDyNP9anqABY41pX2hAQISAdRaqxTd0RZ5NMNkaXkPoqoj7ePp0Sd
         jslg==
X-Gm-Message-State: AOAM530XOm/dCk5ojjn9VnaQFozPpg5KWIJnuznCaHXsQQy31QpE3w24
        1x8SRYMkstDOsVGKsEKjfzvtSPg4Ljk=
X-Google-Smtp-Source: ABdhPJzxnd9kirmNWbPJEKL4Bfib1FwwANnT6N/xXtpyF1/9EyPJdf8YHG+4xM/09YW843CWbZiwSA==
X-Received: by 2002:adf:f488:: with SMTP id l8mr11938771wro.123.1595333260721;
        Tue, 21 Jul 2020 05:07:40 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b10sm3057151wmj.30.2020.07.21.05.07.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 05:07:40 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     adhudase@codeaurora.org, okukatla@codeaurora.org, mka@chromium.org,
        linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] interconnect: Do not skip aggregation for disabled paths
Date:   Tue, 21 Jul 2020 15:07:40 +0300
Message-Id: <20200721120740.3436-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When an interconnect path is being disabled, currently we don't aggregate
the requests for it afterwards. But the re-aggregation step shouldn't be
skipped, as it may leave the nodes with outdated bandwidth data. This
outdated data may actually keep the path still enabled and prevent the
device from going into lower power states.

Reported-by: Atul Dhudase <adhudase@codeaurora.org>
Fixes: 7d374b209083 ("interconnect: Add helpers for enabling/disabling a path")
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 37d5ec970cc1..5174dcb31ab7 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -243,6 +243,7 @@ static int aggregate_requests(struct icc_node *node)
 {
 	struct icc_provider *p = node->provider;
 	struct icc_req *r;
+	u32 avg_bw, peak_bw;
 
 	node->avg_bw = 0;
 	node->peak_bw = 0;
@@ -251,9 +252,14 @@ static int aggregate_requests(struct icc_node *node)
 		p->pre_aggregate(node);
 
 	hlist_for_each_entry(r, &node->req_list, req_node) {
-		if (!r->enabled)
-			continue;
-		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
+		if (r->enabled) {
+			avg_bw = r->avg_bw;
+			peak_bw = r->peak_bw;
+		} else {
+			avg_bw = 0;
+			peak_bw = 0;
+		}
+		p->aggregate(node, r->tag, avg_bw, peak_bw,
 			     &node->avg_bw, &node->peak_bw);
 	}
 
