Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7705DC2B9F4
	for <linux-pm@archiver.kernel.org>; Fri, 25 Jun 2021 23:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1B66195D
	for <linux-pm@archiver.kernel.org>; Fri, 25 Jun 2021 23:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFYXwf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 25 Jun 2021 19:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhFYXwf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jun 2021 19:52:35 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D61C061574
        for <linux-pm@vger.kernel.org>; Fri, 25 Jun 2021 16:50:13 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso11134295otu.10
        for <linux-pm@vger.kernel.org>; Fri, 25 Jun 2021 16:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I34DkDhLMaQ/IyLbrDClxn0QZlzBHTfOEHBz/yqlVfc=;
        b=wfjj0O/BibC4pWY5gur3PvLflfcyoYaAOeM3UxN6Xisgx/cH6d2jktONw480QDdXUI
         M8qqhGDOFzE3l2kMi64/+1mtfaYabD7j4LGtbShPO9Zv8nt5+/nauNCnRmpyu2TSsc8I
         ZLwydVAWCbE6hqgfzg+ZqKZhr2zLykmHdtvE61I7a1FngDJvu6zkUNnSExnSEqbR58Dy
         jE+j6vrnpw8YYCDY2xYOGKByZmzviYoBTizD5CbPtuxb2gsTDaRz2V27Q/sNbddt5//Z
         yp1kOjzkMYIGvFxJjCrrqTOOJ2cmbtGZmhJ6fmuttGFzdGiRlufIlyiI4tGMSunbG2fs
         Yw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I34DkDhLMaQ/IyLbrDClxn0QZlzBHTfOEHBz/yqlVfc=;
        b=gmdIGYaf4sCWNp/zo5zuYB/nWI5JkI9TU6rShPPMR+R+ZXsYrMt23DpUMg0agI+XSa
         gmQ8IXkTua0C6wH0dlx5cLOBA2pRng2eOUbDI8Ges95B5iO2BAgrjWW35abq0EulGNGL
         WVAPkIWRnC5iOGoc+pbTUifkWnj0IHFFAsCMMkhHSFzr5TCF8R1eYrozeDpYO6uw1qCP
         WlNhGa5rjP04+qn/tJipJ+pEihD+xbPDoIMXC4hFHZ2hi60U9A50RKqLM4gJ2TCz2Vvt
         Y8BghAS0hcSWa7OS1WQcKJPjNOdHEWVSGMlgbZ1KXFIjqPW2cXl66JQRvjAU+QyoPvNV
         l/1w==
X-Gm-Message-State: AOAM533YBonB1FDPzDrJW3hPv8f4kKtK+ZU9z5pSuwy0XweeG5vjnwn+
        rqSjXlRZ+gkMgmtJgOENCYgfPA==
X-Google-Smtp-Source: ABdhPJw9quTI7eTdpwwKWWqat+ZcFO8Ubt/qtPbjFl3A0ZlFwU3gkX0iv/Xy6pyGJtGQEYPY9RC8nA==
X-Received: by 2002:a05:6830:2112:: with SMTP id i18mr8342838otc.332.1624665012671;
        Fri, 25 Jun 2021 16:50:12 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c205sm1654814oib.20.2021.06.25.16.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 16:50:12 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: Sanity check that node isn't already on list
Date:   Fri, 25 Jun 2021 16:49:03 -0700
Message-Id: <20210625234903.1324755-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Broken interconnect providers might add the same node multiple times or
in multiple providers, which causes strange errors as the provider's
node list is later traversed.

Detect that a node already has an associated provider, complain and
reject the addition of the node, to aid the developer.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/interconnect/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 8a1e70e00876..fcb5d8eefb51 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -959,6 +959,9 @@ EXPORT_SYMBOL_GPL(icc_link_destroy);
  */
 void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 {
+	if (WARN_ON(node->provider))
+		return;
+
 	mutex_lock(&icc_lock);
 
 	node->provider = provider;
-- 
2.29.2

