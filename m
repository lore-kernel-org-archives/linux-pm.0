Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AABC433E0
	for <linux-pm@archiver.kernel.org>; Fri,  5 Feb 2021 12:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AAA064FC3
	for <linux-pm@archiver.kernel.org>; Fri,  5 Feb 2021 12:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhBEMym (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 5 Feb 2021 07:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhBEMwh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 07:52:37 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD8C06178C;
        Fri,  5 Feb 2021 04:51:57 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id u16so3321866qvo.9;
        Fri, 05 Feb 2021 04:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44jysrhfwvNRmTpMvVOgVkQrO5vwKN4Np5bGq//+V08=;
        b=OuUxIbjv3QQvW74TKYWKJDsM1aMH2uOxhuDWi4Sf9YIcCQSsa2HoMQbI5nm/hhS4JK
         IWctRpCo07zKaRxCPtJY/ZDpXqg72CGtM+B2p0rbdyI7O92clzlBJ9pncVMngme3xJCb
         w5SE8BGpzuS6Iur43EAm6Km0RI8Jhtrdp7Of2FxkzAriYIHKogtOS7/tyoZopOEpJ39B
         qJYFdHxGQhqGJZKTQFIFyU8bsoIB/1xBXqyudOouKU3G/jAWjHq7bXBv8/0jv2PU01eq
         m0FQKW7eWK9paJ+IjSPlGnxXjWab8DctcDze/+gbCRuBVUzoWIhzhfGb78PhftpCcYcR
         7y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44jysrhfwvNRmTpMvVOgVkQrO5vwKN4Np5bGq//+V08=;
        b=YMP6MkOXWRgYXQHkflFhKK58bScgSvqLC8q+MHuRhQOSbFbJ7Wx2T4vp0VjLMF7wKm
         GSry0ixPWJdSf2ldEqGNnQ9TBbGpzatSNA1zCgcKobNzb6NLQO/0VN185anoQWyv2IJu
         p9uvpYNjJa2KJTdgFSPlui4aytqJ7MLBNz/gRG/oLvD0t5CRpjX8zYCglCUahaLbnkl7
         26d461Kg5pBq1BF5X7NGhZUso49Y0tNqgZH+ZjIhxaY5Fyd8RV33mHNk1tf1LiJvmEGb
         HxY0D/sZwxiy5o0/27QY3lOD4L2jW6qRZLWkEDQZ7SPkTNyCMzLe1nXb3PMS/3dRgFak
         b2WQ==
X-Gm-Message-State: AOAM533EY/W5uOzf3QV0MXOE7CJ9NlgMfrVFz1upTmhZWj6WIdV4pIc0
        7vdJuz+Si6DVljjHUiUDyvg=
X-Google-Smtp-Source: ABdhPJz5Q874NtMaa6VEJzJ+vb7K1l2cxjbgMJfrjZasbMLyCtE9pfE6vKkNNSkv2iuqV2h7xxT62A==
X-Received: by 2002:ad4:45b0:: with SMTP id y16mr4229972qvu.3.1612529516354;
        Fri, 05 Feb 2021 04:51:56 -0800 (PST)
Received: from localhost.localdomain ([138.199.10.106])
        by smtp.gmail.com with ESMTPSA id q22sm5104548qki.51.2021.02.05.04.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 04:51:55 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drivers: cpufreq: Change a word with a word , good one in the file powernow-k7.c
Date:   Fri,  5 Feb 2021 18:21:44 +0530
Message-Id: <20210205125144.1407032-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



s/fucked/messed/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/cpufreq/powernow-k7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 5d515fc34836..2e114fc75e68 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -574,7 +574,7 @@ static int acer_cpufreq_pst(const struct dmi_system_id *d)
 }

 /*
- * Some Athlon laptops have really fucked PST tables.
+ * Some Athlon laptops have really messed PST tables.
  * A BIOS update is all that can save them.
  * Mention this, and disable cpufreq.
  */
--
2.30.0

