Return-Path: <SRS0=FDY0=3G=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2873AC33CB3
	for <linux-pm@archiver.kernel.org>; Fri, 17 Jan 2020 09:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01E421582
	for <linux-pm@archiver.kernel.org>; Fri, 17 Jan 2020 09:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2avq/Wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgAQJ7D (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:59:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54986 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgAQJ6d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 04:58:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so6763893wmj.4
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 01:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qs32CPE+6w8H62hd9kXr/ee/9U4Omu1sZciOmm+hYl8=;
        b=F2avq/WjQTkOblM6OBaohDkNkFC/G/rzHjdCB9gkWGztwFXHHLMQAEUFo437ob2btR
         kbj0Oj3lHdUxPFsEo+CaW1ACvtXvJl2EkqR0VpSmKR0sRe/ImmNVEUpVre4OnXYM99Dq
         magfKT++abV11SaIJD+AYaG245Qw5xjCzho73AwemJ9Fahz3jpPy1PcHaCWITjNYxMn5
         vWs0O9wGbzSCm5biNcq5AlR9vyIynXA5ZO3E9m6H7IsTKX2WSuZtXITmJc4HII84tm+5
         GsHAuhK07k1QXb6MwT9SEEr3kBzbO7JEZYuzojx2szjPkmbzNcGWHuprwGaqWFLbrJW4
         CbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qs32CPE+6w8H62hd9kXr/ee/9U4Omu1sZciOmm+hYl8=;
        b=KQijmd5e15v1L7ZlOkhrxK4MLos9RiAx0t6YzG8pXFOiyvSj16fG/RC1m1DIg0bfBp
         0k5yp1EIWnJITkK683EfwxBdzNnOJubyjVaJm30wFiV/lXxD4hMzRFYwmjweGWlzBYrY
         OzWylzJmlWv8c1Fvkuy+GTyJkARvwNyNVN1E1GvgZ4wByqDq4u++m0oljuMyn4qJ4hKC
         ifChZD31jxRLsKYZJbkiSmsyy5o1JlEXyY9TAxtqGMdGRA1Ht8l3zHfTsuz7NC/Jd5D8
         XFXZ+NTZdGFZQRKx36dJ+bs4FpMZl/hb2JRKTcHf35wCHksExED8GOa0XXzahdKoZXVM
         t1Mw==
X-Gm-Message-State: APjAAAX8c8Xh0r0uyWBk/ZJKaACM5u7hTXFyLUd2PEPCWuWrG8sASbwC
        Y58UrocEDfTlH+ml8o+4MdO21Q==
X-Google-Smtp-Source: APXvYqyd8UlYY4DGVzaOxKU/U/u//HxKkMgytc4CTZO/eE/zbcYiEzSU/sWZAbV5hhhv1BsLkwtrVA==
X-Received: by 2002:a05:600c:2c06:: with SMTP id q6mr3880069wmg.154.1579255111881;
        Fri, 17 Jan 2020 01:58:31 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r62sm9967007wma.32.2020.01.17.01.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 01:58:31 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 10/12] interconnect: Check for valid path in icc_set_bw()
Date:   Fri, 17 Jan 2020 11:58:14 +0200
Message-Id: <20200117095816.23575-11-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use IS_ERR() to ensure that the path passed to icc_set_bw() is valid.

Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 10dde5df9251..f277e467156f 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -495,9 +495,12 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	size_t i;
 	int ret;
 
-	if (!path || !path->num_nodes)
+	if (!path)
 		return 0;
 
+	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
+		return -EINVAL;
+
 	mutex_lock(&icc_lock);
 
 	old_avg = path->reqs[0].avg_bw;
