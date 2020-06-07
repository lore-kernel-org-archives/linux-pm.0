Return-Path: <SRS0=imOP=7U=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E06C433DF
	for <linux-pm@archiver.kernel.org>; Sun,  7 Jun 2020 19:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC0D2067B
	for <linux-pm@archiver.kernel.org>; Sun,  7 Jun 2020 19:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtQay4Q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgFGTAJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 7 Jun 2020 15:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbgFGS5U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323D9C08C5C3;
        Sun,  7 Jun 2020 11:57:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n23so17763549ljh.7;
        Sun, 07 Jun 2020 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ae1m7Ph3kgiom2IEFZ6dxXExK3ejRG1JB/t6vIr/Q3s=;
        b=mtQay4Q9ofUUP33sJvj4zMle5xvDPx3udaiiLallcoLxMfc/4jY4MBs/rgxUtbE/8s
         5iK7PUd7EjTGOFB5ZGFJ4/mfhwcDHYWcA/RwOJeq3E0moenuvYytYcKBpC1Q+Hrz9XPS
         3kEGZOXm/O6FolluFSVQySt6znSfaVMqEutG0Psw44Pt5bDyW7hdL+2XXo9i4uDrNaPX
         aKqJC+nWPql++kAoEjpiK11R3FE8I9V6ZuJPROLdtJlqn6mfhr4M+BaMlXYVMF/L1SnS
         j7RfZhrb6DcQ8N5EgqOfpJGC+dGenobV/OozuHeaLYjos/jdS+PbPjmgNNjy5XykU7Ys
         gTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ae1m7Ph3kgiom2IEFZ6dxXExK3ejRG1JB/t6vIr/Q3s=;
        b=dUAzTPJHOB2YaZ4t+zci6SkW3J0n1mJXyY4T0l5X3jKm79FMvHW2BsISGoTJu4fuHJ
         BMsNQX1JQ3bzcFqZY5D1JDQZTeQHKwUjZ3mUIn/CwR6fTNtp0gYs1p9AbyYjAlSH9NvO
         SnJ4cs5l1+wMATAolSZnvUMPSqFYKIeVAxmcqnhReFqEBiMO7CUR8M1c6NKJtVK91NdM
         kzaxuDrSQVgZ/r/ubGQfOJeUPwVTb23UQ+YGFODbp1sMMDikRrzAZgLHefjjkyrfUks6
         tqtWLQnr4yHCAFpF2Zrr5V3prdCTdbojXyhhFAeoxRdCED5fINZ34vczbZ1eY2WZTPB7
         REcg==
X-Gm-Message-State: AOAM532SG5jLBz+aIT8kB39OseFTk4ZsCxdrMQ21ER0xJ4xeL4PLhi+e
        zUsn08qs+7+bT2oH67P6aU4=
X-Google-Smtp-Source: ABdhPJyXyPjJWmFFPoPBGaAtY7gStNO11rmSiuQdVjRgxt/rUh8kwxXQgH1XhGkcP3rI6EjRdmWxaA==
X-Received: by 2002:a2e:575d:: with SMTP id r29mr5569086ljd.120.1591556238755;
        Sun, 07 Jun 2020 11:57:18 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 07/39] memory: tegra124-emc: Use devm_platform_ioremap_resource
Date:   Sun,  7 Jun 2020 21:54:58 +0300
Message-Id: <20200607185530.18113-8-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Utilize that relatively new helper which makes code a bit cleaner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra124-emc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 95afb0fa4a06..46089ef023a8 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1193,7 +1193,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	struct platform_device *mc;
 	struct device_node *np;
 	struct tegra_emc *emc;
-	struct resource *res;
 	u32 ram_code;
 	int err;
 
@@ -1203,8 +1202,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 
 	emc->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emc->regs = devm_ioremap_resource(&pdev->dev, res);
+	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
 		return PTR_ERR(emc->regs);
 
-- 
2.26.0

